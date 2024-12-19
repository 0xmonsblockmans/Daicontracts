// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

interface IKicker {
    function kick(
        address urn,
        address gal,
        uint256 tab,
        uint256 lot,
        uint256 bid
    ) external returns (uint256);
}
