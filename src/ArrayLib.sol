// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

error IndexOutOfBounds();

library ArrayLib {
    function removeAtIndexKeepingOrder(
        uint[] storage arr,
        uint index
    ) internal {
        if (index >= arr.length) {
            revert IndexOutOfBounds();
        }

        // Shift all items to the left
        for (uint i = index; i < arr.length - 1; i++) {
            arr[i] = arr[i + 1];
        }

        // Remove the last item
        arr.pop();
    }

    function removeAtIndex(uint[] storage arr, uint index) internal {
        if (index >= arr.length) {
            revert IndexOutOfBounds();
        }

        // If it's not the last item, swap it with the last one
        if (index != arr.length - 1) {
            arr[index] = arr[arr.length - 1];
        }

        // Remove the last item
        arr.pop();
    }
}
