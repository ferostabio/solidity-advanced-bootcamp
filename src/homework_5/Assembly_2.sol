// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Add {
    function addAssembly(uint256 x, uint256 y) public pure returns (uint256) {
        uint256 result;

        assembly {
            // Compute the sum of x and y, then store the result in memory at location 0x80
            result := add(x, y)
            mstore(0x80, result)
        }

        assembly {
            // Load the result from memory location 0x80 and return it
            let output := mload(0x80)
            mstore(0x20, output) // standard return location for Solidity
            return(0x20, 0x20) // return data starting at 0x20 and its size (32 bytes)
        }
    }
}
