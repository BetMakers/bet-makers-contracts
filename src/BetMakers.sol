// SPDX-License-Identifier: MIT
pragma solidity =0.8.17;

import {ERC20} from "@solmate/src/tokens/ERC20.sol";
import {SafeTransferLib} from "@solmate/src/utils/SafeTransferLib.sol";
import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";
import "@chainlink/contracts/src/v0.8/shared/access/ConfirmedOwner.sol";

contract BetMakers is ChainlinkClient, ConfirmedOwner {
    using SafeTransferLib for ERC20;
    using Chainlink for Chainlink.Request;
    address USDT = 0xc2132D05D31c914a87C6611C10748AEb04B58e8F; 

    address betMakerAddress;
    address public owner;
    mapping(uint256 => mapping(uint256 => address[])) public poolParticipants; // uint pubId to uint256 result to betterAddress
    mapping(uint256 => uint256) public matchPool; // uint pubId to uint total pool // money
    mapping(uint256 => uint256) public matchBet; // uint pubId to uint bet ticket  // money

    // Chainlink Functions variables    
    uint256 public volume;
    bytes32 private jobId;
    uint256 private fee;
    /*
     * @notice Initialize the link token and target oracle
     *
     * Mumbai Testnet details:
     * Link Token: 0x326C977E6efc84E512bB9C30f76E30c160eD06FB
     * Oracle: 0x40193c8518BB267228Fc409a613bDbD8eC5a97b3 (Chainlink DevRel)
     * jobId: ca98366cc7314957b8c012c72f05aeeb // to get an uint256
     *
     */
    constructor() ConfirmedOwner(msg.sender){
        setChainlinkToken(0x326C977E6efc84E512bB9C30f76E30c160eD06FB);
        setChainlinkOracle(0x40193c8518BB267228Fc409a613bDbD8eC5a97b3);
        jobId = "ca98366cc7314957b8c012c72f05aeeb";
        fee = (1 * LINK_DIVISIBILITY) / 10; // 0,1 * 10**18 (Varies by network and job)
        owner = msg.sender;
    } 

    modifier onlyBetMakers() {
        require(
            msg.sender == betMakerAddress,
            "OnlyBetMaker"
        );
        _;
    }
    modifier onlyOwner() {
        require(msg.sender == owner, "OnlyOwner");
        _;
    }

    function setBet(uint256 pubId, uint256 bet, uint256 result, address profileAddress) public onlyBetMakers{
        matchPool[pubId] += bet;
        matchBet[pubId] = bet;
        poolParticipants[pubId][result].push(profileAddress);
    }

    function joinBet(uint256 pubId, uint256 result, address profileAddress) public onlyBetMakers{
        matchPool[pubId] += matchBet[pubId];
        poolParticipants[pubId][result].push(profileAddress);
    }

    function startBet(uint256 pubId) external onlyOwner  {
        //devolver apuesta a los que no alcanzaron a hacer match
        uint256 bettersteam1 = poolParticipants[pubId][1].length;
        uint256 bettersteam2 = poolParticipants[pubId][2].length;
        uint256 largerTeam = (bettersteam1 > bettersteam2) ? 1 : 2;
        uint256 smallerTeam = (bettersteam1 > bettersteam2) ? 2 : 1;
        uint256 finalParticipants = poolParticipants[pubId][smallerTeam].length;
        
        if (bettersteam1 != bettersteam2) {   
            for (uint256 i = poolParticipants[pubId][largerTeam].length; i > finalParticipants; --i) {
                ERC20(USDT).safeTransfer(poolParticipants[pubId][largerTeam][i], matchBet[pubId]);
                poolParticipants[pubId][largerTeam].pop();
                matchPool[pubId] -= matchBet[pubId];
         }
        } 
    }

    function executeBet(uint256 pubId) external onlyOwner{
      // chainlink api oracle to get actual result
      requestVolumeData(matchId[pubId]);
    }

        /**
     * Receive the response in the form of uint256
     */
    function fulfill(
        bytes32 _requestId,
        uint256 _volume
    ) public recordChainlinkFulfillment(_requestId) {
        emit RequestVolume(_requestId, _volume);
        result = _volume;

        uint256 winners = poolParticipants[pubId][result].length;
        uint256 prize = matchPool[pubId]/winners;
      for (uint256 i; i < winners; ++i) {
          ERC20(USDT).safeTransfer(poolParticipants[pubId][result][i], prize);
          matchPool[pubId] -= prize;
      }
    }

    function setBetMaker(address _betMakerAddress) external onlyOwner{
        betMakerAddress = _betMakerAddress;
    }

    function requestVolumeData(uint256 matchId) public returns (bytes32 requestId) {
        Chainlink.Request memory req = buildChainlinkRequest(
            jobId,
            address(this),
            this.fulfill.selector
        );

        // Set the URL to perform the GET request on
        req.add(
            "get",
            "https://myfotballgameresults.io/${matchId}"
        );

        req.add("path", "winner"); // Chainlink nodes 1.0.0 and later support this format

        // Multiply the result by 1000000000000000000 to remove decimals
        int256 timesAmount = 10 ** 18;
        req.addInt("times", timesAmount);
        // Sends the request
        return sendChainlinkRequest(req, fee);
    }
}

