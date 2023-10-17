// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import {UpgradeableContract} from "../src/homework_3/UpgradeableContract.sol";
import {UUPSProxy} from "../src/homework_3/UUPSProxy.sol";

contract DeployHomework3Script is Script {
    function run() public returns (UUPSProxy _proxy) {
        vm.startBroadcast();
        UpgradeableContract implementationV1 = new UpgradeableContract();

        // Deploy proxy contract and point it to implementation
        UUPSProxy proxy = new UUPSProxy(address(implementationV1), "");

        vm.stopBroadcast();
        return proxy;
    }
}
