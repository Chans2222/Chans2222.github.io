pragma solidity ^0.4.23;

contract LegLeg {

    address Owner = 0x50D487BE7017815BC6aAe1Be4D6F8f62b21c9230;
    uint randNum;
    uint potNum;
    uint potMoney = 0;

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

    function game1(uint inputNum) public payable {
        randNum = uint(keccak256(abi.encodePacked(now, msg.sender, msg.value))) % 100;
        potNum = uint(keccak256(abi.encodePacked(now, msg.sender, msg.value))) % 1000;
        potMoney = potMoney + msg.value / 1000;
        if (inputNum >= randNum)
            msg.sender.transfer(msg.value * 985 / inputNum * 10);

        if (potNum == 777)
            msg.sender.transfer(potMoney);
    }

    function checkBalance() private view returns(uint) {
        return address(this).balance;
    }

    function withdraw() public onlyOwner {
        msg.sender.transfer(address(this).balance);
    }
}
