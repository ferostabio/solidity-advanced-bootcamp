// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

interface Isolution3 {
    function solution(
        bytes memory packed
    ) external pure returns (uint16 a, bool b, bytes6 c);
}

contract Level3Template is Isolution3 {
    function solution(
        bytes memory packed
    ) external pure override returns (uint16 a, bool b, bytes6 c) {
        require(packed.length == 9, "Invalid packed data length");

        assembly {
            // Load the first 2 bytes into 'a'
            a := shr(240, mload(add(packed, 0x20)))

            // Load the next 1 byte, shift left and check if it's non-zero for 'b'
            b := iszero(
                iszero(
                    and(
                        0xFF00000000000000000000000000000000000000000000000000000000000000,
                        mload(add(packed, 0x20))
                    )
                )
            )

            // Load the next 6 bytes into 'c'
            c := mload(add(packed, 3))
        }
    }
}
