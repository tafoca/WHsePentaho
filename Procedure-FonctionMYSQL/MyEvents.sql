



/* NB :  Mettre dans le fichier de configuration procipale de MYSQL la variable event_scheduler = ON , redemarrer le serveur et verifier que c'est ok     */

select version();

SHOW GLOBAL VARIABLES LIKE 'event_scheduler';  /*  VERIFIER SI C'EST A OFF/ON   */

SET GLOBAL event_scheduler = 'ON';        /*  POSITIONNEMENT TEMPORAIRE   */

GRANT EVENT ON study.* TO root@localhost;   /*  POSITIONNEMENT TEMPORAIRE   */

CREATE DATABASE IF NOT EXISTS study;

USE study;

SHOW events;

CREATE TABLE IF NOT EXISTS DECLENCHEUR (
  ID_DECLENCHEUR INTEGER UNSIGNED AUTO_INCREMENT,
  INS_DECLENCHEUR TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INFORMATION_DECLENCHEUR VARCHAR(32),
  PRIMARY KEY PK_DECLENCHEUR(ID_DECLENCHEUR)
);

INSERT INTO DECLENCHEUR (INFORMATION_DECLENCHEUR) VALUES ('Exemple 0.1');

 /*  Insérer une ligne dans la table DECLENCHEUR toutes les minutes.   */
 DROP EVENT IF EXISTS EXEMPLE_1_1;
CREATE EVENT EXEMPLE_1_1
    ON SCHEDULE  EVERY 1 MINUTE
    DO INSERT INTO study.DECLENCHEUR (INFORMATION_DECLENCHEUR) VALUES ('Exemple 1.1');

/*   Insérer une ligne dans la table DECLENCHEUR dans deux minutes.  */
 DROP EVENT IF EXISTS EXEMPLE_1_2;
CREATE EVENT EXEMPLE_1_2
    ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 2 MINUTE
    DO INSERT INTO study.DECLENCHEUR (INFORMATION_DECLENCHEUR) VALUES ('Exemple 1.2');
 
 /*    Lancer (une seule fois) une procédure stockée à 03h50 du 1er janvier 2010.   */
 DROP EVENT IF EXISTS EXEMPLE_1_3;
CREATE EVENT EXEMPLE_1_3
    ON SCHEDULE AT '2010-01-01 03:50:00'
    DO CALL INSERTION('Exemple 1.3');

 /*    Insérer une ligne dans la table DECLENCHEUR chaque jour à 04h00 du matin.  */
 DROP EVENT IF EXISTS EXEMPLE_1_4_a; 
CREATE EVENT EXEMPLE_1_4_a
    ON SCHEDULE EVERY 1 DAY STARTS '2006-06-12 04:00:00'
    DO INSERT INTO study.DECLENCHEUR (INFORMATION_DECLENCHEUR) VALUES ('Exemple 1.4.a');
	
 /*    Insérer une ligne dans la table DECLENCHEUR chaque jour à 04h00 du matin à partir de demain matin 4 heures.   */	
  DROP EVENT IF EXISTS EXEMPLE_1_4_b; 
 CREATE EVENT EXEMPLE_1_4_b
    ON SCHEDULE EVERY 1 DAY
    STARTS CURRENT_DATE + INTERVAL 1 DAY + INTERVAL 4 HOUR
    DO INSERT INTO ARTICLE.DECLENCHEUR (INFORMATION_DECLENCHEUR)
    VALUES ('Exemple 1.4.b');
 /*     Pendant une minute, insérer une ligne dans la table DECLENCHEUR toutes les 8 secondes.   */	
   DROP EVENT IF EXISTS EXEMPLE_1_5;
CREATE EVENT EXEMPLE_1_5
    ON SCHEDULE  EVERY 8 SECOND
    ENDS CURRENT_TIMESTAMP + INTERVAL 1 MINUTE
    DO INSERT INTO study.DECLENCHEUR (INFORMATION_DECLENCHEUR) VALUES ('Exemple 1.5');

 /*    DROP AND ALTER 	
DROP EVENT EXEMPLE_1_1;
DROP EVENT IF EXISTS EXEMPLE_1_1;*/
ALTER EVENT EXEMPLE_1_4_b ENABLE; 
ALTER EVENT EXEMPLE_1_4_b DISABLE;

 /*  Connaître l'état de tous les évènements    */
SELECT EVENT_NAME, STATUS
 FROM INFORMATION_SCHEMA.EVENTS
 WHERE EVENT_SCHEMA = 'study';
 

  /*   Connaître l'état de l'évènement Exemple_1_2   */
 SELECT EVENT_NAME, STATUS
  FROM INFORMATION_SCHEMA.EVENTS
 WHERE EVENT_NAME = 'EXEMPLE_1_2'
   AND EVENT_SCHEMA = 'study';
   
   DELIMITER $
DROP PROCEDURE IF EXISTS study.INSERTION;
CREATE PROCEDURE study.INSERTION ( IN EXEMPLE VARCHAR(20))
     BEGIN
       INSERT INTO DECLENCHEUR ( INFORMATION_DECLENCHEUR )
       VALUES ( CONCAT ( 'PROCEDURE : ', EXEMPLE ));
     END;
$