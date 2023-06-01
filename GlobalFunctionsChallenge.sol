// SPDX-License-Identifier: MIT 

pragma solidity >0.8.0 <0.10.0;

contract SmartContractChallengeBank 
    {
   
    mapping (address => uint) public balance;
    address public owner;
    
    constructor () 
    {
        owner = msg.sender; // The Default value of owner which is a gloabl varible of owner is 0x0 something if suppose if there was an address then we can compare by using double equals ==
    }

    modifier onlyOwner 
    {
        require (owner == msg.sender, "Warning: You don't have access to this function! Please contact your nearest customer care for assistance.");_; // Here owner value is already msg.sender but when the caller of this function called that address also suppuse to be a msg.sender so here we used double equals == not just one we both have their values inside!
    }

    event Deposit(address indexed account, uint indexed amount);
    event DeleteBalance (address indexed account, uint indexed balance);
    event TransferBalance (address indexed account, address indexed _reciver, uint indexed _amount);
    event WithdrawBalance (address indexed account, uint indexed  _amount);
     
    function deposit() public payable 
    { 
    emit Deposit(msg.sender, msg.value);
    require(balance[msg.sender] + msg.value <= 10000000000000000000, "Warning: Your transaction has failed due to reaching the maximum deposit amount.");
    emit Deposit(msg.sender, msg.value);
    balance[msg.sender] += msg.value; 
    }

    function checkBalance () public view returns (uint) 
    { 
     require(balance[msg.sender] >= 0, "Warning: Your transaction has failed due to insufficient balance.");
        return balance [msg.sender];
    }

    function deleteBalance() onlyOwner public payable 
    {
    emit DeleteBalance(msg.sender, balance[msg.sender]);
    require(balance[msg.sender] > 0, "Warning: Your transaction has failed due to insufficient balance");
    delete balance[msg.sender];
    }

    function transferBalance(address _receiver, uint _amount) public payable 
    {   emit TransferBalance(msg.sender, _receiver, _amount);
        require(balance[msg.sender] >= _amount, "Warning: Your transaction has failed due to insufficient balance.");
        require(owner != _receiver, "Warning: You cannot transfer the amount to yourself. Please provide a valid recipient address for the transaction.");
        balance[msg.sender] -= _amount;
        balance[_receiver] += _amount;
    }  

    function withdrawBalance() public payable 
    {
    uint amount = balance[msg.sender]; // Store the balance in a local variable
    require(amount > 0, "Warning: Your transaction has failed due to insufficient balance");
    require(amount <= 10000000000000000000, "Warning: Your transaction has failed due to reaching the maximum withdraw amount");
    payable(msg.sender).transfer(amount);
    }



    }
