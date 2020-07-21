pragma solidity ^0.5.1;
contract Blockbank {
    address payable owner;
    uint usersId;
    uint initialfunding;
    struct customer{
    address payable userAddress;
    string name;
    uint userId;
    bool created;
    uint totalAmount;
        }
        
    constructor() public payable {
        owner = msg.sender;
        require(msg.value > 2 ether, "2 ether initial funding required");
        initialfunding = msg.value;
        }
    mapping(address=>customer) private accounts;
    address payable[] addresslist;
    event AuditLogDeposits (address user, uint amount);
    event AuditLogwithdrawal(address user, uint amount);
    event AuditLogBorrows(address user, uint amount);
   
    
    
    function deposit(uint amount) public payable{
        require(usersId<10, "Max 10 accounts required");
        if (!accounts[msg.sender].created){
           accounts[msg.sender].userAddress = msg.sender;
           //Addresslist[usersId]= msg.sender;
           usersId+=1;
           accounts[msg.sender].userId= usersId;
           accounts[msg.sender].created = true;
           addresslist.push(msg.sender);
        }
        require(msg.value==uint(amount), "Right amount required");
        require(accounts[msg.sender].created, "Existing accounts required");
        accounts[msg.sender].totalAmount+= amount;
        emit AuditLogDeposits(msg.sender, msg.value);
        }
     
    function borrow(uint borrowamount) public payable{
        require(accounts[msg.sender].created);
        require(address(this).balance-uint(borrowamount)>=1);
        msg.sender.transfer(uint(borrowamount));
        if (accounts[msg.sender].totalAmount>=borrowamount){
            accounts[msg.sender].totalAmount-=borrowamount;}
        if (accounts[msg.sender].totalAmount<borrowamount){
            accounts[msg.sender].totalAmount-=borrowamount*21/20;
        }
        emit AuditLogBorrows(msg.sender, msg.value);
        }
        
    function withdraw(uint amounts) public payable {
        require(accounts[msg.sender].totalAmount>=amounts);
        require(accounts[msg.sender].created);
        msg.sender.transfer(uint(amounts));
        accounts[msg.sender].totalAmount-= amounts;
        emit AuditLogwithdrawal(msg.sender, msg.value);
       }
    
    modifier onlyOwner{
      require(msg.sender == owner);
      _;
       }
   
        
    function closebank() public onlyOwner {
       for ( uint i=0; i<usersId; i++) {
       require(accounts[addresslist[i]].totalAmount>=0, "No negative deposit required." );
       addresslist[i].transfer(accounts[addresslist[i]].totalAmount);
       accounts[addresslist[i]].totalAmount = 0;
        } 
       owner.transfer(initialfunding);
       }
    
    

    function getRemainingBankBalance() public view returns(uint) {
         return (address(this).balance);
        }
    function balance() public view returns(int) {
        return (int(accounts[msg.sender].totalAmount));
        }
    function setBankOwner (address payable newOwner) public {
        
    owner = newOwner;    
    }
    
    // Deployed contracts on Roptsten testing network
    // 0x9c4a3a1255f58de3960f2aca17d2f5c72f1f30de
    
    
    // The following code help to test whether the code meet the requirement
    /*function getMyAccountAddress() public view returns(address) {
        return (accounts[msg.sender].userAddress);
        }
    function getMyAccountId() public view returns(uint) {
        return (accounts[msg.sender].userId);
        }
    function getMyAccountName() public view returns(string memory) {
        return (accounts[msg.sender].name);
         }
    */
    
    }