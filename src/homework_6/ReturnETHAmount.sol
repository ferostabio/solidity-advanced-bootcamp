// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ReturnETHAmount {
    function getSentETH() external payable returns (uint256 amount) {
        assembly {
            amount := callvalue()
        }
    }
}
