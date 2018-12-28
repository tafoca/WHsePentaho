DELIMITER $
CREATE PROCEDURE hello1()
BEGIN
DECLARE v_telephone CHAR(14) DEFAULT '06-76-85-14-89';
IF SUBSTR('test',1,2)='t' THEN
SELECT "C'est un portable";
ELSE
SELECT "C'est un fixe...";
END IF;
END;
$