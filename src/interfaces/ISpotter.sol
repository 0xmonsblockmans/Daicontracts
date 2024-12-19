// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./IPip.sol";

interface ISpotter {
    function par() external returns (uint256);
    function ilks(bytes32) external returns (IPip, uint256);
}