//SPDX-License-Identifier:Unlicensed
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/MockAccessControl.sol";

contract MinionTest is Test {
    Minion minion;
    address constant owner = 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db;
    

    function setUp() public {
        minion = new Minion();
    }

    function testFailPwnContract() external {
        minion.pwn();
    }

    function testFailPwnEOA(uint96 amount) external {
        vm.prank(address(0));
        vm.assume(amount > 0.2 ether);
        minion.pwn();
    }
    
    function testFailExternalCall() external {
        (, bytes memory d) = address(minion).call(abi.encodeWithSignature("pwn()"));
        emit log_bytes(d);
        vm.expectRevert(d);
    }

    function testFailRetrieveOwner() external {
        vm.prank(owner);
        minion.retrieve();
    }

    function testFailRetrievePerson() external {
        vm.prank(address(0));
        minion.retrieve();
    }

    function testVerify() external view returns(bool) {
        return minion.verify(owner);
    }

    function testFailVerifyAccountZero() external view returns(bool) {
        return minion.verify(address(0));
    }

    function testTimeVal() external {
        assertEq(minion.timeVal(), block.timestamp);
    }
}