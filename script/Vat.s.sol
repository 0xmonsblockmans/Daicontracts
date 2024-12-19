// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Vat} from "../src/Vat.sol";

contract DeployScript is Script {
    Vat public vat;

    function setUp() public {}

    function run() public {
        uint privateKey = vm.envUint("PRIVATE_KEY");
        address account = vm.addr(privateKey);
        console.log("Deploying contract with account: ", account);
        vm.startBroadcast(privateKey);

        vat = new Vat();  

        vm.stopBroadcast();
    }
}

// forge script script/Vat.s.sol:DeployScript --rpc-url $RPC_URL --broadcast --verify -vvvv
