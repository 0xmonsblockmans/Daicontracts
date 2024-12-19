// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

interface IDSToken {
    function mint(address,uint) external;
    function burn(address,uint) external;
}