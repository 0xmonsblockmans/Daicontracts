// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


interface IFlap {
    function kick(uint lot, uint bid) external returns (uint);
    function cage(uint) external;
    function live() external returns (uint);
}
