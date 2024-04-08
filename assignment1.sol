// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Adder {
    function cube(uint256 a)public  pure returns(uint256){
        return a**3 ;
    }


    function evenodd(uint256 a) public pure returns(uint256){
        if (a%2 == 0){
            return 0;
        }else{
            return 1;
        }
    }
    
    function avg(uint256 a, uint256 b, uint256 c) public pure returns(uint256){
        return (a+b+c)/3;
    }

    function swap(uint256 a, uint256 b) public pure returns(uint256, uint256){
        uint256 temp;
        temp = a;
        a = b;
        b = temp; 
        return (a,b);
    }

    function power(uint256 x, uint256 y) public pure returns(uint256){
        return x**y;

    }

    function swap2(uint256 a, uint256 b) public pure returns(uint256, uint256){
        a = a ^ b ;
        b = a ^ b ;
        a = a ^ b ;
        return(a,b);
    }

    function prime(uint256 a) public pure returns(uint256){
        
       if (a <= 1) {
            return (0); 
        }
        if (a == 2) {
            return (1); 
        }
        for (uint256 i = 2; i <= a / 2; i++) {
            if (a % i == 0) {
                return (0); 
            }
        }
        return (1); 
    }

    function isArmstrong(uint256 num) public pure returns(uint256) {
        uint256 sum = 0;
        uint256 temp = num;
        uint256 numDigits = 0;

        while (temp != 0) {
            numDigits++;
            temp /= 10;
        }

        temp = num;
        while (temp != 0) {
            uint256 digit = temp % 10;
            sum += digit ** numDigits;
            temp /= 10;
        }

        if (sum == num) {
            return 1;
        } else {
            return 0;
        }
    }

    function findGreatest(uint256 a, uint256 b, uint256 c) public pure returns(uint256) {
        if (a >= b && a >= c) {
            return a;
        } else if (b >= a && b >= c) {
            return b;
        } else {
            return c;
        }
    }

    function isPalindrome(uint256 num) public pure returns(uint256) {
        uint256 reversedNum = 0;
        uint256 originalNum = num;

        while (num != 0) {
            uint256 digit = num % 10;
            reversedNum = reversedNum * 10 + digit;
            num /= 10;
        }

        if (originalNum == reversedNum) {
            return 1;
        } else {
            return 0;
        }
    }

    function reverseInteger(uint256 num) public pure returns(uint256) {
        uint256 reversedNum = 0;

        while (num != 0) {
            uint256 digit = num % 10;
            reversedNum = reversedNum * 10 + digit;
            num /= 10;
        }

        return reversedNum;
    }

    function sumOfDigits(uint256 num) public pure returns(uint256) {
        uint256 sum = 0;

        while (num != 0) {
            sum += num % 10;
            num /= 10;
        }

        return sum;
    }

    function factorial(uint256 num) public pure returns(uint256) {
        if (num == 0 || num == 1) {
            return 1;
        }

        uint256 result = 1;
        for (uint256 i = 2; i <= num; i++) {
            result *= i;
        }

        return result;
    }

    function fibonacci(uint256 n) public pure returns(uint256) {
        uint256 a = 0;
        uint256 b = 1;

        if (n == 0) {
            return a;
        }

        for (uint256 i = 2; i <= n; i++) {
            uint256 c = a + b;
            a = b;
            b = c;
        }

        return b;
    }

    function multiply(uint256 x, uint256 y) public pure returns(uint256) {
        uint256 result = 0;
        while (y > 0) {
            if (y % 2 == 1) {
                result = result + x;
            }
            x = x * 2;
            y = y / 2;
        }
        return result;
    }
}
