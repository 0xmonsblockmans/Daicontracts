// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";

import {Dai} from "../src/Dai.sol";

contract DeployScript is Script {
    Dai public dai;

    function setUp() public {}

    function run() public {
        uint privateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(privateKey);
        uint256 chainId = vm.envUint("CHAIN_ID");
        dai = new Dai(chainId);
        vm.stopBroadcast();
    }
}

// forge script script/Dai.s.sol:DeployScript --rpc-url $RPC_URL --broadcast  --etherscan-api-key $API_KEY --verify -vvvv

// 0xe3e0448577652dA36556B4B467650e908D290612