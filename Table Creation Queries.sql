-- Donor table 

CREATE TABLE Donor ( 
donor_id VARCHAR(10), 
gender CHAR(1), 
dob DATE, 
blood_type VARCHAR(5), 
CONSTRAINT PK_Donor PRIMARY KEY (donor_id) 
);

-- Medical_History table 

CREATE TABLE Medical_History ( 
report_id VARCHAR(10), 
donor_id VARCHAR(10), 
bp VARCHAR(10), 
height NUMBER(5,2), 
weight NUMBER(5,2), 
cholesterol NUMBER(5,2), 
status VARCHAR(50), 
CONSTRAINT PK_Report_Medical_History PRIMARY KEY (report_id), 
CONSTRAINT FK_Donor_Medical_History FOREIGN KEY (donor_id) REFERENCES 
Donor(donor_id) 
);

-- Donation_History table 

CREATE TABLE Donation_History ( 
donation_id VARCHAR(10), 
donation_date DATE, 
quantity NUMBER(5,2), 
donor_id VARCHAR(10), 
CONSTRAINT PK_Donation_Donation_History PRIMARY KEY (donation_id), 
CONSTRAINT FK_Donor_Donation_History FOREIGN KEY (donor_id) REFERENCES 
Donor(donor_id) 
); 

-- Report table 

CREATE TABLE Report ( 
report_id VARCHAR(10), 
report_info VARCHAR(100), 
report_type VARCHAR(20), 
report_date DATE, 
CONSTRAINT PK_Report_Report PRIMARY KEY (report_id) 
); 

-- Has_Report table 

CREATE TABLE Has_Report ( 
donation_id VARCHAR(10), 
report_id VARCHAR(10), 
CONSTRAINT FK_Donation_Has_Report FOREIGN KEY (donation_id) REFERENCES 
Donation_History(donation_id), 
CONSTRAINT FK_Report_Has_Report FOREIGN KEY (report_id) REFERENCES 
Report(report_id) 
); 

-- Recipient table 

CREATE TABLE Recipient ( 
recipient_id VARCHAR(10), 
name VARCHAR(50), 
blood_type VARCHAR(5), 
gender CHAR(1), 
dob DATE, 
CONSTRAINT PK_Recipient PRIMARY KEY (recipient_id) 
); 

-- Inventory table
 
CREATE TABLE Inventory ( 
inventory_id VARCHAR(10), 
donation_id VARCHAR(10), 
blood_type VARCHAR(5),  
quantity NUMBER(5,2), 
storage VARCHAR(50), 
location VARCHAR(50), 
request_date DATE, 
request_id VARCHAR(10), 
CONSTRAINT PK_Inventory_Inventory PRIMARY KEY (inventory_id), 
CONSTRAINT FK_Donation_Inventory FOREIGN KEY (donation_id) REFERENCES 
Donation_History(donation_id) 
);

-- Request table 

CREATE TABLE Request ( 
recipient_id VARCHAR(10), 
inventory_id VARCHAR(10), 
CONSTRAINT FK_Recipient_Request FOREIGN KEY (recipient_id) REFERENCES 
Recipient(recipient_id), 
CONSTRAINT FK_Inventory_Request FOREIGN KEY (inventory_id) REFERENCES 
Inventory(inventory_id) 
); 

-- Testing table 

CREATE TABLE Testing ( 
screening_id VARCHAR(10), 
inventory_id VARCHAR(10), 
screening_date DATE, 
result VARCHAR(20), 
CONSTRAINT PK_Screening_Testing PRIMARY KEY (screening_id), 
CONSTRAINT FK_Inventory_Testing FOREIGN KEY (inventory_id) REFERENCES 
Inventory(inventory_id) 
);