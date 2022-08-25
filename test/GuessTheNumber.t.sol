// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "src/GuessTheNumber.sol";

contract GuessTheNumberTest is Test {
    GuessTheNumberChallenge private guessthenumber;
    address private constant ALICE = address(0x1);
    function setUp() external {
        vm.startPrank(ALICE);
        vm.deal(ALICE, 10 ether);
        guessthenumber = new GuessTheNumberChallenge{value: 1e18}();
    }

    function testHack() external {
        (bool success, ) = address(guessthenumber).call{value: 1e18}(abi.encodeWithSignature("guess(uint8)", 42));
        require(success, "tx failed");
        assertEq(address(guessthenumber).balance, 0);
        vm.stopPrank();
        }
}