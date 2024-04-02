

// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.5.0 <0.9.0;

contract CrossBorderPayment {
   address payable public owner;
    
//mapping to store user balances
mapping(address => uint256) public balances;

event Deposit(address indexed _from, uint256 _value);

// Event declaration for payment initialization
   event PaymentSent(address sender, address recipient, uint amount, string currency);

   constructor()  {
        owner == msg.sender;
   }
    // 0: Function to deposit money into the contract
    // This increases the sender's balance within the contract
   function deposit() public payable {
    require(msg.value > 0, "Deposit amount must be greater than zero.");
   balances[msg.sender] += msg.value;
   emit Deposit(msg.sender, msg.value);
   }

 // 1: Function to get the balance of the sender
    function getSenderBalance() external view returns (uint256) {
        // Retrieve the balance of the sender
        return balances[msg.sender];
    }

    // 2: Function to calculate taxes based on a given amount and tax rate
    function TaxRate(uint256 amount, uint256 tax) external pure returns (uint256) {
        // Ensure the tax rate is valid (0% - 100%)
        require(tax <= 100, "Tax rate must be less than or equal to 100");
        uint256 taxAmount = (amount * tax) / 100;

        return taxAmount;
    }


   // 3: Function to send specified token to recipient
   function sendPayment(address payable _recipient, uint _amount, string memory currency) public payable {
       // Guarantee that sender forwarded required funds for transaction and isnt trying to send more than they have in their account
       require(msg.value > 0, "Amount sent must be greater than 0");
       require(address(this).balance >= _amount, "Insufficient balance in the contract");
       require(_recipient != address(0), "Invalid recipient address");

        _recipient.transfer(_amount);
    


       // Emit an event to log the payment execution
       emit PaymentSent(msg.sender, _recipient, msg.value, currency);
   }

   // Function to handle cross-border payments
   function processPayment(address payable receiver, uint amount, string memory currency) public {
       // Emitting an event after successful payment processing
       emit PaymentSent(msg.sender, receiver, amount, currency);

       // Transfer the specified amount to the receiver
       receiver.transfer(amount);
   }

   // Function to deposit funds into the contract
  // receive() external payable {}

   // Ensure only the owner can withdraw funds (for simplicity)
   /*function withdraw(uint amount) public payable {
    require(msg.sender == owner, "Only the owner can withdraw.");
    require(address (this).balance >= amount, "Insufficient balance in the contract");
    owner.transfer(amount);
}
*/
function withdraw(uint amount) public {
    require(msg.sender == owner, "Only the owner can withdraw.");
    require(address(this).balance >= amount, "Insufficient balance in the contract");
    owner.transfer(amount);
}
}
