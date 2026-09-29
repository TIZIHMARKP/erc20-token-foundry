// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {ERC20Token} from "../src/token.sol";

contract Deploy is Script {
    function run() public {
        vm.startBroadcast();

        ERC20Token token = new ERC20Token("TestDeployToken", "TDT", 1000);

        console.log("Token deployed at: ", address(token));
        console.log("Total supply 1: ", token.totalSupply());
        console.log("Total supply 2: ", token.totalSupply() / 10 ** 18);
        console.log("Owner balance 1: ", token.balanceOf(msg.sender));
        console.log("Owner balance: 2", token.balanceOf(msg.sender) / 10 ** 18);

        vm.stopBroadcast();
    }
}
