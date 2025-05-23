//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {FundMeDeploy} from "../script/FundMeDeploy.s.sol";

contract FundMeTest is Test {
    FundMe fundMe;

    function setUp() external {
        //(REFATCORED)//new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306)
        FundMeDeploy fundMeDeploy = new FundMeDeploy();
        fundMe = fundMeDeploy.run();
    }

    function testDemo() public {}

    function testMinimumUSDisFive() public {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwnerIsMsgSender() public {
        console.log("msg.sender: ", msg.sender);
        console.log("i_owner: ", fundMe.i_owner());
        assertEq(fundMe.i_owner(), msg.sender);
    }

    function testPriceFeedVersionIsAccurate() public {
        uint256 version = fundMe.getVersion();
        assertEq(version, 4);
    }

    function testFundFailsWithoutEnoughEth() public {
        vm.expectRevert(); // "You need to spend more ETH!"
        fundMe.fund(); // 0 ETH
    }

    function testFundUpdatesAmountFundedDataStructure() public {
        fundMe.fund{value: 10e18}();
    }
}
