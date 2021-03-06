
  CREATE TABLE "HR"."SCHOOLFEES" 
   (	"ID" NUMBER(*,0) NOT NULL ENABLE, 
	"MATRI" VARCHAR2(20 BYTE), 
	"PREINSCRIPTION" VARCHAR2(20 BYTE), 
	"TRANCHE1" VARCHAR2(20 BYTE), 
	"TRANCHE2" VARCHAR2(20 BYTE), 
	"IDSTUDENT" NUMBER(*,0), 
	"ID_OPTION" NUMBER(*,0), 
	"MATRICULE" VARCHAR2(25 BYTE), 
	"CIVILITY" VARCHAR2(3 BYTE), 
	"NAME" VARCHAR2(35 BYTE), 
	"SURNAME" VARCHAR2(35 BYTE), 
	"PHONE" NUMBER(*,0), 
	"EMAIL" VARCHAR2(25 BYTE), 
	"LOGIN" VARCHAR2(25 BYTE), 
	 CONSTRAINT "SCHOOLFEES_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "USERS"  ENABLE
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "USERS" ;
 
