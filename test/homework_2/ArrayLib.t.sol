// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import {DeployArrayScript} from "../../script/homework_2/DeployArray.s.sol";
import {ArrayContract} from "../../src/homework_2/ArrayContract.sol";

contract ArrayLibTest is Test {
    ArrayContract public arrayContract;

    function setUp() public {
        DeployArrayScript deploy = new DeployArrayScript();
        arrayContract = deploy.run();
        // Could be done in constructor
        arrayContract.initializeNumbers();
    }

    function testRemoveAtIndex() public {
        arrayContract.remove(2);

        assertEq(
            arrayContract.getNumbers().length,
            11,
            "Length should be 10 after removal"
        );
        assertEq(
            arrayContract.getNumbers()[2],
            11,
            "Element at index 2 should now be 11 (swapped with last element)"
        );
    }

    function testRemoveAtIndexKeepingOrder() public {
        arrayContract.removeKeepingOrder(5);
        assertEq(
            arrayContract.getNumbers().length,
            11,
            "Length should be 11 after removal"
        );
        assertEq(
            arrayContract.getNumbers()[5],
            6,
            "Element at index 2 should now be 3"
        );
    }
}
