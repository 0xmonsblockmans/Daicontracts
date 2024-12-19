// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

interface IClipperCallee {
    function clipperCall(address, uint256, uint256, bytes calldata) external;
}