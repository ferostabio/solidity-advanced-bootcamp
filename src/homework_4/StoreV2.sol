// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

contract StoreV3 {
    struct payments {
        uint256 amount;
        uint256 initialAmount;
        uint256 finalAmount;
        uint8 paymentType;
        bool valid;
        bool checked;
        address receiver;
        address sender;
    }
    uint256 public number;
    uint8 index;
    bool flag1;
    bool flag2;
    bool flag3;
    address admin;
    mapping(address => uint256) balances;
    address admin2;
    payments[8] topPayments;

    constructor() {}

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }
}
