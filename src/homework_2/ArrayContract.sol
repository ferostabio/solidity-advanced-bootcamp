// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./ArrayLib.sol";

error ArrayAlreadyInitialized();

contract ArrayContract {
    using ArrayLib for uint[];

    uint[] public numbers;

    // Function to initialize the array from 0 to 12
    function initializeNumbers() external {
        if (numbers.length > 0) {
            revert ArrayAlreadyInitialized();
        }

        for (uint i = 0; i < 12; i++) {
            numbers.push(i);
        }
    }

    // Utilize library functions
    function removeKeepingOrder(uint index) external {
        numbers.removeAtIndexKeepingOrder(index);
    }

    function remove(uint index) external {
        numbers.removeAtIndex(index);
    }

    // Getter function
    function getNumbers() public view returns (uint[] memory) {
        return numbers;
    }
}
