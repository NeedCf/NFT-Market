pragma solidity >= 0.7.0 < 0.9.0;

contract Owner {

    address owner;
    // when we deloy this contract we want to set the address to the owner (msg.sender)

    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner {
        // customizable logic to modify our functions
        require(msg.sender == owner);
        _;
        // the underscore continues with the function
    }

    modifier costs(uint price) {
        // what msg.value: the amount in wei being sent with a
        // message to a contract
        require(msg.value >= price);    
        _;
    }
}

contract Register is Owner {
    mapping (address => bool) registeredAddresses;
    uint price;

    constructor(uint initialPrice) public {price = initialPrice; }

    function register() public payable costs(price){
        registeredAddresses[msg.sender] = true;
    }

    function changePrice(uint _price) public onlyOwner {
        price = _price;
    }
}