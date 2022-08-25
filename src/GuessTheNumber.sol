// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract GuessTheNumberChallenge {
    uint8 private answer = 42;

    constructor() payable {
        require(msg.value == 1 ether);
    }

    function isComplete() external view returns (bool) {
        return address(this).balance == 0;
    }

    function guess(uint8 n) external payable {
        require(msg.value == 1 ether);

        if (n == answer) {
           (bool success,) = msg.sender.call{value: 2 ether}("");
           require(success);
        }
    }
}