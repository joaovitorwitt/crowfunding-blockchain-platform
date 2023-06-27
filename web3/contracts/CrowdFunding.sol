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

    mapping (uint => Campaign) public campaings;

    uint public numberOfCampaings = 0;


    function createCampaign(
        address _owner,
        string memory _title,
        string memory _description,
        uint _target,
        uint _deadline,
        string memory _image) public returns (uint)
    {
        Campaign storage campaign = campaings[numberOfCampaings];

        require(campaign.deadline < block.timestamp, "The deadline should be a date in the future.");

        campaign.owner = _owner;
        campaign.title = _title;
        campaign.description = _description;
        campaign.target = _target;
        campaign.deadline = _deadline;
        campaign.amountCollected = 0;
        campaign.image = _image;
    
        numberOfCampaings++;    

        return numberOfCampaings - 1;
    }

    function donateToCampaign(uint _id) public payable {
        uint amount = msg.value;

        Campaign storage campaign = campaings[_id];

        campaign.donators.push(msg.sender);
        campaign.donations.push(amount);

        (bool sent, ) = payable(campaign.owner).call{value: amount}("");

        if (sent) {
            campaign.amountCollected = campaign.amountCollected + amount;
        }
    }

    function getDonators(uint _id) view public returns(address[] memory, uint[] memory) {
        return (campaings[_id].donators, campaings[_id].donations);
    }

    function getCampaigns() public view returns(Campaign[] memory) {
        Campaign[] memory allCampaigns = new Campaign[](numberOfCampaings); 

        for (uint i = 0; i < numberOfCampaings; i++) {
            Campaign storage item = campaings[i];

            allCampaigns[i] = item;
        }

        return allCampaigns;
    }
    
}