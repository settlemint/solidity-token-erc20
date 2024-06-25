// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

/// @title A generic ERC20 Token
/// @dev Extends ERC20 with burnable, pausable, and permit functionalities.
/// @custom:security-contact support@settlemint.com
contract GenericERC20 is ERC20, ERC20Burnable, ERC20Pausable, Ownable, ERC20Permit {
    /// @dev Initializes the contract by setting a `name` and a `symbol` to the token and mints initial tokens to the
    /// deploying address.
    /// @param name The name of the token.
    /// @param symbol The symbol of the token.
    constructor(string memory name, string memory symbol) ERC20(name, symbol) Ownable(msg.sender) ERC20Permit(name) {
        // Mint 100,000 tokens to the deploying address, adjusting for the token's decimals.
        _mint(msg.sender, 100_000 * 10 ** decimals());
    }

    /// @dev Pauses all token transfers.
    /// @notice This function can only be called by the contract owner.
    function pause() public onlyOwner {
        _pause();
    }

    /// @dev Unpauses all token transfers.
    /// @notice This function can only be called by the contract owner.
    function unpause() public onlyOwner {
        _unpause();
    }

    /// @dev Mints `amount` tokens and assigns them to `to`, increasing the total supply.
    /// @param to The address to mint tokens to.
    /// @param amount The number of tokens to be minted.
    /// @notice This function can only be called by the contract owner.
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    /// @dev Overrides the `_update` function of ERC20 and ERC20Pausable to ensure compatibility.
    /// @param from The address from which tokens are transferred.
    /// @param to The address to which tokens are transferred.
    /// @param value The amount of tokens to be transferred.
    function _update(address from, address to, uint256 value) internal override(ERC20, ERC20Pausable) {
        super._update(from, to, value);
    }
}