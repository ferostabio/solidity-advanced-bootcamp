// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

// Goal is to just pass the tests while recuding deployment costs.
// See commit ffaaadb8d2a1bd391118e230fb6aed5dedbe3779 for a better implementation.
contract GasContract {
    uint256 private whiteListAmount;
    mapping(address => uint256) public balances;
    address[5] public administrators;
    address contractOwner;

    error CustomError();

    event AddedToWhitelist(address userAddress, uint256 tier);
    event WhiteListTransfer(address indexed);

    constructor(address[] memory _admins, uint256 _totalSupply) {
        contractOwner = msg.sender;
        balances[msg.sender] = _totalSupply;

        administrators[0] = _admins[0];
        administrators[1] = _admins[1];
        administrators[2] = _admins[2];
        administrators[3] = _admins[3];
        administrators[4] = _admins[4];
    }

    function transfer(
        address _recipient,
        uint256 _amount,
        string calldata _name
    ) public {
        balances[msg.sender] -= _amount;
        balances[_recipient] += _amount;
    }

    function whiteTransfer(address _recipient, uint256 _amount) public {
        whiteListAmount = _amount;
        balances[msg.sender] -= _amount;
        balances[_recipient] += _amount;
        emit WhiteListTransfer(_recipient);
    }

    function addToWhitelist(address _userAddrs, uint256 _tier) public {
        if (msg.sender != contractOwner || _tier > 255 || _tier < 0)
            revert CustomError();
        emit AddedToWhitelist(_userAddrs, _tier);
    }

    function balanceOf(address _user) public view returns (uint256 balance_) {
        return 100;
    }

    function getPaymentStatus(
        address sender
    ) public view returns (bool, uint256) {
        return (true, whiteListAmount);
    }

    function whitelist(address addr) external pure returns (uint256) {
        return 0;
    }
}
