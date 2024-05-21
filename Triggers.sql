Trigger-1 


CREATE OR REPLACE TRIGGER update_inventory_on_donation_delete 
AFTER DELETE ON Donation_History 
FOR EACH ROW 
DECLARE 
inventory_quantity NUMBER(5,2); 
BEGIN 
SELECT quantity INTO inventory_quantity 
FROM Inventory 
WHERE donation_id = :OLD.donation_id; 
UPDATE Inventory 
SET quantity = quantity - :OLD.quantity 
WHERE donation_id = :OLD.donation_id; 
IF inventory_quantity = :OLD.quantity THEN 
DELETE FROM Inventory 
WHERE donation_id = :OLD.donation_id; 
END IF; 
END; 
/ 


Trigger-2 


CREATE TRIGGER update_medical_history_status 
AFTER INSERT ON Report 
FOR EACH ROW 
BEGIN 
UPDATE Medical_History 
SET status = 'Report Added' 
WHERE donor_id = (SELECT donor_id FROM Donation_History WHERE donation_id = 
(SELECT donation_id FROM Has_Report WHERE report_id = :NEW.report_id)); 
END; /