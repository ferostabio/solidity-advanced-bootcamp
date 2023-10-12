// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "openzeppelin-contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "openzeppelin-contracts-upgradeable/access/OwnableUpgradeable.sol";

contract UpgradeableContractV2 is
    Initializable,
    UUPSUpgradeable,
    OwnableUpgradeable
{
    uint256 public x;
    uint256 public y;

    function setY(uint256 _y) public {
        y = _y;
    }

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize() public initializer {
        __Ownable_init(msg.sender);
        __UUPSUpgradeable_init();
    }

    function _authorizeUpgrade(
        address newImplementation
    ) internal override onlyOwner {}

    function getVersion() external pure returns (uint) {
        return 2;
    }
}
