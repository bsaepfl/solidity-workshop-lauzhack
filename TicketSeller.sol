// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.23;

contract TicketSeller {
    // how much do people have to pay for the ticket
    uint256 public price = 30; // 1 ether is 1e18 wei
    address public owner;

    // who has a ticket (and who doesn't)
    // user -> has a ticket?
    mapping(address => bool) public tickets;

    constructor(address _owner) {
        owner = _owner;
    }

    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert("unauthorized");
        }
        _;
    }

    function setPrice(uint256 newPrice) onlyOwner external {
        price = newPrice;
    }

    function buyTicket() payable external {
        // we can access
        // the amount of money sent with msg.value
        // the sender (the user) with msg.sender

        if (msg.value != price) {
            revert("wrong amount");
        }

        tickets[msg.sender] = true;
    }
}