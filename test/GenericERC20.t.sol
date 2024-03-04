// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/GenericERC20.sol";

contract GenericERC20Test is Test {
    GenericERC20 token;
    address owner;
    address recipient;

    function setUp() public {
        owner = address(this);
        recipient = address(0x1);
        token = new GenericERC20("GenericToken", "GT");
    }

    function testInitialMint() public {
        uint256 ownerBalance = token.balanceOf(owner);
        assertEq(ownerBalance, 100_000 * 10 ** token.decimals());
    }

    function testMint() public {
        uint256 mintAmount = 1000 * 10 ** token.decimals();
        token.mint(owner, mintAmount);
        uint256 newOwnerBalance = token.balanceOf(owner);
        assertEq(newOwnerBalance, 101_000 * 10 ** token.decimals());
    }

    function testPauseUnpause() public {
        token.pause();
        assertTrue(token.paused());

        token.unpause();
        assertFalse(token.paused());
    }

    function testFailMintWhenPaused() public {
        token.pause();
        uint256 mintAmount = 1000 * 10 ** token.decimals();
        token.mint(owner, mintAmount); // This should fail
    }

    // Fuzz Testing
    function testFuzzMint(address _to, uint256 _amount) public {
        // Ensure the contract is not paused for this test
        if (token.paused()) {
            token.unpause();
        }

        // Add a precondition to skip tests with the zero address
        if (_to == address(0)) return;

        uint256 initialBalance = token.balanceOf(_to);

        // Prevent extremely large values for _amount to avoid overflow
        uint256 mintAmount = _amount % (10 ** 18);
        token.mint(_to, mintAmount);

        uint256 newBalance = token.balanceOf(_to);
        assertEq(newBalance, initialBalance + mintAmount, "Minting did not increase balance correctly");
    }

    function testFuzzTransfer(address _from, address _to, uint256 _amount) public {
        // Ensure neither address is the zero address
        if (_from == address(0) || _to == address(0)) return;

        // Mint tokens to the _from address before transferring
        uint256 mintAmount = 1e21; // Adjust as necessary
        token.mint(_from, mintAmount);

        // Get initial balances
        uint256 initialBalanceFrom = token.balanceOf(_from);
        uint256 initialBalanceTo = token.balanceOf(_to);

        // Perform the transfer
        vm.prank(_from);
        token.transfer(_to, _amount);

        // Get final balances
        uint256 finalBalanceFrom = token.balanceOf(_from);
        uint256 finalBalanceTo = token.balanceOf(_to);

        // Check that the final balances are correct
        assertEq(finalBalanceFrom, initialBalanceFrom - _amount, "Incorrect final balance for sender");
        assertEq(finalBalanceTo, initialBalanceTo + _amount, "Transfer did not result in correct final balance");
    }
}
