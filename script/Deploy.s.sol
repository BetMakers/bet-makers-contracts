// SPDX-License-Identifier: MIT
pragma solidity =0.8.17;

import "forge-std/Script.sol";
import {BetMakers} from '../src/BetMakers.sol';
import {BetMakersOpenAction} from '../src/BetMakersOpenAction.sol';
import {ERC20Detailed} from '../src/VoteTokenImplementation.sol';
contract DeployBase is Script {
  function run() public {
    vm.startBroadcast();

    BetMakers betMakers = new BetMakers();
    BetMakersOpenAction bMO = new BetMakersOpenAction(
      0xC1E77eE73403B8a7478884915aA599932A677870, 
      address(betMakers)
    );

    betMakers.setBetMaker(address(bMO));
    tokenDeployer token = new tokenDeployer(0xC2628eDdDB676c4cAF68aAD55d2191F6c9668624,"City", "CTY");
    tokenDeployer token2 = new tokenDeployer(0xC2628eDdDB676c4cAF68aAD55d2191F6c9668624,"Lib", "LIB");

    vm.stopBroadcast();
  }
}
