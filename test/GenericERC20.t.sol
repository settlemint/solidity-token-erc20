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
        // Skip tests that attempt to transfer to the zero address
        if (_to == address(0)) return;

        // Setup: Ensure _from has tokens to transfer
        uint256 setupAmount = 1000 * 10 ** token.decimals();
        token.mint(_from, setupAmount);

        // Prevent extremely large values for _amount to avoid overflow and ensure it's less than setupAmount
        uint256 transferAmount = _amount % setupAmount;
        vm.prank(_from); // Forge's way to simulate calls from specific addresses
        token.transfer(_to, transferAmount);

        uint256 finalBalance = token.balanceOf(_to);
        assertEq(finalBalance, transferAmount, "Transfer did not result in correct final balance");
    }
}
