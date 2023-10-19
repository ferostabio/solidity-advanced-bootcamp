// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

contract GasContract {
    uint256 public totalSupply = 0; // cannot be updated
    uint256 wasLastOdd = 1;
    mapping(address => uint256) public balances;
    mapping(address => uint256) public whitelist;
    mapping(address => uint256) isOddWhitelistUser;
    mapping(address => uint256 amount) whiteListAmount;
    mapping(address => bool) isAdmin;
    address[5] public administrators;
    address contractOwner;

    error UserIsNotAdminOrOwner();
    error OriginatorIsNotSender();
    error UserIsNotWhitelisted();
    error InvalidAdminAddress();
    error UserMustHaveValidAddress();
    error SenderHasInsufficientBalance();
    error RecipientNameTooLong();
    error IDMustBeGreaterThanZero();
    error AmountMustBeGreaterThanZero();
    error TierTooHigh();
    error AmountTooLow();
    error Rekt();

    event AddedToWhitelist(address userAddress, uint256 tier);
    event WhiteListTransfer(address indexed);

    constructor(address[] memory _admins, uint256 _totalSupply) {
        contractOwner = msg.sender;
        totalSupply = _totalSupply;

        for (uint256 ii = 0; ii < administrators.length; ii++) {
            if (_admins[ii] != address(0)) {
                administrators[ii] = _admins[ii];
                isAdmin[_admins[ii]] = true; // Set the address as an admin in the mapping

                if (_admins[ii] == contractOwner) {
                    balances[contractOwner] = totalSupply;
                } else {
                    balances[_admins[ii]] = 0;
                }
            }
        }
    }

    modifier onlyAdminOrOwner() {
        address senderOfTx = msg.sender;
        if (checkForAdmin(senderOfTx)) {
            _;
        } else if (senderOfTx == contractOwner) {
            _;
        } else {
            revert UserIsNotAdminOrOwner();
        }
    }

    modifier checkIfWhiteListed(address sender) {
        uint256 usersTier = whitelist[msg.sender];
        if (usersTier == 0) revert UserIsNotWhitelisted();
        if (usersTier > 3) revert TierTooHigh();
        _;
    }

    function transfer(
        address _recipient,
        uint256 _amount,
        string calldata _name
    ) public {
        if (_recipient == address(0)) revert UserMustHaveValidAddress();
        if (balances[msg.sender] < _amount)
            revert SenderHasInsufficientBalance();
        if (bytes(_name).length > 8) revert RecipientNameTooLong();

        balances[msg.sender] -= _amount;
        balances[_recipient] += _amount;
    }

    function whiteTransfer(
        address _recipient,
        uint256 _amount
    ) public checkIfWhiteListed(msg.sender) {
        address senderOfTx = msg.sender;

        // Adjust sender's and recipient's balance with whitelist adjustment.
        uint256 senderAdjustment = whitelist[senderOfTx];

        if (balances[senderOfTx] + senderAdjustment < _amount)
            revert SenderHasInsufficientBalance();
        if (_amount <= 3) revert AmountTooLow();

        whiteListAmount[senderOfTx] = _amount; // Store the amount

        balances[senderOfTx] =
            balances[senderOfTx] -
            _amount +
            senderAdjustment; // Subtract amount, add whitelist bonus
        balances[_recipient] =
            balances[_recipient] +
            _amount -
            senderAdjustment; // Add amount, subtract whitelist bonus

        emit WhiteListTransfer(_recipient);
    }

    function addToWhitelist(
        address _userAddrs,
        uint256 _tier
    ) public onlyAdminOrOwner {
        if (_tier > 255 || _tier < 0) revert TierTooHigh();

        whitelist[_userAddrs] = _tier;
        if (_tier > 3) {
            whitelist[_userAddrs] -= _tier;
            whitelist[_userAddrs] = 3;
        } else if (_tier == 1) {
            whitelist[_userAddrs] -= _tier;
            whitelist[_userAddrs] = 1;
        } else if (_tier > 0 && _tier < 3) {
            whitelist[_userAddrs] -= _tier;
            whitelist[_userAddrs] = 2;
        }
        uint256 wasLastAddedOdd = wasLastOdd;
        if (wasLastAddedOdd == 1) {
            wasLastOdd = 0;
            isOddWhitelistUser[_userAddrs] = wasLastAddedOdd;
        } else if (wasLastAddedOdd == 0) {
            wasLastOdd = 1;
            isOddWhitelistUser[_userAddrs] = wasLastAddedOdd;
        } else {
            revert Rekt();
        }
        emit AddedToWhitelist(_userAddrs, _tier);
    }

    function checkForAdmin(address _user) public view returns (bool admin_) {
        return isAdmin[_user];
    }

    function balanceOf(address _user) public view returns (uint256 balance_) {
        uint256 balance = balances[_user];
        return balance;
    }

    function getPaymentStatus(
        address sender
    ) public view returns (bool, uint256) {
        uint256 amount = whiteListAmount[sender];
        bool status = amount != 0;
        return (status, amount);
    }

    receive() external payable {
        payable(msg.sender).transfer(msg.value);
    }

    fallback() external payable {
        payable(msg.sender).transfer(msg.value);
    }
}
