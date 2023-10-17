// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import {ReturnETHAmount} from "../src/homework_6/ReturnETHAmount.sol";

contract DeployHomework6Script is Script {
    function setUp() public {}

    function run() public returns (ReturnETHAmount) {
        vm.startBroadcast();
        ReturnETHAmount cont = new ReturnETHAmount();
        vm.stopBroadcast();
        return cont;
    }
}
