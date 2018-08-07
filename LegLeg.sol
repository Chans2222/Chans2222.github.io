pragma solidity ^0.4.23;
contract LegLeg {

    event Failed(address beneficiary, uint amount);
    event Successed(address beneficiary, uint amount);

    struct Bet {
        uint amount;
        uint8 gameNum;
        address gambler;
    }

    mapping (uint => Bet) bets;

    function deposit() public payable {
        require(msg.value != 0, "Deposit more than 0ether!!");
    }

    modifier spare {
        require(address(this).balance >= msg.value * 10, " Not Enough Fund");
        _;
    }

    function game1() public payable {
        if (uint(keccak256(abi.encodePacked(now, msg.sender, msg.value))) % 2 == 1) {
            msg.sender.transfer(msg.value * 2);
        }
    }

     function game2() public payable {
        if (uint(keccak256(abi.encodePacked(now, msg.sender, msg.value))) % 6 == 1) {
            msg.sender.transfer(msg.value * 6);
        }
    }

     function choice(uint choiceNum) public payable spare returns(uint) {
        if (choiceNum == 1) {
            game1();
            emit Successed(msg.sender, msg.value);
        }
        else if (choiceNum == 2) {
            game2();
            emit Successed(msg.sender, msg.value);
        }
        else {
            msg.sender.transfer(msg.value);
            emit Failed(msg.sender, msg.value);
            choiceNum == 1;
        }
    }

    function checkBalance() public view returns(uint) {
        return address(this).balance;
    }
}
