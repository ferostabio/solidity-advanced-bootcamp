// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Intro {
    function intro() public pure returns (uint16) {
        uint256 mol = 420;

        // Yul assembly magic happens within assembly{} section
        assembly {
            // Load the value of 'mol' into a stack variable.
            let molValue := mol

            // Store molValue at memory location 0x80
            mstore(0x80, molValue)

            // Return the data stored at 0x80. We're returning 32 bytes because Ethereum's word size is 32 bytes.
            // However, since we're returning uint16, Solidity will only consider the last 2 bytes from this.
            return(0x80, 0x20)
        }
    }
}
