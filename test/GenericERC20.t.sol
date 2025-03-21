// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../contracts/GenericERC20.sol";
import { Pausable } from "@openzeppelin/contracts/utils/Pausable.sol";
import { IERC20Errors } from "@openzeppelin/contracts/interfaces/draft-IERC6093.sol";

contract GenericERC20Test is Test {
    GenericERC20 token;
    address owner;
    address recipient;

    function setUp() public {
        owner = address(this);
        recipient = address(0x1);
        token = new GenericERC20("GenericToken", "GT");
    }

    function testInitialMint() public view {
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

    function test_RevertOnMintWhenPaused() public {
        token.pause();
        uint256 mintAmount = 1000 * 10 ** token.decimals();
        vm.expectRevert(abi.encodeWithSelector(Pausable.EnforcedPause.selector));
        token.mint(owner, mintAmount); // This should fail
    }

    function testBurn() public {
        uint256 burnAmount = 1000 * 10 ** token.decimals();
        token.burn(burnAmount);
        uint256 newOwnerBalance = token.balanceOf(owner);
        assertEq(newOwnerBalance, 99_000 * 10 ** token.decimals());
    }

    function test_RevertOnBurnMoreThanBalance() public {
        uint256 burnAmount = 200_000 * 10 ** token.decimals();
        vm.expectRevert(
            abi.encodeWithSelector(
                IERC20Errors.ERC20InsufficientBalance.selector, owner, 100_000 * 10 ** token.decimals(), burnAmount
            )
        );
        token.burn(burnAmount); // This should fail
    }
}
