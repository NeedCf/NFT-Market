pragma solidity >= 0.7.0 < 0.9.0;

contract learnVariables {

    function multiplyCalculator(uint a, uint b) public view returns(uint) {
        uint result = a * b;
        return result;
    }

    function divideCalculator(uint a, uint b) public view returns(uint) {
        uint result = a / b; 
        return result;
    }

    function compare() view public {
        require(6 > 8, 'A < B');
    }
}