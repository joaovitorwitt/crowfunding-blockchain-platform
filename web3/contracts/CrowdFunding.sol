// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract CrowdFunding {

    struct Campaign {
        address owner;
        string title;
        string description;
        uint target;
        uint deadline;
        uint amountCollected;
        string image;
        address[] donators;
        uint[] donations;
    }

    mapping (uint=> Campaign) public campaings;

    uint public numberOfCampaings = 0;


    function createCampaign() {}

    function donateToCampaign() {}

    function getDonators() {}

    function getCampaigns() {}
    
}