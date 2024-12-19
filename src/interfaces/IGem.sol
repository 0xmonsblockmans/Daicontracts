// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

interface IGem {
    function transfer(address,uint) external returns (bool);
    function transferFrom(address,address,uint) external returns (bool);
    function move(address,address,uint) external;
    function burn(address,uint) external;
    function mint(address,uint) external;
}