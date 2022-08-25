// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "forge-std/Test.sol";
import "src/GuessTheSecretNumber.sol";

contract GuessTheSecretNumberTest is Test {
    GuessTheSecretNumberChallenge private guessthesecretnumber;
    address private constant ALICE = address(0x1);
    function setUp() external {
        vm.startPrank(ALICE);
        vm.deal(ALICE, 10 ether);
        guessthesecretnumber = new GuessTheSecretNumberChallenge{value: 1e18}();
    }

    function testHack() external {
        // We gotta loop over 2**8 numbers, calculate keccak256 and compare the result with 0xdb81b4d58595fbbbb592d3661a34cdca14d7ab379441400cbfa1b78bc447c365
        // the necessary number is 170
        (bool success, ) = address(guessthesecretnumber).call{value: 1e18}(abi.encodeWithSignature("guess(uint8)", 170));
        require(success, "tx failed");
        assertEq(address(guessthesecretnumber).balance, 0);
        vm.stopPrank();
    }
} 