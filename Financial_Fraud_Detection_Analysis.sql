###FINANCIAL FRAUD DETECTION AND TRANSACTION ANALYSIS 

## OBJECTIVES

#1. What percentage of transactions are fraudulent?
#2. Which transaction type has the highest fraud rate?
#3. Which transaction type processes the highest transaction amount?
#4. Are high-value transactions more likely to be fraudulent?
#5. How do account balances change during fraudulent transactions?
#6. What is the total financial impact of fraud?
#7. Which transaction categories contribute most to fraud losses?
#8. What patterns distinguish fraudulent transactions from normal transactions?
#9. How is transaction volume distributed across transaction types?
#10. What factors can help identify suspicious transactions?



CREATE DATABASE fraud_analysis;
USE fraud_analysis;

alter table ps_20174392719_1491204439457_log 
rename to Fraud_Transaction;

show tables;
select * from Fraud_Transaction;         

describe Fraud_Transaction; 
alter table Fraud_Transaction 
change step Transaction_Step int;

alter table Fraud_Transaction 
change type Transaction_Type varchar(50);

alter table Fraud_Transaction 
change amount Transaction_Amount decimal(15,2);

alter table Fraud_Transaction 
change nameOrig Sender_Name varchar(50);

alter table Fraud_Transaction 
change oldbalanceorg Before_Balance decimal(15,2);

alter table Fraud_Transaction 
change newbalanceorig New_balance decimal(15,2);

alter table Fraud_Transaction 
change nameDest Receiver_id  varchar(50);

alter table Fraud_Transaction
change oldbalanceDest Receiver_Balance_Before decimal(15,2);

alter table Fraud_Transaction 
change newbalanceDest Receiver_Balance_After decimal(15,2);

alter table Fraud_Transaction change 
isFraud Is_Fraud int;

alter table Fraud_Transaction 
change isFlaggedFraud Is_Flagged_Fraud int;

#1. What percentage of transactions are fraudulent?
select count(Is_Fraud) from Fraud_Transaction where Is_Fraud=1 ;
select count(*) from Fraud_Transaction;
select count(*)from Fraud_Transaction where Is_Fraud =1 ;
select 133 as Fraud_Transaction,
157759 as Total_Transaction,
(133/157759.0)*100 as Fraud_Percentage;
select * from Fraud_Transaction; 

#2. Which transaction type has the highest fraud rate?
select sum(Is_Fraud),
Transaction_Type from Fraud_Transaction 
where Is_fraud = 1 group by Transaction_Type ;

#3. Which transaction type processes the highest transaction amount?
select sum(Transaction_Amount),
Transaction_Type from Fraud_Transaction 
group by Transaction_Type;

#4. Are high-value transactions more likely to be fraudulent?
select avg(Transaction_Amount),
Is_Fraud from Fraud_Transaction 
group by Is_Fraud;

#5. How do account balances change during fraudulent transactions?
describe Fraud_Transaction;

select sum(Before_Balance),
sum(New_balance),
Is_Fraud from Fraud_Transaction 
group by Is_Fraud;

#6. What is the total financial impact of fraud?
select sum(Transaction_Amount) from Fraud_Transaction; 
       
select sum(Transaction_Amount),
Is_Fraud from Fraud_Transaction 
where Is_Fraud = 1 group by Is_Fraud;

select 28166703937.52 as Total_Amount,
80807378.22  as Fraud_Amount,
28166703937.52 - 80807378.22  as Safe_Amount;

#7. Which transaction categories contribute most to fraud losses?
select Transaction_Type ,
sum(Transaction_Amount) 
from Fraud_Transaction 
where Is_Fraud =1 
group by Transaction_Type;

#9. How is transaction volume distributed across transaction types?
select * from Fraud_Transaction;

select count(Transaction_Amount),
sum(Transaction_Amount),
Transaction_Type from Fraud_Transaction 
group by Transaction_Type;

#10. What factors can help identify suspicious transactions? 
