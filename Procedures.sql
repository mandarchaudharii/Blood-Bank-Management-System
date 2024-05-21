Procedure-1 


CREATE OR REPLACE PROCEDURE add_new_donor( 
p_donor_id VARCHAR2, 
p_gender VARCHAR2, 
p_dob_str VARCHAR2, 
p_blood_type VARCHAR2 
) 
IS 
BEGIN -- Convert the string to a DATE data type 
INSERT INTO Donor (donor_id, gender, dob, blood_type) 
VALUES (p_donor_id, p_gender, TO_DATE(p_dob_str, 'YYYY-MM-DD'), p_blood_type); 
END; 
/ 


Procedure-2 


CREATE OR REPLACE PROCEDURE CheckBloodAvailability ( 
p_blood_type VARCHAR2 
) 
IS 
available_quantity NUMBER; 
BEGIN 
SELECT SUM(quantity) INTO available_quantity 
FROM Inventory 
WHERE blood_type = p_blood_type 
AND request_id IS NULL; 
IF available_quantity > 0 THEN 
DBMS_OUTPUT.PUT_LINE('Sufficient blood of type ' || p_blood_type || ' available.'); 
ELSE 
21 
DBMS_OUTPUT.PUT_LINE('Insufficient blood of type ' || p_blood_type || ' available.'); 
END IF; 
END; 
/