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
### Deploy Contracts & Run Tasks in your Integrated IDE

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
   - **The Graph - Build & Deploy**: Builds and deploys the subgraph.

### Learn More about Foundry and Hardhat

To fully leverage the capabilities of Foundry and Hardhat, you can explore our comprehensive documentation [here](https://console.settlemint.com/documentation/docs/using-platform/add_smart_contract_sets/smart_contracts/).

## ERC20 Contract Features

This repository includes a customizable ERC20 token contract with the following features:

- **Burnable**: Allows token holders to burn their tokens, reducing the total supply.
- **Pausable**: The contract owner can pause and unpause all token transfers.
- **Permit**: Supports EIP-2612 for approvals via signatures.
- **Mintable**: The owner can mint new tokens.

### Key Functions Overview

- **`pause()`**: Pauses all token transfers. Only callable by the owner.
- **`unpause()`**: Unpauses token transfers. Only callable by the owner.
- **`mint(address to, uint256 amount)`**: Mints new tokens to the specified address. Only callable by the owner.
- **`burn(uint256 amount)`**: Burns a specified amount of tokens from the caller's balance.

## Documentation

- Additional documentation can be found in the [docs folder](./docs).
- [SettleMint Documentation](https://console.settlemint.com/documentation/docs/using-platform/integrated-development-environment/)
- [Foundry Documentation](https://book.getfoundry.sh/)
- [Hardhat Documentation](https://hardhat.org/hardhat-runner/docs/getting-started)
