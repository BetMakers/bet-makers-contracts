// SPDX-License-Identifier: MIT
pragma solidity =0.8.17;

import "forge-std/Script.sol";
import {BetMakers} from '../src/BetMakers.sol';
import {BetMakersOpenAction} from '../src/BetMakersOpenAction.sol';

contract DeployBase is Script {
  function run() public {
    vm.startBroadcast();

    

    vm.stopBroadcast();
  }
}
