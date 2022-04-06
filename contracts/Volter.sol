// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.13;

 contract Voter {

     struct OptionPos {
         uint pos;
         bool exists;
     }

     mapping (string => OptionPos) posOfOption;
     mapping (address => bool) hasVoted;
     
     uint[2] public votes;
     string[2] public options;

     
    constructor(string[2] memory _options) {
        options = _options;

        for (uint i = 0; i < options.length; i++) {
            OptionPos memory option = OptionPos(i, true);
            posOfOption[options[i]] = option;
        }
    }

    
    function voterOption(uint option) public {
        require(option >= 0 && option <= options.length);
        require(hasVoted[msg.sender] == false);
        
        votes[option] = votes[option] + 1;
        hasVoted[msg.sender] = true;

    }

    function voterName(string memory option) public {
        require(hasVoted[msg.sender] == false);
        OptionPos memory optionPos = posOfOption[option];
        require(optionPos.exists == true);

        votes[optionPos.pos] = votes[optionPos.pos] + 1;
        hasVoted[msg.sender] = true;
    }

    
    function getVotes() public view returns (uint[2] memory) {
        return votes;
    }

    
    function getOptions() public view returns (string[2] memory) {
        return options;
    }

 }