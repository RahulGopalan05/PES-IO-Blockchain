// SPDX-License-Identifier: MIT
pragma solidity >0.6.0 <0.9.0;

contract arrayOperations {
    function concatenateStrings(string memory str1, string memory str2) public pure returns (string memory) {
    bytes memory bytesStr1 = bytes(str1);
    bytes memory bytesStr2 = bytes(str2);

    bytes memory concatenated = new bytes(bytesStr1.length + bytesStr2.length);
    
    uint256 k = 0;
    for (uint256 i = 0; i < bytesStr1.length; i++) {
        concatenated[k++] = bytesStr1[i];
    }
    for (uint256 j = 0; j < bytesStr2.length; j++) {
        concatenated[k++] = bytesStr2[j];
    }

    
    string memory result = string(concatenated);
    return result;
}


    function compareStrings(string memory str1, string memory str2) public pure returns (bool) {
    uint256 length1 = bytes(str1).length;
    uint256 length2 = bytes(str2).length;

    if (length1 != length2) {
        return false;
    }

    for (uint256 i = 0; i < length1; i++) {
        if (bytes(str1)[i] != bytes(str2)[i]) {
            return false;
        }
    }

    return true;
}


    function searchnumber(uint256[] memory arr, uint256 target) public pure returns (bool) {
        for (uint256 i = 0; i < arr.length; i++) {
            if (arr[i] == target) {
                return true;
            }
        }
        return false;
    }

    function findlargest(uint256[] memory arr) public pure returns (uint256) {
        uint256 max = 0;
        for (uint256 i = 0; i < arr.length; i++) {
            if (arr[i] > max) {
                max = arr[i];
            }
        }
        return max;
    }
    function sortarray(uint256[] memory arr) public pure returns (uint256[] memory) {
        uint256 n = arr.length;
        for (uint256 i = 0; i < n-1; i++) {
            for (uint256 j = 0; j < n-i-1; j++) {
                if (arr[j] > arr[j+1]) {
                    (arr[j], arr[j+1]) = (arr[j+1], arr[j]);
                }
            }
        }
        return arr;
    }

    function reversearray(uint256[] memory arr) public pure returns (uint256[] memory) {
        uint256[] memory reversedArr = new uint256[](arr.length);
        for (uint256 i = 0; i < arr.length; i++) {
            reversedArr[arr.length - 1 - i] = arr[i];
        }
        return reversedArr;
    }

    function insertelement(uint256[] memory arr, uint256 index, uint256 element) public pure returns (uint256[] memory) {
        require(index <= arr.length, "invalid");
        uint256[] memory result = new uint256[](arr.length + 1);
        for (uint256 i = 0; i < index; i++) {
            result[i] = arr[i];
        }
        result[index] = element;
        for (uint256 i = index + 1; i < result.length; i++) {
            result[i] = arr[i - 1];
        }
        return result;
    }

    function sumarray(uint256[] memory arr) public pure returns (uint256) {
        uint256 sum = 0;
        for (uint256 i = 0; i < arr.length; i++) {
            sum += arr[i];
        }
        return sum;
    }
}
