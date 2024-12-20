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

// [src/Dai.sol:Dai] 0x4a83eF3C50dae67691A79cfaEB00c45b8D851d5A
// [src/Vat.sol:Vat] 0xEDD21ea2F824d11e89BdF936F3A4699A0FF2B705
// [src/BatToken.sol:BAToken] 0x39Af0751eC28C70F61a320f732e2ecd681d406d0
// [src/Join.sol:DaiJoin] 0xE26c2060B1001ab8346f1e8671348e9002e2caB7
// [src/Join.sol:ETHJoin] 0x5BcFc3Ee30ECfC7014cB0f30d76CC2DFE8b8263F
// [src/Join.sol:GemJoin] 0xD6eE66e6a02bE468e38DEa63Cf0110Bba2A5956d
// [src/Spotter.sol:Spotter] 0x29C6Bb776193f88aD2E5a2fe0efB4EA02C7A7863
// [src/Dog.sol:Dog] 0x6B067D3ac0aBB51fd2B0C62D5fd1A28FFA5e7364
// [src/Clipper.sol:Clipper] 0xFa45c9f9BF7d852d00dcFC525e7E3CaBdE5e1B66
// [src/Abacus.sol:StairstepExponentialDecrease] 0x24fbe0C15C0928DC904Fed11e87D4dC59bb2F3A0
// [src/Flapper.sol:Flapper] 0x9e40e1f724E2c7cDe2d0fa8a00b60cC474C52Cd9
// [src/Flopper.sol:Flopper] 0x24d0fFe2EdbB223975531d78fbe94654B1b9BE73
// [src/Vow.sol:Vow] 0xf8CA62C21bF239d711E09849104436ff528F00d2
// [src/Token.sol:DSToken] 0x69AF45B7ed366b4656c8EaC7FBd2b0C52341Ef1c