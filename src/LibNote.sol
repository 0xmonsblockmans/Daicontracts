// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.16;

contract LibNote {
    event LogNote(
        bytes4 indexed sig,
        address indexed usr,
        bytes32 indexed arg1,
        bytes32 indexed arg2,
        bytes data
    ) anonymous;

    modifier note {
        emit LogNote(msg.sig, msg.sender, bytes32(0), bytes32(0), msg.data); // Emit log directly
        _; // Proceed with function execution
    }
}
