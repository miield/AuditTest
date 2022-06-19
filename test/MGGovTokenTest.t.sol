//SPDX-License-Identifier:Unlicensed

pragma solidity 0.6.12;

import "forge-std/Test.sol";
import "../src/MGGovToken.sol";

contract MGGovTokenTest is Test {

    MockGovToken mgToken;
    address addr = 0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB;

    function setUp() public {
        mgToken = new MockGovToken();
    }

    function testWithOnlyOwner() external {
        mgToken.mint(addr, 5000000);
        assertEq(mgToken.balanceOf(addr), 5000000);
    }

    function testFailMintNotOwner() external {
        vm.prank(addr);
        mgToken.mint(addr, 5000000);
        vm.expectRevert();
    }

    function testBurnWithOnlyOwner() external {
        mgToken.mint(addr, 3000000);
        mgToken.burn(addr, 2000000);
        assertEq(mgToken.balanceOf(addr), 1000000);
    }

    function testFailBurnNotOwner() external {
        vm.prank(addr);
        mgToken.mint(addr, 3000000);
        mgToken.burn(addr, 2000000);
    }

    function testDelegates() view external returns(address) {
        return mgToken.delegates(addr);
    }

    function testDelegate() external {
        mgToken.delegate(addr);
    }

    function testFailGetPriorVotes() external {
        mgToken.getPriorVotes(addr, 100);
    }

}
