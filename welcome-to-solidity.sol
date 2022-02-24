pragma solidity >= 0.7.0 < 0.9.0;

contract WelcomeToSolidity {
    // Hàm khở tạo hợp đồng
    constructor() public {
    }
    // Hàm trả về giá trị của hợp đồng
    function getResult() public view returns(uint) {
        // Tạo biến a kiểu số nguyên
        // Giá trị khởi tạo bằng 1
        uint a = 1;
        // Tạo viến b kiểu số nguyên
        // Giá trị khởi tạo bằng 2
        uint b = 2;
        // Tạo biến result kiểu số nguyên
        // Giá trị khởi tạo bằng a + b
        uint result = a + b;
        return result;
    }

    uint a = 9;

    function getValue() external view returns(uint) {
        uint a = 1;
        return a;
    }

    function getNewValue() external pure returns(uint) {
        return 3 + 3;
    }
}