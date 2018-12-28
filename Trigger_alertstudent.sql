
DROP TRIGGER IF EXISTS autoreply_news;
CREATE TRIGGER autoreply_news AFTER INSERT ON student
 FOR EACH ROW 
  INSERT INTO onlinerequest.alertstudent (phone,text,status) VALUES (CONCAT('+2376',RIGHT(NEW.phone,8)),CONCAT(NEW.civility,' ',NEW.name,' ',NEW.surname,'(',NEW.matricule,') You informed that your account have created in the server of University of Dschang.   Login : ',NEW.login,' and Pass : ',NEW.login,' -> ',NOW()),'send');

