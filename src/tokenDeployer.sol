pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract tokenDeployer is ERC20, ERC20Burnable, Ownable {
    constructor(address initialOwner, string memory name,string memory symbol ) Ownable(0xC2628eDdDB676c4cAF68aAD55d2191F6c9668624) ERC20(name, symbol) {
        _mint(initialOwner, 10000);
        transferOwnership(initialOwner);
    }
}