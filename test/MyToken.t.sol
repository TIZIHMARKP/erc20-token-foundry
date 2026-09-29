// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {ERC20Token} from "../src/token.sol";

contract MyTestToken is Test {
    ERC20Token public token;
    address public owner = address(1);
    address public user1 = address(2);
    address public user2 = address(3);

    function setUp() public {
        vm.prank(owner);
        token = new ERC20Token("TestToken", "TT", 1000); // _name, _symbol and _initialSupply

    }

    function test_Deployment() public view {
        assertEq(token.name(), "TestToken");
        assertEq(token.symbol(), "TT");
        assertEq(token.totalSupply(), 1000 * 10 ** 18);
        assertEq(token.balanceOf(owner), 1000 * 10 ** 18);
    }

    function test_Transfer() public {
        vm.prank(owner);
        token.transfer(user1, 100 * 10 ** 18);
        assertEq(token.balanceOf(owner), 900 * 10 ** 18);
        assertEq(token.balanceOf(user1), 100 * 10 ** 18);
    }

    function test_Transfer_InsufficientBalance() public {
        vm.prank(user1);
        vm.expectRevert("Not enough balance");
        token.transfer(user2, 1000 * 10 ** 18);
    }

    function test_Transfer_ToZeroAddress_Reverts() public{
        vm.prank(owner);
        vm.expectRevert("ERC20: transfer from the zero address");
        token.transfer(address(0), 1 * 10 ** 18);
    }

}


