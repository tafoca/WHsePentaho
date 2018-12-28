/*--------------------------  TEST FUNCTION UPPER -----------------------------*/

DELIMITER $
DROP PROCEDURE IF EXISTS test_upper1;
CREATE PROCEDURE test_upper1(IN v_nom VARCHAR(30),IN v_prenom VARCHAR(30))
BEGIN
/*DECLARE v_telephone CHAR(14) DEFAULT '06-76-85-14-89';*/
SELECT CONCAT(UPPER(v_nom) ,' ',UPPER(v_prenom)) AS CONCATENATION;
END;
$

DELIMITER $
DROP PROCEDURE IF EXISTS test_upper2;
CREATE PROCEDURE test_upper2()
BEGIN
/*DECLARE v_telephone CHAR(14) DEFAULT '06-76-85-14-89';*/
SELECT CONCAT(UPPER(nom) ,' ',UPPER(prenom)) AS TEACHER FROM profs WHERE type = 'P';
END;
$

/*--------------------------  TEST FUNCTION LOWER -----------------------------*/

DELIMITER $
DROP PROCEDURE IF EXISTS test_lower1;
CREATE PROCEDURE test_lower1(IN v_nom VARCHAR(30),IN v_prenom VARCHAR(30))
BEGIN
/*DECLARE v_telephone CHAR(14) DEFAULT '06-76-85-14-89';*/
SELECT CONCAT(LOWER(v_nom) ,' ',LOWER(v_prenom)) AS CONCATENATION;
END;
$

DELIMITER $
DROP PROCEDURE IF EXISTS test_lower2;
CREATE PROCEDURE test_lower2()
BEGIN
/*DECLARE v_telephone CHAR(14) DEFAULT '06-76-85-14-89';*/
SELECT CONCAT(LOWER(nom) ,' ',LOWER(prenom)) AS TEACHER FROM profs WHERE type = 'P';
END;
$

/*--------------------------  TEST FUNCTION LENGTH -----------------------------*/

DELIMITER $
DROP PROCEDURE IF EXISTS test_length1;
CREATE PROCEDURE test_length1(IN v_chaine VARCHAR(30))
BEGIN
DECLARE v_length INT(11) DEFAULT 'tadani';
SET v_length := LENGTH(v_chaine);
SELECT CONCAT('The Size of chaine <',v_chaine,'>',' ','is',' : ',v_length) AS SizeChaine;
END;
$


DELIMITER $
DROP PROCEDURE IF EXISTS test_length2;
CREATE PROCEDURE test_length2(IN v_chaine VARCHAR(30))
BEGIN
DECLARE v_length INT(11) DEFAULT 'tadani';
SET v_length := LENGTH(v_chaine);
IF v_length > 10 THEN
SELECT CONCAT('The Size of chaine <',v_chaine,'>',' ','is',' greather than 10') AS Info;
ELSE
SELECT CONCAT('The Size of chaine <',v_chaine,'>',' ','is',' less than 10') AS Info;
END IF;
END;
$

/*--------------------------  TEST FUNCTION LEFT,RIGHT and SUBSTR( les Extractions) -----------------------------*/

DELIMITER $
DROP PROCEDURE IF EXISTS extract_left;
CREATE PROCEDURE extract_left(IN v_chaine VARCHAR(30),IN n INT(11))
BEGIN
DECLARE v_result VARCHAR(30) DEFAULT 'tadani';
SET v_result := LEFT(v_chaine,n);
SELECT CONCAT('The new chaine is : ',v_result,' --> ','SIZE<',v_result,'>',' = ',LENGTH(v_result)) AS RESULT;
END;
$

DELIMITER $
DROP PROCEDURE IF EXISTS extract_right;
CREATE PROCEDURE extract_right(IN v_chaine VARCHAR(30),IN n INT(11))
BEGIN
DECLARE v_result VARCHAR(30) DEFAULT 'tadani';
SET v_result := RIGHT(v_chaine,n);
SELECT CONCAT('The new chaine is : ',v_result,' --> ','SIZE<',v_result,'>',' = ',LENGTH(v_result)) AS RESULT;
END;
$

DELIMITER $
DROP PROCEDURE IF EXISTS extract_substr;
CREATE PROCEDURE extract_substr(IN v_chaine VARCHAR(30),IN n INT(11),IN p INT(11))
BEGIN
DECLARE v_result VARCHAR(30) DEFAULT 'tadani';
SET v_result := SUBSTR(v_chaine,n,p);
SELECT CONCAT('The new chaine is : ',v_result,' --> ','SIZE<',v_result,'>',' = ',LENGTH(v_result)) AS RESULT;
END;
$

/*--------------------------  TEST FUNCTION TRIM( les REMPLACEMENTS) -----------------------------*/

DELIMITER $
DROP PROCEDURE IF EXISTS extract_trim;
CREATE PROCEDURE extract_trim(IN v_char CHAR(10),IN v_chaine VARCHAR(10))
BEGIN
DECLARE v_result VARCHAR(30) DEFAULT 'tadani';
SET v_result := TRIM(v_char FROM v_chaine);
SELECT CONCAT('The new chaine is : ',v_result,' --> ','SIZE<',v_result,'>',' = ',LENGTH(v_result)) AS RESULTAT;
END;
$

/*-------------------------------------------------------------------------------------------------------------------------------
                                M A N A G E M E N T      O F     A L E R T S 
----------------------------------------------------------------------------------------------------------------------------------  */

/*--------------------------  ALERT ALL THE TEACHERS ABOUT NEWS -----------------------------*/

DELIMITER $
DROP PROCEDURE IF EXISTS alertNews_teachers;
CREATE PROCEDURE alertNews_teachers(IN v_titre VARCHAR(10),IN v_date VARCHAR(10))
BEGIN
 DECLARE fincurs BOOLEAN DEFAULT 0;
 DECLARE v_nom VARCHAR(50);
 DECLARE v_prenom VARCHAR(50);
 DECLARE v_portable VARCHAR(50);
  DECLARE v_year VARCHAR(50);
 DECLARE v_month VARCHAR(50);
 DECLARE v_day VARCHAR(50);
DECLARE curs CURSOR FOR SELECT nom,prenom,portable FROM schooladmin.profs WHERE type = 'P';
DECLARE CONTINUE HANDLER FOR NOT FOUND 
SET fincurs := 1;
 OPEN curs; 
 FETCH curs INTO v_nom,v_prenom,v_portable;
 WHILE (NOT fincurs) DO 
IF (v_portable = '' OR v_portable IS NULL) THEN
SET v_portable := '675820467';
END IF;
  SET v_year := LEFT(v_date,4);
SET v_month := SUBSTR(v_date,6,2);
SET v_day := RIGHT(v_date,2);
 INSERT INTO schooladmin.ozekimessageout(receiver,msg,status) VALUES (v_portable,CONCAT('M.',v_nom,' ',v_prenom,' You informed that the information entitled : ',v_titre,' have been publish on the server the ',v_day,'/',v_month,'/',v_year),'send');
  FETCH curs INTO v_nom,v_prenom,v_portable;
END WHILE;
CLOSE curs;
END;
$

/*--------------------------  ALERT EVERY PROFS ABOUT NEWS -----------------------------*/

DELIMITER $
DROP PROCEDURE IF EXISTS alertNews_admins;
CREATE PROCEDURE alertNews_admins(IN v_titre VARCHAR(10),IN v_date VARCHAR(10))
BEGIN
 DECLARE fincurs BOOLEAN DEFAULT 0;
 DECLARE v_nom VARCHAR(50);
 DECLARE v_prenom VARCHAR(50);
 DECLARE v_portable VARCHAR(50);
  DECLARE v_year VARCHAR(50);
 DECLARE v_month VARCHAR(50);
 DECLARE v_day VARCHAR(50);
DECLARE curs CURSOR FOR SELECT nom,prenom,portable FROM schooladmin.profs;
DECLARE CONTINUE HANDLER FOR NOT FOUND 
SET fincurs := 1;
 OPEN curs;
 
 FETCH curs INTO v_nom,v_prenom,v_portable;
 WHILE (NOT fincurs) DO 
IF (v_portable = '' OR v_portable IS NULL) THEN
SET v_portable := '675820467';
END IF;
  SET v_year := LEFT(v_date,4);
SET v_month := SUBSTR(v_date,6,2);
SET v_day := RIGHT(v_date,2);
 INSERT INTO schooladmin.ozekimessageout (receiver,msg,status) VALUES (v_portable,CONCAT('M.',v_nom,' ',v_prenom,' You informed that the information entitled : ',v_titre,' have been publish on the server the ',v_day,'/',v_month,'/',v_year),'send');
  FETCH curs INTO v_nom,v_prenom,v_portable;
END WHILE;
CLOSE curs;
END;
$

/*--------------------------  ALERT EVERY STUDENTS ABOUT NEWS -----------------------------*/

DELIMITER $
DROP PROCEDURE IF EXISTS alertNews_parents;
CREATE PROCEDURE alertNews_parents(IN v_titre VARCHAR(10),IN v_date VARCHAR(10))
BEGIN
 DECLARE fincurs BOOLEAN DEFAULT 0;
 DECLARE v_nompere VARCHAR(50);
 DECLARE v_prenompere VARCHAR(50);
 DECLARE v_portablepere VARCHAR(50);
  DECLARE v_nommere VARCHAR(50);
 DECLARE v_prenommere VARCHAR(50);
 DECLARE v_portablemere VARCHAR(50);
  DECLARE v_year VARCHAR(50);
 DECLARE v_month VARCHAR(50);
 DECLARE v_day VARCHAR(50);
DECLARE curs CURSOR FOR SELECT nom_pere,prenom_pere,portable_pere,nom_mere,prenom_mere,portable_mere FROM schooladmin.eleves;
DECLARE CONTINUE HANDLER FOR NOT FOUND 
SET fincurs := 1;
 OPEN curs;
 
 FETCH curs INTO v_nompere,v_prenompere,v_portablepere,v_nommere,v_prenommere,v_portablemere;
 WHILE (NOT fincurs) DO 
IF (v_portablepere = '' OR v_portablepere IS NULL) THEN
SET v_portablepere := '675820467';
END IF;
IF (v_portablemere = '' OR v_portablemere IS NULL) THEN
SET v_portablemere := '675820467';
END IF;
  SET v_year := LEFT(v_date,4);
SET v_month := SUBSTR(v_date,6,2);
SET v_day := RIGHT(v_date,2);
 INSERT INTO schooladmin.ozekimessageout (receiver,msg,status) VALUES (v_portablepere,CONCAT('Mr.',v_nompere,' ',v_prenompere,' You informed that the information entitled : ',v_titre,' have been publish on the server the ',v_day,'/',v_month,'/',v_year),'send');
 INSERT INTO schooladmin.ozekimessageout (receiver,msg,status) VALUES (v_portablepere,CONCAT('Mme.',v_nommere,' ',v_prenommere,' You informed that the information entitled : ',v_titre,' have been publish on the server the ',v_day,'/',v_month,'/',v_year),'send');
 FETCH curs INTO v_nompere,v_prenompere,v_portablepere,v_nommere,v_prenommere,v_portablemere;
END WHILE;
CLOSE curs;
END;
$


/*-------------------------------------------------------------------------------------------------------------------------------
                                     M A N A G E M E N T      O F     U P D A T I N G
----------------------------------------------------------------------------------------------------------------------------------  */

/*--------------------------  UPDATE NEWS  AND REPLY TO TEACHERS -----------------------------*/

DELIMITER $
DROP PROCEDURE IF EXISTS updateNews_teachers;
CREATE PROCEDURE updateNews_teachers(IN v_titre VARCHAR(10),IN v_date VARCHAR(10))
BEGIN
 DECLARE fincurs BOOLEAN DEFAULT 0;
  DECLARE v_id INT(50);
 DECLARE v_nom VARCHAR(50);
 DECLARE v_prenom VARCHAR(50);
 DECLARE v_portable VARCHAR(50);
 DECLARE v_year VARCHAR(50);
 DECLARE v_month VARCHAR(50);
 DECLARE v_day VARCHAR(50);
DECLARE curs CURSOR FOR SELECT id,nom,prenom,portable FROM schooladmin.profs WHERE type = 'P';
DECLARE CONTINUE HANDLER FOR NOT FOUND 
SET fincurs := 1;
 OPEN curs; 
 FETCH curs INTO v_id,v_nom,v_prenom,v_portable;
 WHILE (NOT fincurs) DO 
IF (v_portable = '' OR v_portable IS NULL) THEN
SET v_portable := '675820467';
END IF;
  SET v_year := LEFT(v_date,4);
SET v_month := SUBSTR(v_date,6,2);
SET v_day := RIGHT(v_date,2);
 UPDATE schooladmin.ozekimessageout SET msg := CONCAT('M.',v_nom,' ',v_prenom,' You informed that the information entitled : ',v_titre,' have been publish on the server the ',v_day,'/',v_month,'/',v_year) WHERE receiver = v_portable;
 FETCH curs INTO v_id,v_nom,v_prenom,v_portable;
END WHILE;
CLOSE curs;
END;
$


/*--------------------------  UPDATE NEWS  AND REPLY TO ADMINS -----------------------------*/

DELIMITER $
DROP PROCEDURE IF EXISTS updateNews_admins;
CREATE PROCEDURE updateNews_admins(IN v_titre VARCHAR(10),IN v_date VARCHAR(10))
BEGIN
 DECLARE fincurs BOOLEAN DEFAULT 0;
  DECLARE v_id INT(50);
 DECLARE v_nom VARCHAR(50);
 DECLARE v_prenom VARCHAR(50);
 DECLARE v_portable VARCHAR(50);
 DECLARE v_year VARCHAR(50);
 DECLARE v_month VARCHAR(50);
 DECLARE v_day VARCHAR(50);
DECLARE curs CURSOR FOR SELECT id,nom,prenom,portable FROM schooladmin.profs;
DECLARE CONTINUE HANDLER FOR NOT FOUND 
SET fincurs := 1;
 OPEN curs; 
 FETCH curs INTO v_id,v_nom,v_prenom,v_portable;
 WHILE (NOT fincurs) DO 
IF (v_portable = '' OR v_portable IS NULL) THEN
SET v_portable := '675820467';
END IF;
  SET v_year := LEFT(v_date,4);
SET v_month := SUBSTR(v_date,6,2);
SET v_day := RIGHT(v_date,2);
 UPDATE schooladmin.ozekimessageout SET msg := CONCAT('M.',v_nom,' ',v_prenom,' You informed that the information entitled : ',v_titre,' have been publish on the server the ',v_day,'/',v_month,'/',v_year) WHERE receiver = v_portable;
 FETCH curs INTO v_id,v_nom,v_prenom,v_portable;
END WHILE;
CLOSE curs;
END;
$

/*--------------------------  UPDATE NEWS  AND REPLY TO PARENTS -----------------------------*/

DELIMITER $
DROP PROCEDURE IF EXISTS updateNews_parents;
CREATE PROCEDURE updateNews_parents(IN v_titre VARCHAR(10),IN v_date VARCHAR(10))
BEGIN
  DECLARE fincurs BOOLEAN DEFAULT 0;
 DECLARE v_nompere VARCHAR(50);
 DECLARE v_prenompere VARCHAR(50);
 DECLARE v_portablepere VARCHAR(50);
  DECLARE v_nommere VARCHAR(50);
 DECLARE v_prenommere VARCHAR(50);
 DECLARE v_portablemere VARCHAR(50);
  DECLARE v_year VARCHAR(50);
 DECLARE v_month VARCHAR(50);
 DECLARE v_day VARCHAR(50);
DECLARE curs CURSOR FOR SELECT nom_pere,prenom_pere,portable_pere,nom_mere,prenom_mere,portable_mere FROM schooladmin.eleves;
DECLARE CONTINUE HANDLER FOR NOT FOUND 
SET fincurs := 1;
 OPEN curs;
 
  FETCH curs INTO v_nompere,v_prenompere,v_portablepere,v_nommere,v_prenommere,v_portablemere;
 WHILE (NOT fincurs) DO 
IF (v_portablepere = '' OR v_portablepere IS NULL) THEN
SET v_portablepere := '675820467';
END IF;
IF (v_portablemere = '' OR v_portablemere IS NULL) THEN
SET v_portablemere := '675820467';
END IF;
  SET v_year := LEFT(v_date,4);
SET v_month := SUBSTR(v_date,6,2);
SET v_day := RIGHT(v_date,2);
 UPDATE schooladmin.ozekimessageout SET msg := CONCAT('Mr.',v_nompere,' ',v_prenompere,' You informed that the information entitled : ',v_titre,' have been publish on the server the ',v_day,'/',v_month,'/',v_year) WHERE receiver = v_portablepere;
  UPDATE schooladmin.ozekimessageout SET msg := CONCAT('Mme.',v_nommere,' ',v_prenommere,' You informed that the information entitled : ',v_titre,' have been publish on the server the ',v_day,'/',v_month,'/',v_year) WHERE receiver = v_portablemere;
 FETCH curs INTO v_nompere,v_prenompere,v_portablepere,v_nommere,v_prenommere,v_portablemere;
END WHILE;
CLOSE curs;
END;
$

/*-------------------------------------------------------------------------------------------------------------------------------
                                     M A N A G E M E N T      O F     D E L E T I N G
----------------------------------------------------------------------------------------------------------------------------------  */
/*--------------------------  DELETE EVERY PROFS ABOUT NEWS -----------------------------*/

DELIMITER $
DROP PROCEDURE IF EXISTS deleteNews_teachers;
CREATE PROCEDURE deleteNews_teachers()
BEGIN
 DECLARE fincurs BOOLEAN DEFAULT 0;
  DECLARE v_id INT(50);
 DECLARE v_nom VARCHAR(50);
 DECLARE v_prenom VARCHAR(50);
 DECLARE v_portable VARCHAR(50);
DECLARE curs CURSOR FOR SELECT id,nom,prenom,portable FROM schooladmin.profs WHERE type = 'P';
DECLARE CONTINUE HANDLER FOR NOT FOUND 
SET fincurs := 1;
 OPEN curs; 
 FETCH curs INTO v_id,v_nom,v_prenom,v_portable;
 WHILE (NOT fincurs) DO 
IF (v_portable = '' OR v_portable IS NULL) THEN
SET v_portable := '675820467';
END IF;
UPDATE schooladmin.ozekimessageout SET msg := 'Already deleted',status := 'sent'  WHERE receiver = v_portable;
 FETCH curs INTO v_id,v_nom,v_prenom,v_portable;
END WHILE;
CLOSE curs;
END;
$

/*--------------------------  DELETE NEWS  AND REPLY TO ADMINS -----------------------------*/

DELIMITER $
DROP PROCEDURE IF EXISTS deleteNews_admins;
CREATE PROCEDURE deleteNews_admins()
BEGIN
 DECLARE fincurs BOOLEAN DEFAULT 0;
  DECLARE v_id INT(50);
 DECLARE v_nom VARCHAR(50);
 DECLARE v_prenom VARCHAR(50);
 DECLARE v_portable VARCHAR(50);
DECLARE curs CURSOR FOR SELECT id,nom,prenom,portable FROM schooladmin.profs;
DECLARE CONTINUE HANDLER FOR NOT FOUND 
SET fincurs := 1;
 OPEN curs; 
 FETCH curs INTO v_id,v_nom,v_prenom,v_portable;
 WHILE (NOT fincurs) DO 
IF (v_portable = '' OR v_portable IS NULL) THEN
SET v_portable := '675820467';
END IF;
UPDATE schooladmin.ozekimessageout SET msg := 'Already deleted',status := 'sent'  WHERE receiver = v_portable;
 FETCH curs INTO v_id,v_nom,v_prenom,v_portable;
END WHILE;
CLOSE curs;
END;
$

/*--------------------------  DELETE NEWS  AND REPLY TO PARENTS -----------------------------*/

DELIMITER $
DROP PROCEDURE IF EXISTS deleteNews_parents;
CREATE PROCEDURE deleteNews_parents()
BEGIN
  DECLARE fincurs BOOLEAN DEFAULT 0;
 DECLARE v_nompere VARCHAR(50);
 DECLARE v_prenompere VARCHAR(50);
 DECLARE v_portablepere VARCHAR(50);
  DECLARE v_nommere VARCHAR(50);
 DECLARE v_prenommere VARCHAR(50);
 DECLARE v_portablemere VARCHAR(50);
DECLARE curs CURSOR FOR SELECT nom_pere,prenom_pere,portable_pere,nom_mere,prenom_mere,portable_mere FROM schooladmin.eleves;
DECLARE CONTINUE HANDLER FOR NOT FOUND 
SET fincurs := 1;
 OPEN curs;
 
  FETCH curs INTO v_nompere,v_prenompere,v_portablepere,v_nommere,v_prenommere,v_portablemere;
 WHILE (NOT fincurs) DO 
IF (v_portablepere = '' OR v_portablepere IS NULL) THEN
SET v_portablepere := '675820467';
END IF;
IF (v_portablemere = '' OR v_portablemere IS NULL) THEN
SET v_portablemere := '675820467';
END IF;
UPDATE schooladmin.ozekimessageout SET msg := 'Already deleted',status := 'sent' WHERE receiver = v_portablepere;
UPDATE schooladmin.ozekimessageout SET msg := 'Already deleted',status := 'sent' WHERE receiver = v_portablemere;
 FETCH curs INTO v_nompere,v_prenompere,v_portablepere,v_nommere,v_prenommere,v_portablemere;
END WHILE;
CLOSE curs;
END;
$
