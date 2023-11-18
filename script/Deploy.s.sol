// SPDX-License-Identifier: MIT
pragma solidity =0.8.17;

import "forge-std/Script.sol";

contract DeployBase is Script {
  function run() public {
    vm.startBroadcast();


    vm.stopBroadcast();
  }
}
