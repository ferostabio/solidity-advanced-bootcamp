// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import {DeployHomework5Script} from "../script/DeployHomework5.s.sol";
import {Intro} from "../src/homework_5/Assembly_1.sol";
import {Add} from "../src/homework_5/Assembly_2.sol";
import {SubOverflow} from "../src/homework_5/Assembly_3.sol";
import {Scope} from "../src/homework_5/Assembly_4.sol";

contract ArrayLibTest is Test {
    Intro public introContract;
    Add public addContract;
    SubOverflow public subContract;
    Scope public scopeContract;

    function setUp() public {
        DeployHomework5Script deploy = new DeployHomework5Script();
        (Intro intro, Add add, SubOverflow sub, Scope scope) = deploy.run();
        introContract = intro;
        addContract = add;
        subContract = sub;
        scopeContract = scope;
    }

    function testIntro() public {
        assertEq(introContract.intro(), 420, "Intro should return 420");
    }

    function testAdd() public {
        assertEq(addContract.addAssembly(1, 2), 3, "Add should return 3");
    }

    function testSubOverflow() public {
        assertEq(subContract.subtract(1, 2), 0, "Subtract should return 0");
        assertEq(subContract.subtract(4, 2), 2, "Subtract should return 2");
    }

    function testScope() public {
        assertEq(scopeContract.count(), 10, "Count should be 10");
        scopeContract.increment(5);
        assertEq(scopeContract.count(), 15, "Count should be 15");
    }
}
