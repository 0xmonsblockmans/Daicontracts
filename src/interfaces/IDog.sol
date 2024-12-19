// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

interface IDog {
    function chop(bytes32) external returns (uint256);
    function digs(bytes32, uint256) external;
}