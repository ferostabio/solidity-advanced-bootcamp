// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import {ArrayContract} from "../../src/homework_2/ArrayContract.sol";

contract DeployArrayScript is Script {
    function setUp() public {}

    function run() public returns (ArrayContract) {
        vm.startBroadcast();
        ArrayContract arr = new ArrayContract();
        vm.stopBroadcast();
        return arr;
    }
}
