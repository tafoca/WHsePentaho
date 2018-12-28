/*--------------------------  FUNCTION FACTORIELLE -----------------------------*/
delimiter $
DROP FUNCTION IF EXISTS factorielle;
CREATE FUNCTION factorielle(n INT)  RETURNS INT
DETERMINISTIC
BEGIN
IF n = 1 THEN
RETURN (1);
ELSE
RETURN (n * factorielle(n - 1));
END IF;
END;
$;
/*--------------------------  FUNCTION QUI RECUPERE LE PORTABLE AVEC ID -----------------------------*/
delimiter $
DROP FUNCTION IF EXISTS schooladmin.getPortableById;
CREATE FUNCTION schooladmin.getPortableById(v_idprof int(10)) RETURNS VARCHAR(35)
DETERMINISTIC
BEGIN
DECLARE v_phone VARCHAR(35);
SELECT DISTINCT P.portable INTO v_phone FROM accueil_news A,profs P WHERE A.id_prof=P.id AND P.id=v_idprof;
IF (v_phone = '' OR v_phone IS NULL) THEN
SET v_phone := '675820467';
END IF;
RETURN v_phone;
END;
$;

/*--------------------------  FUNCTION QUI RECUPERE LE TELEPHONE 1  AVEC ID -----------------------------*/
delimiter $
DROP FUNCTION IF EXISTS schooladmin.getTel1ById;
CREATE FUNCTION schooladmin.getTel1ById(v_idprof int(10)) RETURNS VARCHAR(35)
DETERMINISTIC
BEGIN
DECLARE v_phone VARCHAR(35);
SELECT DISTINCT P.tel INTO v_phone FROM accueil_news A,profs P WHERE A.id_prof=P.id AND P.id=v_idprof;
IF (v_phone = '' OR v_phone IS NULL) THEN
SET v_phone := '675820467';
END IF;
RETURN v_phone;
END;
$;

/*--------------------------  FUNCTION QUI RECUPERE LE TELEPHONE 2  AVEC ID -----------------------------*/
delimiter $
DROP FUNCTION IF EXISTS schooladmin.getTel2ById;
CREATE FUNCTION schooladmin.getTel2ById(v_idprof int(10)) RETURNS VARCHAR(35)
DETERMINISTIC
BEGIN
DECLARE v_phone VARCHAR(35);
SELECT DISTINCT P.tel2 INTO v_phone FROM accueil_news A,profs P WHERE A.id_prof=P.id AND P.id=v_idprof;
IF (v_phone = '' OR v_phone IS NULL) THEN
SET v_phone := '675820467';
END IF;
RETURN v_phone;
END;
$;

/*--------------------------  FUNCTION QUI RECUPERE LE PORTABLE DU PERE  AVEC ID ELEVE  -----------------------------*/
delimiter $
DROP FUNCTION IF EXISTS schooladmin.getPortablePereById;
CREATE FUNCTION schooladmin.getPortablePereById(v_idstudent int(10)) RETURNS VARCHAR(35)
DETERMINISTIC
BEGIN
DECLARE v_portable VARCHAR(35);
SELECT DISTINCT portable_pere INTO v_portable FROM eleves WHERE id = v_idstudent;
IF (v_portable = '' OR v_portable IS NULL) THEN
SET v_portable := '675820467';
END IF;
RETURN v_portable;
END;
$;

/*--------------------------  FUNCTION QUI RECUPERE LE TELEPHONE 1 DU PERE  AVEC ID ELEVE  -----------------------------*/
delimiter $
DROP FUNCTION IF EXISTS schooladmin.getTel1PereById;
CREATE FUNCTION schooladmin.getTel1PereById(v_idstudent int(10)) RETURNS VARCHAR(35)
DETERMINISTIC
BEGIN
DECLARE v_tel1 VARCHAR(35);
SELECT DISTINCT tel_pere INTO v_tel1 FROM eleves WHERE id = v_idstudent;
IF (v_tel1 = '' OR v_tel1 IS NULL) THEN
SET v_tel1 := '675820467';
END IF;
RETURN v_tel1;
END;
$;

/*--------------------------  FUNCTION QUI RECUPERE LE TELEPHONE 2 DU PERE  AVEC ID ELEVE  -----------------------------*/
delimiter $
DROP FUNCTION IF EXISTS schooladmin.getTel2PereById;
CREATE FUNCTION schooladmin.getTel2PereById(v_idstudent int(10)) RETURNS VARCHAR(35)
DETERMINISTIC
BEGIN
DECLARE v_tel2 VARCHAR(35);
SELECT DISTINCT tel2_pere INTO v_tel2 FROM eleves WHERE id = v_idstudent;
IF (v_tel2 = '' OR v_tel2 IS NULL) THEN
SET v_tel2 := '675820467';
END IF;
RETURN v_tel2;
END;
$;



/*--------------------------  FUNCTION QUI RECUPERE LE PORTABLE DU MERE  AVEC ID ELEVE  -----------------------------*/
delimiter $
DROP FUNCTION IF EXISTS schooladmin.getPortableMereById;
CREATE FUNCTION schooladmin.getPortablePereById(v_idstudent int(10)) RETURNS VARCHAR(35)
DETERMINISTIC
BEGIN
DECLARE v_portable VARCHAR(35);
SELECT DISTINCT portable_mere INTO v_portable FROM eleves WHERE id = v_idstudent;
IF (v_portable = '' OR v_portable IS NULL) THEN
SET v_portable := '675820467';
END IF;
RETURN v_portable;
END;
$;

/*--------------------------  FUNCTION QUI RECUPERE LE TELEPHONE 1 DU MERE  AVEC ID ELEVE  -----------------------------*/
delimiter $
DROP FUNCTION IF EXISTS schooladmin.getTel1MereById;
CREATE FUNCTION schooladmin.getTel1MereById(v_idstudent int(10)) RETURNS VARCHAR(35)
DETERMINISTIC
BEGIN
DECLARE v_tel1 VARCHAR(35);
SELECT DISTINCT tel_mere INTO v_tel1 FROM eleves WHERE id = v_idstudent;
IF (v_tel1 = '' OR v_tel1 IS NULL) THEN
SET v_tel1 := '675820467';
END IF;
RETURN v_tel1;
END;
$;

/*--------------------------  FUNCTION QUI RECUPERE LE TELEPHONE 2 DU MERE  AVEC ID ELEVE  -----------------------------*/
delimiter $
DROP FUNCTION IF EXISTS schooladmin.getTel2MereById;
CREATE FUNCTION schooladmin.getTel2MereById(v_idstudent int(10)) RETURNS VARCHAR(35)
DETERMINISTIC
BEGIN
DECLARE v_tel2 VARCHAR(35);
SELECT DISTINCT tel2_mere INTO v_tel2 FROM eleves WHERE id = v_idstudent;
IF (v_tel2 = '' OR v_tel2 IS NULL) THEN
SET v_tel2 := '675820467';
END IF;
RETURN v_tel2;
END;
$;


/*--------------------------  FUNCTION QUI RECUPERE LE NOM DU PROF AVEC ID ELEVE -----------------------------*/
delimiter $
DROP FUNCTION IF EXISTS schooladmin.getNameById;
CREATE FUNCTION schooladmin.getNameById(v_idprof int(10)) RETURNS VARCHAR(35)
DETERMINISTIC
BEGIN
DECLARE v_nom VARCHAR(35);
SELECT DISTINCT P.nom INTO v_nom FROM accueil_news A,profs P WHERE A.id_prof=P.id AND P.id=v_idprof;
RETURN v_nom;
END;
$;

/*--------------------------  FUNCTION QUI RECUPERE LE NOM DU PERE AVEC ID ELEVE -----------------------------*/
delimiter $
DROP FUNCTION IF EXISTS schooladmin.getNamePereById;
CREATE FUNCTION schooladmin.getNamePereById(v_idstudent int(10)) RETURNS VARCHAR(35)
DETERMINISTIC
BEGIN
DECLARE v_nom VARCHAR(35);
SELECT DISTINCT nom_pere INTO v_nom FROM eleves WHERE id = v_idstudent;
RETURN v_nom;
END;
$;

/*--------------------------  FUNCTION QUI RECUPERE LE PRENOM DU PERE AVEC ID ELEVE -----------------------------*/
delimiter $
DROP FUNCTION IF EXISTS schooladmin.getSurnamePereById;
CREATE FUNCTION schooladmin.getSurnamePereById(v_idstudent int(10)) RETURNS VARCHAR(35)
DETERMINISTIC
BEGIN
DECLARE v_prenom VARCHAR(35);
SELECT DISTINCT prenom_pere INTO v_prenom FROM eleves WHERE id = v_idstudent;
RETURN v_prenom;
END;
$;


/*--------------------------  FUNCTION QUI RECUPERE LE NOM DE LA MERE AVEC ID ELEVE -----------------------------*/
delimiter $
DROP FUNCTION IF EXISTS schooladmin.getNameMereById;
CREATE FUNCTION schooladmin.getNameMereById(v_idstudent int(10)) RETURNS VARCHAR(35)
DETERMINISTIC
BEGIN
DECLARE v_nom VARCHAR(35);
SELECT DISTINCT nom_mere INTO v_nom FROM eleves WHERE id = v_idstudent;
RETURN v_nom;
END;
$;

/*--------------------------  FUNCTION QUI RECUPERE LE PRENOM DE LA MERE AVEC ID ELEVE -----------------------------*/
delimiter $
DROP FUNCTION IF EXISTS schooladmin.getSurnamePereById;
CREATE FUNCTION schooladmin.getSurnamePereById(v_idstudent int(10)) RETURNS VARCHAR(35)
DETERMINISTIC
BEGIN
DECLARE v_prenom VARCHAR(35);
SELECT DISTINCT prenom_mere INTO v_prenom FROM eleves WHERE id = v_idstudent;
RETURN v_prenom;
END;
$;


/*--------------------------  FUNCTION QUI RECUPERE LE NOM DE ELEVE AVEC ID  -----------------------------*/
delimiter $
DROP FUNCTION IF EXISTS schooladmin.getNameStudentById;
CREATE FUNCTION schooladmin.getNameStudentById(v_idstudent int(10)) RETURNS VARCHAR(35)
DETERMINISTIC
BEGIN
DECLARE v_nom VARCHAR(35);
SELECT DISTINCT nom INTO v_nom FROM eleves WHERE id = v_idstudent;
RETURN v_nom;
END;
$;

/*--------------------------  FUNCTION QUI RECUPERE LE PRENOM DE ELEVE AVEC ID  -----------------------------*/
delimiter $
DROP FUNCTION IF EXISTS schooladmin.getSurnameStudentById;
CREATE FUNCTION schooladmin.getSurnameStudentById(v_idstudent int(10)) RETURNS VARCHAR(35)
DETERMINISTIC
BEGIN
DECLARE v_prenom VARCHAR(35);
SELECT DISTINCT prenom INTO v_prenom FROM eleves WHERE id = v_idstudent;
RETURN v_prenom;
END;
$;

/*--------------------------  FUNCTION QUI RECUPERE LE MATRICULE DE ELEVE AVEC ID  -----------------------------*/
delimiter $
DROP FUNCTION IF EXISTS schooladmin.getMatriculeStudentById;
CREATE FUNCTION schooladmin.getMatriculeStudentById(v_idstudent int(10)) RETURNS VARCHAR(35)
DETERMINISTIC
BEGIN
DECLARE v_matricule VARCHAR(35);
SELECT DISTINCT matricule INTO v_matricule FROM eleves WHERE id = v_idstudent;
RETURN v_matricule;
END;
$;


