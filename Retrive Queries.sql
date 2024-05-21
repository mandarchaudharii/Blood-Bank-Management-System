--1)Retrieve Donors with Blood Type A+: 

SELECT * FROM Donor WHERE blood_type = 'A+'; 

--2)Retrieve Medical History for a Specific Donor: 

SELECT * FROM Medical_History WHERE donor_id = 'D1004'; 

--3)Update Cholesterol Level for a Report: 

UPDATE Medical_History SET cholesterol = 5.2 WHERE report_id = 'R1004'; 

--4)Retrieve Donations Made by Donor 'D1001': 

SELECT * FROM Donation_History WHERE donor_id = 'D1001'; 

--5)Retrieve Reports of info 'Blood Test Report': 

SELECT * FROM Report WHERE report_info = 'Blood Test Report'; 

--6)Retrieve Donations with Associated Reports: 

SELECT * FROM Has_Report; 

--7)Retrieve Recipient with ID 'RC1001': 

SELECT * FROM Recipient WHERE recipient_id = 'RC1001'; 

--8)Update Gender of Recipient 'RC1001' to 'F': 

UPDATE Recipient SET gender = 'F' WHERE recipient_id = 'RC1001'; 

--9)Retrieve Inventory Items with Blood Type 'AB-' and Quantity > 10:
 
SELECT * FROM Inventory WHERE blood_type = 'AB-' AND quantity > 10; 

--10)Retrieve Requests Made by Recipient 'RC1001': 

SELECT * FROM Request WHERE recipient_id = 'RC1001'; 

-- 11)Select the expired inventory items:

SELECT * FROM Inventory  
WHERE request_date < (CURRENT_DATE - INTERVAL '56' DAY); 

--12)Select rows from the Testing table that correspond to inventory items in the 
Inventory table where the request_date is older than 56 days from the current date:

SELECT * 
FROM Testing 
WHERE inventory_id IN ( 
SELECT inventory_id 
FROM Inventory 
WHERE request_date < (CURRENT_DATE - INTERVAL '56' DAY)); 

--13)Delete rows from the request table that correspond to inventory items in the 
Inventory table where the request_date is older than 56 days from the current date:

DELETE FROM request 
WHERE inventory_id IN ( 
SELECT inventory_id 
FROM Inventory 
WHERE request_date < (CURRENT_DATE - INTERVAL '56' DAY)); 

--14)Delete rows from the testing table that correspond to inventory items in the 
Inventory table where the request_date is older than 56 days from the current date:
 
DELETE FROM Testing 
WHERE inventory_id IN ( 
SELECT inventory_id 
FROM Inventory 
WHERE request_date < (CURRENT_DATE - INTERVAL '56' DAY)); 

--15)Delete the expired records from the Inventory table:

DELETE FROM Inventory 
WHERE request_date < (CURRENT_DATE - INTERVAL '56' DAY); 
 
--16)Retrieve Donors Who Donated the Maximum Quantity of Blood: 

SELECT d.donor_id, d.gender, d.dob, d.blood_type, dh.quantity 
FROM Donor d 
JOIN Donation_History dh ON d.donor_id = dh.donor_id 
WHERE dh.quantity = (SELECT MAX(quantity) FROM Donation_History); 

--17)Calculate Average Cholesterol Level of Male and Female Donors: 

SELECT d.gender, AVG(mh.cholesterol) AS avg_cholesterol 
FROM Donor d 
JOIN Medical_History mh ON d.donor_id = mh.donor_id 
GROUP BY d.gender; 

--18)List Recipients Who Haven't Received Any Blood Donation: 

SELECT r.recipient_id, r.name, r.blood_type 
FROM Recipient r 
LEFT JOIN Request rq ON r.recipient_id = rq.recipient_id 
WHERE rq.inventory_id IS NULL; 

--19)Find the Total Quantity of Blood Donated by Each Blood Type: 

SELECT d.blood_type, SUM(dh.quantity) AS total_donation_quantity 
FROM Donor d 
JOIN Donation_History dh ON d.donor_id = dh.donor_id 
GROUP BY d.blood_type; 

--20)Calculate the Total Quantity of Blood in Inventory for Each Blood Type: 

SELECT blood_type, SUM(quantity) AS total_quantity 
FROM Inventory 
GROUP BY blood_type; 
 
--21)Find Donors Who Haven't Donated Blood in the Last 6 Months: 

SELECT d.donor_id, d.gender, d.dob, d.blood_type 
FROM Donor d 
WHERE NOT EXISTS ( 
SELECT 1 
FROM Donation_History dh 
WHERE dh.donor_id = d.donor_id 
AND dh.donation_date >= (CURRENT_DATE - INTERVAL '6' MONTH))