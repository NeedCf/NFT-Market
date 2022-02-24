pragma solidity >= 0.7.0 < 0.9.0;

contract learnEtherUnits {

    mapping(address => uint) balance;
    
    function updatesBalance(uint newBalance) public {
        balance[msg.sender] = newBalance;
    }
}


contract Updated {
    function updatesBalance() public {
        learnEtherUnits walletTest = new learnEtherUnits();
        walletTest.updatesBalance(30);
    }
}