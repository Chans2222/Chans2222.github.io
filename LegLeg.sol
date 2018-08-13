pragma solidity ^0.4.23;

contract LegLeg {

    address Owner = 0x50D487BE7017815BC6aAe1Be4D6F8f62b21c9230;

    event Failed(address beneficiary, uint amount);
    event Successed(address beneficiary, uint amount);

    modifier onlyOwner {
        require(msg.sender == Owner, "You can't access");
        _;
    }

    function deposit() public payable onlyOwner {
        require(msg.value != 0, "Deposit more than 0 ether!!");
    }

    modifier spare {
        require(address(this).balance >= msg.value * 5, " Not Enough Fund");
        _;
    }

    function game1() public payable {
        if (uint(keccak256(abi.encodePacked(now, msg.sender, msg.value))) % 2 == 1) {
            msg.sender.transfer(msg.value * 2);
        }
    }

     function game2() public payable {
        if (uint(keccak256(abi.encodePacked(now, msg.sender, msg.value))) % 5 == 1) {
            msg.sender.transfer(msg.value * 5);
        }
    }

     function choice(uint choiceNum) public payable spare returns(uint) {
        if (choiceNum == 1) {
            //require(address(this).balance >= msg.value * 2, " Not Enough Fund");
            game1();
            emit Successed(msg.sender, msg.value);
        }
        else if (choiceNum == 2) {
            //require(address(this).balance >= msg.value * 5, " Not Enough Fund");
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

    function withdraw() public onlyOwner {
        msg.sender.transfer(address(this).balance);
  }
}
