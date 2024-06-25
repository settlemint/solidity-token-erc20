// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../contracts/GenericERC20.sol";

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

      function testBurn() public {
        uint256 burnAmount = 1000 * 10 ** token.decimals();
        token.burn(burnAmount);
        uint256 newOwnerBalance = token.balanceOf(owner);
        assertEq(newOwnerBalance, 99_000 * 10 ** token.decimals());
    }

    function testFailBurnMoreThanBalance() public {
        uint256 burnAmount = 200_000 * 10 ** token.decimals();
        vm.expectRevert("ERC20: burn amount exceeds balance");
        token.burn(burnAmount); // This should fail
    }

}