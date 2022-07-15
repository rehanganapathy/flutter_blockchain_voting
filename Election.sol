//this is the solidity file that has the election smart contract and the functions that are called in the dart files

//SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.5.0 < 0.9.0;

contract Election{ 
    struct Candidate{
        string name; 
        uint numVotes; 
    }

    struct Voter{
        string name; 
        bool authorised; 
        uint whom;
        bool voted; 
    }

    address public owner; 
    string public electionName; 


    mapping(address => Voter) public voters; 
    Candidate[] public candidates; 
    uint public totalVotes; 


    modifier ownerOnly(){ 
        require(msg.sender == owner); 
        _;
    }

    function startElection(string memory _electionName) public{ 
        owner = msg.sender; 
        electionName = _electionName; 
    }

    function addCandidate(string memory _candidateName )ownerOnly public{ 
        candidates.push(Candidate(_candidateName, 0));
    }

    function authorizeVoter(address _voterAddress) ownerOnly public{ 
        voters[_voterAddress].authorised= true; 
    }

    function getNumCandidates() public view returns(uint){ 
        return candidates.length; 
    }

    function vote(uint candidateIndex) public{ 
        require(!voters[msg.sender].voted); 
        require(voters[msg.sender].authorised); 
        voters[msg.sender].whom = candidateIndex; 
        voters[msg.sender].voted = true; 

        candidates[candidateIndex].numVotes++; 
        totalVotes++;
    }


    function getTotalVotes()public view returns(uint) {
        return totalVotes;
    }

function candidateInfo(uint index) public view returns(Candidate memory){ 
        return candidates[index];
    }



}
