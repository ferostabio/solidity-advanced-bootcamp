// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import {DeployHomework3Script} from "../script/DeployHomework3.s.sol";
import {UpgradeableContract} from "../src/homework_3/UpgradeableContract.sol";
import {UpgradeableContractV2} from "../src/homework_3/UpgradeableContractV2.sol";
import {UUPSProxy} from "../src/homework_3/UUPSProxy.sol";

contract ArrayLibTest is Test {
    UUPSProxy proxy;
    UpgradeableContract wrappedProxyV1;
    UpgradeableContractV2 wrappedProxyV2;

    function setUp() public {
        DeployHomework3Script script = new DeployHomework3Script();
        proxy = script.run();

        wrappedProxyV1 = UpgradeableContract(address(proxy));

        wrappedProxyV1.initialize(100);
    }

    function testCanInitialize() public {
        assertEq(wrappedProxyV1.x(), 100);
        assertEq(wrappedProxyV1.getVersion(), 1);
    }

    function testCanUpgrade() public {
        UpgradeableContractV2 implementationV2 = new UpgradeableContractV2();
        wrappedProxyV1.upgradeToAndCall(address(implementationV2), "");

        // Re-wrap the proxy
        wrappedProxyV2 = UpgradeableContractV2(address(proxy));

        assertEq(wrappedProxyV2.x(), 100);
        assertEq(wrappedProxyV2.y(), 0);

        wrappedProxyV2.setY(200);
        assertEq(wrappedProxyV2.y(), 200);
        assertEq(wrappedProxyV1.getVersion(), 2);
        assertEq(wrappedProxyV2.getVersion(), 2);
    }
}
