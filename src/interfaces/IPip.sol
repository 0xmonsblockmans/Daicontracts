// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

interface IPip {
    function peek() external returns (bytes32, bool);
}
