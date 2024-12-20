// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


interface IVat {
    function ilks(bytes32) external view returns (
        uint256 art,  // [wad]
        uint256 rate, // [ray]
        uint256 spot, // [ray]
        uint256 line, // [rad]
        uint256 dust  // [rad]
    );
    function urns(bytes32,address) external view returns (
        uint256 ink,  // [wad]
        uint256 art   // [wad]
    );
    function grab(bytes32,address,address,address,int256,int256) external;
    function suck(address,address,uint256) external;
    function move(address,address,uint256) external;
    function flux(bytes32,address,address,uint256) external;
    function slip(bytes32,address,int) external;
    function file(bytes32, bytes32, uint) external;
    function dai (address) external view returns (uint);
    function sin (address) external view returns (uint);
    function heal(uint256) external;
    function hope(address) external;
    function nope(address) external;
    function fold(bytes32,address,int) external;
}