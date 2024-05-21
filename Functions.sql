1. Function for CalculatinBMI and checking donor's status 


CREATE OR REPLACE FUNCTION CalculateBMIAndStatus 
( 
p_donor_id DONOR.DONOR_ID%TYPE 
) 
RETURN VARCHAR2 
AS 
v_height   NUMBER; 
v_weight   NUMBER; 
v_bmi      NUMBER; 
v_status   VARCHAR2(20); 
BEGIN 
SELECT height, weight 
INTO v_height, v_weight 
FROM Medical_History 
WHERE donor_id = p_donor_id 
ORDER BY report_id DESC 
FETCH FIRST 1 ROW ONLY; 
v_height := v_height / 100; -- Convert height from centimeters to meters 
v_bmi := v_weight / (v_height * v_height); 
IF v_bmi < 18.5 THEN 
v_status := 'Underweight'; 
ELSIF v_bmi >= 18.5 AND v_bmi < 25 THEN 
v_status := 'Healthy'; 
ELSIF v_bmi >= 25 AND v_bmi < 30 THEN 
v_status := 'Overweight'; 
ELSE 
v_status := 'Obese'; 
END IF; 
RETURN 'BMI: ' || ROUND(v_bmi, 2) || ', Status: ' || v_status; 
EXCEPTION 
WHEN NO_DATA_FOUND THEN 
RETURN 'No medical history found'; 
END; 
/ 
 


2. Blood Compatibility Function 
 
CREATE OR REPLACE FUNCTION CheckBloodCompatibility 
  ( 
    p_donor_blood_type   VARCHAR2, 
    p_recipient_blood_type VARCHAR2 
  ) 
RETURN VARCHAR2 
AS 
  v_compatible VARCHAR2(20); 
BEGIN 
  IF p_donor_blood_type = 'O-' THEN 
    v_compatible := 'Compatible'; 
  ELSIF  
        p_donor_blood_type = 'O+' AND 
        (p_recipient_blood_type LIKE 'O%' OR 
         p_recipient_blood_type LIKE 'A%' OR 
         p_recipient_blood_type LIKE 'B%' OR 
         p_recipient_blood_type LIKE 'AB%') THEN 
         v_compatible := 'Compatible'; 
  ELSIF 
         p_donor_blood_type = 'A-' AND 
        (p_recipient_blood_type = 'A+' OR 
         p_recipient_blood_type = 'AB+' OR 
         p_recipient_blood_type = 'A-' OR 
         p_recipient_blood_type = 'AB-') THEN 
         v_compatible := 'Compatible'; 
  ELSIF  
         p_donor_blood_type = 'A+' AND 
        (p_recipient_blood_type LIKE 'A%' OR 
         p_recipient_blood_type LIKE 'AB%') THEN 
         v_compatible := 'Compatible'; 
  ELSIF  
         p_donor_blood_type = 'B-' AND 
        (p_recipient_blood_type = 'B+' OR 
         p_recipient_blood_type = 'AB+' OR 
         p_recipient_blood_type = 'B-' OR 
         p_recipient_blood_type = 'AB-') THEN 
         v_compatible := 'Compatible'; 
  ELSIF  
         p_donor_blood_type = 'B+' AND 
        (p_recipient_blood_type LIKE 'B%' OR 
         p_recipient_blood_type LIKE 'AB%') THEN 
         v_compatible := 'Compatible'; 
  ELSIF 
        p_donor_blood_type = 'AB-' AND 
        (p_recipient_blood_type = 'AB+' OR 
         p_recipient_blood_type = 'AB-') THEN 
         v_compatible := 'Compatible'; 
 
ELSIF  
p_donor_blood_type = 'AB+' AND 
p_recipient_blood_type = 'AB+' THEN 
v_compatible := 'Compatible'; 
ELSE 
v_compatible := 'Incompatible'; 
END IF; 
RETURN v_compatible; 
END; 
/