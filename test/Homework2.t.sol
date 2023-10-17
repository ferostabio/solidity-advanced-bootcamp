// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import {DeployHomework2Script} from "../script/DeployHomework2.s.sol";
import {ArrayContract} from "../src/homework_2/ArrayContract.sol";

contract Homework2Test is Test {
    ArrayContract public testContract;

    function setUp() public {
        DeployHomework2Script deploy = new DeployHomework2Script();
        testContract = deploy.run();
        // Could be done in constructor
        testContract.initializeNumbers();
    }

    function testRemoveAtIndex() public {
        testContract.remove(2);

        assertEq(
            testContract.getNumbers().length,
            11,
            "Length should be 10 after removal"
        );
        assertEq(
            testContract.getNumbers()[2],
            11,
            "Element at index 2 should now be 11 (swapped with last element)"
        );
    }

    function testRemoveAtIndexKeepingOrder() public {
        testContract.removeKeepingOrder(5);
        assertEq(
            testContract.getNumbers().length,
            11,
            "Length should be 11 after removal"
        );
        assertEq(
            testContract.getNumbers()[5],
            6,
            "Element at index 2 should now be 3"
        );
    }
}
