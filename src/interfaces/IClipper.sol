// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

interface IClipper {
    function ilk() external view returns (bytes32);
    function kick(
        uint256 tab,
        uint256 lot,
        address usr,
        address kpr
    ) external returns (uint256);
}