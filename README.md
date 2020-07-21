# Etherum-smart-contract
### Functions
• deposit: deposit x value from user’s wallet create account at bank if account does not exist

• withdraw: withdraw y value from user’s balance

• borrow: borrow z value from the bank, even if the balance < borrow
amount. Incurs 5% repay interest to user’s balance

• balance: output the user’s current balance

• closeBank: if no outstanding negative balance, bank owner can return all
funding back to their users (including owner)

### Checking Required

• Require initial funding of bank > 2 ether. Ensure there is enough funding before any transfer

• Every deposit, withdrawn and borrow will emit AuditLog

• Not allow to borrow if bank’s total remaining balance is < 1 ether after transfer ether to borrower
 
• Only bank creator can close the bank
 
• Max 10 accounts are allowed
