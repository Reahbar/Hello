// SPDX-License-Identifier: MIT

/*Functionality

    Contract successfully uses require()
    Contract successfully uses assert()
    Contract successfully uses revert()

Explanation

    Code read-aloud is submitted
    Code read-aloud is complete (all steps explained)
    Code read-aloud is clear and understandable */

pragma solidity ^0.8.0;

contract BasicBankContract 
    {
    mapping (address => uint) balance;
    address owner;

    constructor () {
        owner = msg.sender;
    }

    modifier onlyOwner 
    {
        require (owner == msg.sender, "Warning you are not the owner");_;
    }
    
    function getDeployerAccountAddress () onlyOwner public view returns (address) 
    {
        address account = msg.sender;
        assert (owner == account);
        return account;
    }

     function deposit () public payable
    {   require (msg.value > 0, "Amount must be greater than 0");
        balance [msg.sender] += msg.value;
    }
    
    function getBalance () onlyOwner public view returns (uint)
    {  
        return balance [msg.sender]; 
    }

    function withdraw(uint amount) payable public 
    {
    require(amount > 0, "Amount must be greater than zero");
    require(balance[msg.sender] >= amount, "Insufficient balance");
    payable(msg.sender).transfer(amount);
    }

    function transferBalance(address _receiver, uint _amount) public payable 
    {
        if (balance[msg.sender] < _amount) 
    {
        revert("Insufficient balance");
    }
        balance[msg.sender] -= _amount;
        balance[_receiver] += _amount;
    }


}