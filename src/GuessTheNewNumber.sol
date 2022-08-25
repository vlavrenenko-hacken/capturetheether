// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract GuessTheNewNumberChallenge {
    constructor() payable {
        require(msg.value == 1 ether);
    }

    function isComplete() public view returns (bool) {
        return address(this).balance == 0;
    }

    function guess(uint8 n) public payable {
        require(msg.value == 1 ether);
        uint8 answer = uint8(uint(keccak256(abi.encodePacked(blockhash(block.number - 1), block.timestamp))));
        if (n == answer) {
            (bool success,) = msg.sender.call{value: 2 ether}("");
            require(success);
        }
    }
}