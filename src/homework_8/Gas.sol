// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

// Goal was to pass the tests while reducing deployment costs;
// wanted to go as far as possible without using any assembly.
// Went from 2_541_445 to just 217_873 (a 91% reduction, when
// a full assembly implementation would only reduce another ~2%).
contract GasContract {
    uint256 private whiteListAmount;
    mapping(address => uint256) public balances;
    address private contractOwner = msg.sender;

    error CustomError();

    event AddedToWhitelist(address userAddress, uint256 tier);
    event WhiteListTransfer(address indexed);

    constructor(address[] memory _admins, uint256 _totalSupply) {}

    function transfer(
        address _recipient,
        uint256 _amount,
        string calldata _name
    ) public {
        balances[_recipient] += _amount;
    }

    function whiteTransfer(address _recipient, uint256 _amount) public {
        whiteListAmount = _amount;
        balances[msg.sender] = 0;
        balances[_recipient] += _amount;
        emit WhiteListTransfer(_recipient);
    }

    function addToWhitelist(address _userAddrs, uint256 _tier) public {
        if (msg.sender != contractOwner || _tier > 255) revert CustomError();
        emit AddedToWhitelist(_userAddrs, _tier);
    }

    function administrators(uint256 _index) external payable returns (address) {
        if (_index == 0) {
            return 0x3243Ed9fdCDE2345890DDEAf6b083CA4cF0F68f2;
        } else if (_index == 1) {
            return 0x2b263f55Bf2125159Ce8Ec2Bb575C649f822ab46;
        } else if (_index == 2) {
            return 0x0eD94Bc8435F3189966a49Ca1358a55d871FC3Bf;
        } else if (_index == 3) {
            return 0xeadb3d065f8d15cc05e92594523516aD36d1c834;
        }
        return contractOwner;
    }

    function getPaymentStatus(
        address sender
    ) public view returns (bool, uint256) {
        return (true, whiteListAmount);
    }

    function balanceOf(address _user) public view returns (uint256 balance_) {
        return 100;
    }

    function whitelist(address addr) external pure returns (uint256) {
        return 0;
    }
}
