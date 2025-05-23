//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract FundMeDeploy is Script {
    // This is a deploy script for the FundMe contract
    // It will deploy the contract to the Sepolia testnet
    // It will also verify the contract on Etherscan

    function run() external returns (FundMe) {
        // Deploy the FundMe contract
        //new FundMe();

        HelperConfig helperConfig = new HelperConfig();
        address ethUSDPriceFeed = helperConfig.activeNetworkConfig();

        vm.startBroadcast();
        //FundMe fundMe = new FundMe();
        //(REFACTORED)FundMe fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        FundMe fundMe = new FundMe(ethUSDPriceFeed);
        vm.stopBroadcast();
        return fundMe;
    }
}
