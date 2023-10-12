// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "openzeppelin-contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "openzeppelin-contracts-upgradeable/access/OwnableUpgradeable.sol";

contract UpgradeableContract is
    Initializable,
    UUPSUpgradeable,
    OwnableUpgradeable
{
    uint256 public x;

    constructor() {
        _disableInitializers();
    }

    function initialize(uint256 _x) public initializer {
        __Ownable_init(msg.sender);
        __UUPSUpgradeable_init();
        x = _x;
    }

    function _authorizeUpgrade(
        address newImplementation
    ) internal override onlyOwner {}

    function getVersion() external pure returns (uint) {
        return 1;
    }
}
