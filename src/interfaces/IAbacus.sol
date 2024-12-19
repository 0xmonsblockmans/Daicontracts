// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

interface IAbacus {
    function price(uint256, uint256) external view returns (uint256);
}