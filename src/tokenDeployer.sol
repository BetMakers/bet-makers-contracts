pragma solidity ^0.8.17;

import {ERC20} from "@solmate/src/tokens/ERC20.sol";

contract tokenDeployer is ERC20 {
    constructor(
        string memory name,
        string memory symbol
    ) ERC20(name, symbol, 0) {
        _mint(0xC2628eDdDB676c4cAF68aAD55d2191F6c9668624, 10000);
    }
}