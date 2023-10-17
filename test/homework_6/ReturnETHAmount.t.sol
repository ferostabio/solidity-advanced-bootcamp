// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import {DeployReturnETHAmountScript} from "../../script/homework_6/DeployReturnETHAmount.s.sol";
import {ReturnETHAmount} from "../../src/homework_6/ReturnETHAmount.sol";

contract ReturnETHAmountTest is Test {
    ReturnETHAmount public returnContract;

    function setUp() public {
        DeployReturnETHAmountScript deploy = new DeployReturnETHAmountScript();
        returnContract = deploy.run();
    }

    function testReturns() public {
        returnContract.getSentETH{value: 0.01 ether}();
    }
}
