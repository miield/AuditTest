//SPDX-License-Identifier:Unlicensed
// pragma solidity 0.6.12;

// import "forge-std/Test.sol";
// import "../src/MGGovToken.sol";

// contract TestMockGovToken is Test {
//     MockGovToken _token;
//     address testAddr = 0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB;

//     function setUp() public {
//         _token = new MockGovToken();
//     }

//     function testMintWithOwner() external {
//         _token.mint(testAddr, 10000000);
//         assertEq(_token.balanceOf(testAddr), 10000000);
//     }

//     function testFailMintNotOwner() external {
//         vm.prank(testAddr);
//         _token.mint(testAddr, 10000000);
//         vm.expectRevert();
//     }

//     function testBurnWithOwner() external {
//         _token.mint(testAddr, 2000000);
//         _token.burn(testAddr, 1000000);
//         assertEq(_token.balanceOf(testAddr), 1000000);
//     }

//     function testFailBurnNotOwner() external {
//         vm.prank(testAddr);
//         _token.mint(testAddr, 2000000);
//         _token.burn(testAddr, 1000000);
//     }

//     function testDelegates() view external returns(address) {
//         return _token.delegates(testAddr);
//     }

//     function testDelegate() external {
//         _token.delegate(testAddr);
//     }

//     function testFailGetPriorVotes() external {
//         _token.getPriorVotes(testAddr, 100);
//     }

// }





pragma solidity 0.6.12;

import "forge-std/Test.sol";
import "../src/MGGovToken.sol";

contract MGGovTokenTest is Test {

    MockGovToken mgToken;
    address addr = 0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB;

    function setUp() public {
        mgToken = new MockGovToken();
    }

    function mintWithOnlyOwner() external {
        mgToken.mint(addr, 5000000);
        assertEq(mgToken.balanceOf(addr), 5000000);
    }

    function mintNotOwnerFailTest() external {
        vm.prank(addr);
        mgToken.mint(addr, 5000000);
        vm.expectRevert();
    }

    function BurnWithOnlyOwner() external {
        mgToken.mint(addr, 3000000);
        mgToken.burn(addr, 2000000);
        assertEq(mgToken.balanceOf(addr), 1000000);
    }

    function burnNotOwnerFailTest() external {
        vm.prank(addr);
        mgToken.mint(addr, 3000000);
        mgToken.burn(addr, 2000000);
    }

    function delegatesTest() view external returns(address) {
        return mgToken.delegates(addr);
    }

    function delegateTest() external {
        mgToken.delegate(addr);
    }

    function getPriorVotesFailTest() external {
        mgToken.getPriorVotes(addr, 100);
    }

}
