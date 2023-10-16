// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Scope {
    uint256 public count = 10;

    function increment(uint256 num) public {
        assembly {
            // Load current value of count
            let currentValue := sload(count.slot)

            // Add num to the current value
            let updatedValue := add(currentValue, num)

            // Store updated value back to count
            sstore(count.slot, updatedValue)
        }
    }
}
