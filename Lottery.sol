pragma solidity >=0.7.0 <0.9.0;

contract lot{
    address public manager;
    //0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
    address payable[] public participants;
    constructor () public {
        manager=msg.sender;
    }
    function enterlot() public payable {
        require(msg.value > 1 ether);
        participants.push(payable(msg.sender));
    }
    function picwin () public {
        require(msg.sender == manager);
        uint index = random() % participants.length;
        participants[index].transfer(address(this).balance);
        participants = new address payable[](0);
    }
    function random () private view returns(uint256){
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, participants)));
    }
}
