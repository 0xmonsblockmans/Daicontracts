// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

interface IFlop {
    function kick(address gal, uint lot, uint bid) external returns (uint);
    function cage() external;
    function live() external returns (uint);
}