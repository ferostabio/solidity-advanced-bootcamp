// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import {Intro} from "../src/homework_5/Assembly_1.sol";
import {Add} from "../src/homework_5/Assembly_2.sol";
import {SubOverflow} from "../src/homework_5/Assembly_3.sol";
import {Scope} from "../src/homework_5/Assembly_4.sol";

contract DeployHomework5Script is Script {
    function run()
        public
        returns (Intro intro, Add add, SubOverflow sub, Scope scope)
    {
        vm.startBroadcast();

        Intro _intro = new Intro();
        Add _add = new Add();
        SubOverflow _sub = new SubOverflow();
        Scope _scope = new Scope();

        vm.stopBroadcast();
        return (_intro, _add, _sub, _scope);
    }
}
