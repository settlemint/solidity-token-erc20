<p align="center">
  <img src="https://github.com/settlemint/solidity-token-erc20/blob/main/OG_Solidity.jpg" align="center" alt="logo" />
  <p align="center">
    ✨ <a href="https://settlemint.com">https://settlemint.com</a> ✨
    <br/>
    Build your own blockchain use case with ease.
  </p>
</p>
<br/>
<p align="center">
<a href="https://github.com/settlemint/solidity-token-erc20/actions?query=branch%3Amain"><img src="https://github.com/settlemint/solidity-token-erc20/actions/workflows/solidity.yml/badge.svg?event=push&branch=main" alt="CI status" /></a>
<a href="https://fsl.software" rel="nofollow"><img src="https://img.shields.io/npm/l/@settlemint/solidity-token-erc20" alt="License"></a>
<a href="https://www.npmjs.com/package/@settlemint/solidity-token-erc20" rel="nofollow"><img src="https://img.shields.io/npm/dw/@settlemint/solidity-token-erc20" alt="npm"></a>
<a href="https://github.com/settlemint/solidity-token-erc20" rel="nofollow"><img src="https://img.shields.io/github/stars/settlemint/solidity-token-erc20" alt="stars"></a>
</p>

<div align="center">
  <a href="https://console.settlemint.com/documentation/">Documentation</a>
  <span>&nbsp;&nbsp;•&nbsp;&nbsp;</span>
  <a href="https://discord.com/invite/Mt5yqFrey9">Discord</a>
  <span>&nbsp;&nbsp;•&nbsp;&nbsp;</span>
  <a href="https://www.npmjs.com/package/@settlemint/solidity-token-erc20">NPM</a>
  <span>&nbsp;&nbsp;•&nbsp;&nbsp;</span>
  <a href="https://github.com/settlemint/solidity-token-erc20/issues">Issues</a>
  <br />
</div>

## Get Started

This repository provides a generic ERC20 token contract with functionalities like burning, pausing, and permits. You can either:

- **Launch this smart contract set directly in SettleMint**: Under the `Smart Contract Sets` section. This will automatically link the contract to your blockchain node and use the private keys stored in the platform.
  
  For detailed instructions on deploying smart contracts using SettleMint, refer to this [deployment guide](https://console.settlemint.com/documentation/docs/using-platform/add_smart_contract_sets/deploying_a_contract/).

- **Integrate it into your own project**:
  - Bootstrap a new project using Forge:
    ```shell
    forge init my-project --template settlemint/solidity-token-erc20
    ```
  - Or, add it as a dependency to your existing project using npm:
    ```shell
    npm install @settlemint/solidity-token-erc20
    ```
### Deploy Contracts & Run Tasks in your Settlemint Integrated IDE

Using SettleMint’s Integrated IDE, you can easily run tasks like compiling, testing, and deploying your contracts. Here’s how to get started:

1. Open the Tasks panel by pressing `Cmd + Shift + P` (Mac) or `Ctrl + Shift + P` (Windows/Linux) or by selecting it from the left menu.
2. Select the desired task from the list. Available tasks include:

   - **Foundry - Compile**: Compiles the Foundry contracts.
   - **Hardhat - Compile**: Compiles the Hardhat contracts.
   - **Foundry - Test**: Runs tests using Foundry.
   - **Hardhat - Test**: Runs tests using Hardhat.
   - **Foundry - Start Network**: Starts a local Ethereum network using Foundry.
   - **Hardhat - Start Network**: Starts a local Ethereum network using Hardhat.
   - **Hardhat - Deploy to Local Network**: Deploys contracts to a local network.
   - **Hardhat - Deploy to Platform Network**: Deploys contracts to the specified platform network.
   - **The Graph - Codegen the subgraph types**: Codegen the subgraph types: Generates the necessary types for The Graph subgraph.
   - **The Graph - Build the subgraph**:  Builds the subgraph.
   - **The Graph - Build & Deploy**: Builds and deploys the subgraph.
  
Alternatively, you can use the IDE terminal and deploy your contract using common commands from [Hardhat](https://hardhat.org/ignition/docs/guides/deploy) or [Foundry](https://book.getfoundry.sh/forge/deploying).

### Learn More about Foundry and Hardhat

To fully leverage the capabilities of Foundry and Hardhat, you can explore our comprehensive documentation [here](https://console.settlemint.com/documentation/docs/using-platform/add_smart_contract_sets/smart_contracts/).


### ERC20 Contract Features

This ERC20 token contract, built on OpenZeppelin’s industry-standard libraries, offers the following capabilities:

- **Mintable**: Allows the contract owner to generate new tokens.
- **Burnable**: Token holders can permanently destroy their tokens, reducing the total supply.
- **Pausable**: The contract owner can temporarily halt and later resume all token transfers.
- **Permit**: Implements EIP-2612 for token approvals via cryptographic signatures, enabling gasless transactions.

### Key Functions

- **`pause()` / `unpause()`**: Empowers the owner to suspend and restore token transfers as needed.
- **`mint(address to, uint256 amount)`**: Creates and allocates new tokens to a specified address.
- **`burn(uint256 amount)`**: Reduces the token supply by burning tokens from the caller’s balance.
- **`_update(address from, address to, uint256 value)`**: Ensures seamless interaction between transfer operations and pausing mechanisms.

### OpenZeppelin Libraries Utilized

This contract integrates the following OpenZeppelin components:

- **ERC20**: A robust implementation of the ERC20 token standard.
- **ERC20Burnable**: Facilitates the burning of tokens by holders.
- **ERC20Pausable**: Adds functionality to pause and resume token operations.
- **ERC20Permit**: Supports EIP-2612 for efficient off-chain approvals.
- **Ownable**: Provides ownership and access control, ensuring only authorized actions by the contract owner.


## Documentation

- Additional documentation can be found in the [docs folder](./docs).
- [SettleMint Documentation](https://console.settlemint.com/documentation/docs/using-platform/integrated-development-environment/)
- [Foundry Documentation](https://book.getfoundry.sh/)
- [Hardhat Documentation](https://hardhat.org/hardhat-runner/docs/getting-started)
