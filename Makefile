# Makefile for Foundry Ethereum Development Toolkit

.PHONY: build test format snapshot anvil deploy deploy-anvil cast help subgraph

build:
	@echo "Building with Forge..."
	@forge build

test:
	@echo "Testing with Forge..."
	@forge test

format:
	@echo "Formatting with Forge..."
	@forge fmt

snapshot:
	@echo "Creating gas snapshot with Forge..."
	@forge snapshot

anvil:
	@echo "Starting Anvil local Ethereum node..."
	@anvil

deploy-anvil:
	@echo "Deploying with Forge to Anvil..."
	@forge create ./src/GenericERC20.sol:GenericERC20 --rpc-url anvil --interactive --constructor-args "GenericToken" "GT" | tee deployment-anvil.txt

deploy:
	@eval $$(curl -H "x-auth-token: $${BPT_SERVICE_TOKEN}" -s $${BTP_CLUSTER_MANAGER_URL}/ide/foundry/$${BTP_SCS_ID}/env | sed 's/^/export /')
	@if [ -z "${ETH_FROM}" ]; then \
		echo "\033[1;33mWARNING: No keys are activated on the node, falling back to interactive mode...\033[0m"; \
		echo ""; \
		forge create ./src/GenericERC20.sol:GenericERC20 ${EXTRA_ARGS} --rpc-url ${BTP_RPC_URL} --interactive --constructor-args "GenericToken" "GT" | tee deployment.txt; \
	else \
		forge create ./src/GenericERC20.sol:GenericERC20 ${EXTRA_ARGS} --rpc-url ${BTP_RPC_URL} --unlocked --constructor-args "GenericToken" "GT" | tee deployment.txt; \
	fi

cast:
	@echo "Interacting with EVM via Cast..."
	@cast $(SUBCOMMAND)

subgraph:
	@echo "Deploying the subgraph..."
	@rm -Rf subgraph/subgraph.config.json
	@DEPLOYED_ADDRESS=$$(grep "Deployed to:" deployment.txt | awk '{print $$3}') yq e -p=json -o=json '.datasources[0].address = env(DEPLOYED_ADDRESS) | .chain = env(BTP_NETWORK_NAME)' subgraph/subgraph.config.template.json > subgraph/subgraph.config.json
	@cd subgraph && pnpm graph-compiler --config subgraph.config.json --include node_modules/@openzeppelin/subgraphs/src/datasources subgraph/datasources --export-schema --export-subgraph
	@cd subgraph && yq e '.specVersion = "0.0.4"' -i generated/solidity-token-erc20.subgraph.yaml
	@cd subgraph && yq e '.description = "Solidity Token ERC20"' -i generated/solidity-token-erc20.subgraph.yaml
	@cd subgraph && yq e '.repository = "https://github.com/settlemint/solidity-token-erc20"' -i generated/solidity-token-erc20.subgraph.yaml
	@cd subgraph && yq e '.indexerHints.prune = "auto"' -i generated/solidity-token-erc20.subgraph.yaml
	@cd subgraph && yq e '.features = ["nonFatalErrors", "fullTextSearch", "ipfsOnEthereumContracts"]' -i generated/solidity-token-erc20.subgraph.yaml
	@cd subgraph && pnpm graph codegen generated/solidity-token-erc20.subgraph.yaml
	@cd subgraph && pnpm graph build generated/solidity-token-erc20.subgraph.yaml
	@eval $$(curl -H "x-auth-token: $${BPT_SERVICE_TOKEN}" -s $${BTP_CLUSTER_MANAGER_URL}/ide/foundry/$${BTP_SCS_ID}/env | sed 's/^/export /')
	@if [ "$${BTP_MIDDLEWARE}" == "" ]; then \
		echo "You have not launched a graph middleware for this smart contract set, aborting..."; \
		exit 1; \
	else \
		cd subgraph; \
		pnpm graph create --node $${BTP_MIDDLEWARE} $${BTP_SCS_NAME}; \
		pnpm graph deploy --version-label v1.0.$$(date +%s) --node $${BTP_MIDDLEWARE} --ipfs $${BTP_IPFS}/api/v0 $${BTP_SCS_NAME} generated/solidity-token-erc20.subgraph.yaml; \
	fi

help:
	@echo "Forge help..."
	@forge --help
	@echo "Anvil help..."
	@anvil --help
	@echo "Cast help..."
	@cast --help
