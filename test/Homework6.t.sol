// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import {DeployHomework6Script} from "../script/DeployHomework6.s.sol";
import {ReturnETHAmount} from "../src/homework_6/ReturnETHAmount.sol";

contract ReturnETHAmountTest is Test {
    ReturnETHAmount public testContract;

    function setUp() public {
        DeployHomework6Script deploy = new DeployHomework6Script();
        testContract = deploy.run();
    }

    function testReturns() public {
        testContract.getSentETH{value: 0.01 ether}();
    }
}
