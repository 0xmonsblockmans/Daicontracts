/// join.sol -- Basic token adapters

// Copyright (C) 2018 Rain <rainbreak@riseup.net>
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./LibNote.sol";
import "./interfaces/IGem.sol";
import "./interfaces/IDSToken.sol";
import ".//interfaces/IVat.sol";
/*
    Here we provide *adapters* to connect the Vat to arbitrary external
    token implementations, creating a bounded context for the Vat. The
    adapters here are provided as working examples:

      - `GemJoin`: For well behaved ERC20 tokens, with simple transfer
                   semantics.

      - `ETHJoin`: For native Ether.

      - `DaiJoin`: For connecting internal Dai balances to an external
                   `DSToken` implementation.

    In practice, adapter implementations will be varied and specific to
    individual collateral types, accounting for different transfer
    semantics and token standards.

    Adapters need to implement two basic methods:

      - `join`: enter collateral into the system
      - `exit`: remove collateral from the system

*/

contract GemJoin is LibNote {
    IVat public vat;
    bytes32 public ilk;
    IGem public gem;
    constructor(address vat_, bytes32 ilk_, address gem_) {
        vat = IVat(vat_);
        ilk = ilk_;
        gem = IGem(gem_);
    }
    function join(address usr, uint wad) external note {
        require(int(wad) >= 0);
        vat.slip(ilk, usr, int(wad));
        require(gem.transferFrom(msg.sender, address(this), wad));
    }
    function exit(address usr, uint wad) external note {
        require(wad <= 2 ** 255);
        vat.slip(ilk, msg.sender, -int(wad));
        require(gem.transfer(usr, wad));
    }
}

contract ETHJoin is LibNote {
    IVat public vat;
    bytes32 public ilk;
    constructor(address vat_, bytes32 ilk_) {
        vat = IVat(vat_);
        ilk = ilk_;
    }
    function join(address usr) external payable note {
        require(int(msg.value) >= 0);
        vat.slip(ilk, usr, int(msg.value));
    }
    function exit(address payable usr, uint wad) external note {
        require(int(wad) >= 0);
        vat.slip(ilk, msg.sender, -int(wad));
        usr.transfer(wad);
    }
}

contract DaiJoin is LibNote {
    IVat public vat;
    IDSToken public dai;
    constructor(address vat_, address dai_) {
        vat = IVat(vat_);
        dai = IDSToken(dai_);
    }
    uint constant ONE = 10 ** 27;
    function mul(uint x, uint y) internal pure returns (uint z) {
        require(y == 0 || (z = x * y) / y == x);
    }
    function join(address usr, uint wad) external note {
        vat.move(address(this), usr, mul(ONE, wad));
        dai.burn(msg.sender, wad);
    }
    function exit(address usr, uint wad) external note {
        vat.move(msg.sender, address(this), mul(ONE, wad));
        dai.mint(usr, wad);
    }
}