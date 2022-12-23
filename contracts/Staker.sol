pragma solidity ^0.8.18;

contract Staker {
    uint public deadline;
    uint public ran = 0;
    uint public constant threshold;
    mapping (address => uint) public balances;
    event Stake(address payer, uint256 amount);

    constructor(uint _deadline, uint _threshold) {
        deadline = _deadline;
        threshold = _threshold;
    }

    modifier isEnough {
        require(msg.value >= threshold);
        _;
    }

    modifier beforeDeadline {
        require(block.timestamp<deadline);
        _;
    }

    modifier pastDeadline {
        require(block.timestamp>=deadline);
        _;
    }

    modifier hasNotRun {
        require(ran==0);
        _;
    }

    function stake() payable public beforeDeadline {
        balances[msg.sender]+=msg.value;
        emit Stake(msg.sender, msg.value);
    }

    function timeLeft() returns(uint) {
        if(block.timestamp>=deadline) {return 0;}
        return deadline-block.timestamp;
    }

    function execute() public pastDeadline hasNotRun{
        if(address(this).balance >=threshold) {
            //run something here
        }
        else {
            //withdraw()
        }
        ran++;
    }

}