// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Deploy1 {
    uint256 public value1;

    constructor() {
        value1 = 17;
    }

    function read() public view returns (uint256) {
        return value1;
    }

    // Function to demonstrate the Yul operations
    function yulAddAndStore() public pure {
        assembly {
            let x := 0x07
            let y := 0x08
            let result := add(x, y)
            mstore(0x80, result) // Storing at fixed memory location 0x80
        }
    }

    // This function returns the result stored at memory location 0x80
    function getResultFromMemory() public pure returns (uint256) {
        uint256 result;
        assembly {
            result := mload(0x80)
        }
        return result;
    }
}
