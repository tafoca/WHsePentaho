DELIMITER $
DROP FUNCTION smscount;
CREATE FUNCTION smscount(a VARCHAR(10),b VARCHAR(10)) RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
DECLARE resultat VARCHAR(10);
SET resultat := CONCAT(a,b);
RETURN resultat;
END;
$

delimiter ;
SET @vs_compa = 'TALLA';
SET @vs_nompil = 'FOHOUE';
CALL ozeki.smscount(@vs_compa, @vs_nompil);
smscount('TALLA', 'FOHOUE');