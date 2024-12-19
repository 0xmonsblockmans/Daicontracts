// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";

import {Dai} from "../src/Dai.sol";
import { Vat }  from "../src/Vat.sol";
import { GemJoin, ETHJoin, DaiJoin } from "../src/Join.sol";
import { BAToken } from "../src/BatToken.sol";
import { Spotter } from "../src/Spotter.sol";
import { Clipper } from "../src/Clipper.sol";
import { Dog } from "../src/Dog.sol";
import { StairstepExponentialDecrease } from "../src/Abacus.sol";
import { Vow } from '../src/Vow.sol';
import { Flapper } from "../src/Flapper.sol";
import { Flopper } from "../src/Flopper.sol";
import { DSToken } from "../src/Token.sol";

contract DeployScript is Script {
    Dai public dai;
    Vat public vat;
    BAToken public bat;
    DaiJoin public daiJoin;
    ETHJoin public ethJoin;
    GemJoin public gemJoin;
    Spotter public spotter;
    Clipper public clipper;
    Dog public dog;
    StairstepExponentialDecrease public abacus;
    Vow public vow;
    Flapper public flapper;
    Flopper public flopper;
    DSToken public dstoken;

    function setUp() public {}

    function run() public {
        uint privateKey = vm.envUint("PRIVATE_KEY");
        address account = vm.addr(privateKey);
        vm.startBroadcast(privateKey);
        uint256 chainId = vm.envUint("CHAIN_ID");
        dai = new Dai(chainId);
        vat = new Vat();
        bat = new BAToken(account, account);
        daiJoin = new DaiJoin(address(vat), address(dai));
        ethJoin = new ETHJoin(address(vat), "ETH-A");
        gemJoin = new GemJoin(address(vat), "GEM-A", address(bat));
        spotter = new Spotter(address(vat));
        dog = new Dog(address(vat));
        clipper = new Clipper(address(vat), address(spotter), address(dog), "ETH-A");
        abacus = new StairstepExponentialDecrease();
        flapper = new Flapper(address(vat), address(dai));
        flopper = new Flopper(address(vat), address(dai));
        vow = new Vow(address(vat), address(flapper), address(flopper));
        dstoken = new DSToken("DSToken");
        vm.stopBroadcast();
    }
}

// forge script script/Dai.s.sol:DeployScript --rpc-url $RPC_URL --broadcast  --etherscan-api-key $API_KEY --verify -vvvv

// 0xe3e0448577652dA36556B4B467650e908D290612