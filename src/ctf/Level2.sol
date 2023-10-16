// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

contract Level2 {
    function solution(
        uint256[10] calldata unsortedArray
    ) external pure returns (uint256[10] memory sortedArray) {
        sortedArray = unsortedArray;

        for (uint256 i = 1; i < 10; i++) {
            uint256 key = sortedArray[i];
            uint256 j = i;
            while (j > 0 && sortedArray[j - 1] > key) {
                sortedArray[j] = sortedArray[j - 1];
                j--;
            }
            sortedArray[j] = key;
        }
    }
}
