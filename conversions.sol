pragma solidity >= 0.7.0 < 0.9.0;

contract learnConversions {
    uint32 public a = 0x12345678;
    uint16 public b = uint16(a);
    

    function print() public view returns(uint32) {
        return a;
    }
}