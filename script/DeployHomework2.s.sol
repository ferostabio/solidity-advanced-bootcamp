// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import {ArrayContract} from "../src/homework_2/ArrayContract.sol";

contract DeployHomework2Script is Script {
    function setUp() public {}

    function run() public returns (ArrayContract) {
        vm.startBroadcast();
        ArrayContract arr = new ArrayContract();
        vm.stopBroadcast();
        return arr;
    }
}
