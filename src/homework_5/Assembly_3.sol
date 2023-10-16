// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SubOverflow {
    function subtract(uint256 x, uint256 y) public pure returns (uint256) {
        assembly {
            // Check if x < y
            if lt(x, y) {
                // If true, set the result to 0
                let result := 0
                mstore(0x20, result)
                return(0x20, 0x20)
            }

            // Otherwise, perform the subtraction and return the result
            let result := sub(x, y)
            mstore(0x20, result)
            return(0x20, 0x20)
        }
    }
}
