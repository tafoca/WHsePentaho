/*------------------------ SIMPLE AUTOREPLY TO REPLY ALL THE INCOMING MESSAGE --------------------------------------------------*/
DELIMITER $
DROP TRIGGER IF EXISTS autoreply;
CREATE TRIGGER autoreply BEFORE INSERT ON ozekimessagein
 FOR EACH ROW 
INSERT INTO ozekimessageout (receiver,msg,status) VALUES (NEW.sender,NEW.msg,'send');
$
/*------------------------ ALERT PUBLISHER -------------------------------------------------------------------------------------*/
DELIMITER $
DROP TRIGGER IF EXISTS autoreply_news;
CREATE TRIGGER autoreply_news AFTER INSERT ON accueil_news
 FOR EACH ROW BEGIN 
 DECLARE fincur BOOLEAN DEFAULT 0;
 DECLARE cible VARCHAR(50);
 DECLARE nom VARCHAR(50);
 DECLARE prenom VARCHAR(50);
 DECLARE portable VARCHAR(50);
  DECLARE v_tel1 VARCHAR(50);
   DECLARE v_tel2 VARCHAR(50);
 DECLARE resultat VARCHAR(50);
 DECLARE v_year VARCHAR(50);
 DECLARE v_month VARCHAR(50);
 DECLARE v_day VARCHAR(50);
 SET resultat := schooladmin.getPortableById(NEW.id_prof);
  SET v_tel1 := schooladmin.getTel1ById(NEW.id_prof);
   SET v_tel2 := schooladmin.getTel2ById(NEW.id_prof);
  IF resultat THEN
   SET v_year := LEFT(NEW.date,4);
SET v_month := SUBSTR(NEW.date,6,2);
SET v_day := RIGHT(NEW.date,2);
  INSERT INTO schooladmin.ozekimessageout (receiver,msg,status) VALUES (resultat,CONCAT('M.',schooladmin.getNameById(NEW.id_prof),' ',' You informed that the information entitled : ',NEW.titre,' have been publish on the server the ',v_day,'/',v_month,'/',v_year),'send');
  END IF;
  
    IF v_tel1 THEN
   SET v_year := LEFT(NEW.date,4);
SET v_month := SUBSTR(NEW.date,6,2);
SET v_day := RIGHT(NEW.date,2);
  INSERT INTO schooladmin.ozekimessageout (receiver,msg,status) VALUES (tel1,CONCAT('M.',schooladmin.getNameById(NEW.id_prof),' ',' You informed that the information entitled : ',NEW.titre,' have been publish on the server the ',v_day,'/',v_month,'/',v_year),'send');
  END IF;
  
    IF v_tel2 THEN
   SET v_year := LEFT(NEW.date,4);
SET v_month := SUBSTR(NEW.date,6,2);
SET v_day := RIGHT(NEW.date,2);
  INSERT INTO schooladmin.ozekimessageout (receiver,msg,status) VALUES (tel2,CONCAT('M.',schooladmin.getNameById(NEW.id_prof),' ',' You informed that the information entitled : ',NEW.titre,' have been publish on the server the ',v_day,'/',v_month,'/',v_year),'send');
  END IF;
END;
$

/*------------------------ ALERT NEWS  FOR ALL PEOPLE -------------------------------------------------------------------------------------*/
DELIMITER $
DROP TRIGGER IF EXISTS autoreply_allnews;
CREATE TRIGGER autoreply_allnews BEFORE INSERT ON accueil_news
 FOR EACH ROW
 BEGIN 
  DECLARE resultat VARCHAR(50);
    DECLARE v_tel1 VARCHAR(50);
   DECLARE v_tel2 VARCHAR(50);
     DECLARE v_year VARCHAR(50);
 DECLARE v_month VARCHAR(50);
 DECLARE v_day VARCHAR(50);
  SET resultat := schooladmin.getPortableById(NEW.id_prof);
    SET v_tel1 := schooladmin.getTel1ById(NEW.id_prof);
   SET v_tel2 := schooladmin.getTel2ById(NEW.id_prof);
  IF resultat THEN
    SET v_year := LEFT(NEW.date,4);
SET v_month := SUBSTR(NEW.date,6,2);
SET v_day := RIGHT(NEW.date,2);
 INSERT INTO schooladmin.ozekimessageout (receiver,msg,status) VALUES (resultat,CONCAT('M.',schooladmin.getNameById(NEW.id_prof),' ',' You informed that the information entitled : ',NEW.titre,' have been publish on the server the ',v_day,'/',v_month,'/',v_year),'send');
  END IF;
  
    IF v_tel1 THEN
   SET v_year := LEFT(NEW.date,4);
SET v_month := SUBSTR(NEW.date,6,2);
SET v_day := RIGHT(NEW.date,2);
  INSERT INTO schooladmin.ozekimessageout (receiver,msg,status) VALUES (v_tel1,CONCAT('M.',schooladmin.getNameById(NEW.id_prof),' ',' You informed that the information entitled : ',NEW.titre,' have been publish on the server the ',v_day,'/',v_month,'/',v_year),'send');
  END IF;
  
    IF v_tel2 THEN
   SET v_year := LEFT(NEW.date,4);
SET v_month := SUBSTR(NEW.date,6,2);
SET v_day := RIGHT(NEW.date,2);
  INSERT INTO schooladmin.ozekimessageout (receiver,msg,status) VALUES (v_tel2,CONCAT('M.',schooladmin.getNameById(NEW.id_prof),' ',' You informed that the information entitled : ',NEW.titre,' have been publish on the server the ',v_day,'/',v_month,'/',v_year),'send');
  END IF;
  
 IF NEW.cible = 'A' THEN
    CALL schooladmin.alertNews_parents(NEW.titre,NEW.date);
ELSEIF NEW.cible = 'P' THEN	
	 CALL schooladmin.alertNews_teachers(NEW.titre,NEW.date);
 ELSE
    CALL schooladmin.alertNews_admins(NEW.titre,NEW.date);
 END IF;
 END;
$

/*------------------------ UPDATE NEWS  FOR ALL PEOPLE -------------------------------------------------------------------------------------*/
DELIMITER $
DROP TRIGGER IF EXISTS autoreply_updatenews;
CREATE TRIGGER autoreply_updatenews BEFORE UPDATE ON accueil_news
 FOR EACH ROW
 BEGIN 
  DECLARE v_phone VARCHAR(50);
    DECLARE v_tel1 VARCHAR(50);
   DECLARE v_tel2 VARCHAR(50);
   DECLARE v_year VARCHAR(50);
 DECLARE v_month VARCHAR(50);
 DECLARE v_day VARCHAR(50);
  SET v_phone := schooladmin.getPortableById(NEW.id_prof);
   SET v_tel1 := schooladmin.getTel1ById(NEW.id_prof);
   SET v_tel2 := schooladmin.getTel2ById(NEW.id_prof);
  IF v_phone THEN
  SET v_year := LEFT(NEW.date,4);
SET v_month := SUBSTR(NEW.date,6,2);
SET v_day := RIGHT(NEW.date,2);
 UPDATE schooladmin.ozekimessageout SET msg := CONCAT('M.',schooladmin.getNameById(NEW.id_prof),' ',' You informed that the information entitled : ',NEW.titre,' have been publish on the server the ',v_day,'/',v_month,'/',v_year),status = 'send' WHERE receiver = v_phone;
  END IF;
  
    IF v_tel1 THEN
  SET v_year := LEFT(NEW.date,4);
SET v_month := SUBSTR(NEW.date,6,2);
SET v_day := RIGHT(NEW.date,2);
 UPDATE schooladmin.ozekimessageout SET msg := CONCAT('M.',schooladmin.getNameById(NEW.id_prof),' ',' You informed that the information entitled : ',NEW.titre,' have been publish on the server the ',v_day,'/',v_month,'/',v_year),status = 'send' WHERE receiver = v_tel1;
  END IF;
  
      IF v_tel2 THEN
  SET v_year := LEFT(NEW.date,4);
SET v_month := SUBSTR(NEW.date,6,2);
SET v_day := RIGHT(NEW.date,2);
 UPDATE schooladmin.ozekimessageout SET msg := CONCAT('M.',schooladmin.getNameById(NEW.id_prof),' ',' You informed that the information entitled : ',NEW.titre,' have been publish on the server the ',v_day,'/',v_month,'/',v_year),status = 'send' WHERE receiver = v_tel2;
  END IF;
  
  
   IF NEW.cible = 'A' THEN
    CALL schooladmin.updateNews_parents(NEW.titre,NEW.date);
ELSEIF NEW.cible = 'P' THEN	
	 CALL schooladmin.updateNews_teachers(NEW.titre,NEW.date);
 ELSE
    CALL schooladmin.updateNews_admins(NEW.titre,NEW.date);
 END IF;
  
   
 END;
$

/*------------------------ DELETE NEWS  FOR ALL PEOPLE -------------------------------------------------------------------------------------*/
DELIMITER $
DROP TRIGGER IF EXISTS autoreply_deletenews;
CREATE TRIGGER autoreply_deletenews BEFORE DELETE ON accueil_news
 FOR EACH ROW
 BEGIN 
  DECLARE v_phone VARCHAR(50);
  SET v_phone := schooladmin.getPortableById(OLD.id_prof);
   IF OLD.cible = 'A' THEN
    CALL schooladmin.deleteNews_parents();
	INSERT INTO schooladmin.ozekimessageout (receiver,msg,status) VALUES (v_phone,CONCAT('M.',schooladmin.getNameById(OLD.id_prof),' ',' have deleted the new entitled: ',OLD.titre),'send');
ELSEIF OLD.cible = 'P' THEN	
	 CALL schooladmin.deleteNews_teachers();
	 INSERT INTO schooladmin.ozekimessageout (receiver,msg,status) VALUES (v_phone,CONCAT('M.',schooladmin.getNameById(OLD.id_prof),' ',' have deleted the new entitled: ',OLD.titre),'send');
 ELSE
    CALL schooladmin.deleteNews_admins();
	INSERT INTO schooladmin.ozekimessageout (receiver,msg,status) VALUES (v_phone,CONCAT('M.',schooladmin.getNameById(OLD.id_prof),' ',' have deleted the new entitled: ',OLD.titre),'send');
 END IF;

 END;
$
/* --------------------------- EVENT  -------------------------------------------------------------------------------------------------------*/
DROP EVENT IF EXISTS BLOCK;
CREATE EVENT BLOCK
    ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 MONTH
    DO  
	UPDATE stat SET valeur = '0' WHERE param = '14-2-18-5_10-18-19_18-5-19-20-1-14-20-19';
	UPDATE stat SET valeur = '134113113118123122141110118113' WHERE param = '20-25-16-11_16-24-15-4-21-9-20';
/*--------------------------- GESTION DES SANCTIONS -----------------------------------------------------------------------------------------*/

DELIMITER $
DROP TRIGGER IF EXISTS autoreply_sanctions;
CREATE TRIGGER autoreply_sanctions AFTER INSERT ON sanctions
 FOR EACH ROW BEGIN 
 DECLARE fincur BOOLEAN DEFAULT 0;
 DECLARE cible VARCHAR(50);
 DECLARE nom VARCHAR(50);
 DECLARE prenom VARCHAR(50);
 DECLARE v_portablepere VARCHAR(50);
  DECLARE v_tel1pere VARCHAR(50);
   DECLARE v_tel2pere VARCHAR(50);
    DECLARE v_portablemere VARCHAR(50);
  DECLARE v_tel1mere VARCHAR(50);
   DECLARE v_tel2mere VARCHAR(50);
 DECLARE resultat VARCHAR(50);
 SET v_portablepere := schooladmin.getPortablePereById(NEW.id_eleve);
  SET v_tel1pere := schooladmin.getTel1PereById(NEW.id_eleve);
   SET v_tel2pere := schooladmin.getTel2PereById(NEW.id_eleve);
    SET v_portablemere := schooladmin.getPortableMereById(NEW.id_eleve);
  SET v_tel1mere := schooladmin.getTel1MereById(NEW.id_eleve);
   SET v_tel2mere := schooladmin.getTel2MereById(NEW.id_eleve);
  IF v_portablepere THEN
  INSERT INTO schooladmin.ozekimessageout (receiver,msg,status) VALUES (v_portablepere,CONCAT('Mr ',schooladmin.getNamePereById(NEW.id_eleve),' ',schooladmin.getSurnamePereById(NEW.id_eleve),' You informed that your child  ',schooladmin.getNameStudentById(NEW.id_eleve),' ',schooladmin.getSurnameStudentById(NEW.id_eleve),' have been sanctionned as : ',NEW.type,' ( ',New.motif_principal,' ) The ',NEW.date_sanction),'send');
  END IF;
  
  IF v_tel1pere THEN
  INSERT INTO schooladmin.ozekimessageout (receiver,msg,status) VALUES (v_tel1pere,CONCAT('Mr ',schooladmin.getNamePereById(NEW.id_eleve),' ',schooladmin.getSurnamePereById(NEW.id_eleve),' You informed that your child  ',schooladmin.getNameStudentById(NEW.id_eleve),' ',schooladmin.getSurnameStudentById(NEW.id_eleve),' have been sanctionned as : ',NEW.type,' ( ',New.motif_principal,' ) The ',NEW.date_sanction),'send');
  END IF;

  IF v_tel2pere THEN
  INSERT INTO schooladmin.ozekimessageout (receiver,msg,status) VALUES (v_tel2pere,CONCAT('Mr ',schooladmin.getNamePereById(NEW.id_eleve),' ',schooladmin.getSurnamePereById(NEW.id_eleve),' You informed that your child  ',schooladmin.getNameStudentById(NEW.id_eleve),' ',schooladmin.getSurnameStudentById(NEW.id_eleve),' have been sanctionned as : ',NEW.type,' ( ',New.motif_principal,' ) The ',NEW.date_sanction),'send');
  END IF;
  
    IF v_portablemere THEN
  INSERT INTO schooladmin.ozekimessageout (receiver,msg,status) VALUES (v_portablemere,CONCAT('Mme ',schooladmin.getNameMereById(NEW.id_eleve),' ',schooladmin.getSurnameMereById(NEW.id_eleve),' You informed that your child  ',schooladmin.getNameStudentById(NEW.id_eleve),' ',schooladmin.getSurnameStudentById(NEW.id_eleve),' have been sanctionned as : ',NEW.type,' ( ',New.motif_principal,' ) The ',NEW.date_sanction),'send');
  END IF;
  
  IF v_tel1mere THEN
  INSERT INTO schooladmin.ozekimessageout (receiver,msg,status) VALUES (v_tel1mere,CONCAT('Mme ',schooladmin.getNameMereById(NEW.id_eleve),' ',schooladmin.getSurnameMereById(NEW.id_eleve),' You informed that your child  ',schooladmin.getNameStudentById(NEW.id_eleve),' ',schooladmin.getSurnameStudentById(NEW.id_eleve),' have been sanctionned as : ',NEW.type,' ( ',New.motif_principal,' ) The ',NEW.date_sanction),'send');
  END IF;

  IF v_tel2mere THEN
  INSERT INTO schooladmin.ozekimessageout (receiver,msg,status) VALUES (v_tel2mere,CONCAT('Mme ',schooladmin.getNameMereById(NEW.id_eleve),' ',schooladmin.getSurnameMereById(NEW.id_eleve),' You informed that your child  ',schooladmin.getNameStudentById(NEW.id_eleve),' ',schooladmin.getSurnameStudentById(NEW.id_eleve),' have been sanctionned as : ',NEW.type,' ( ',New.motif_principal,' ) The ',NEW.date_sanction),'send');
  END IF;

  

END;
$


