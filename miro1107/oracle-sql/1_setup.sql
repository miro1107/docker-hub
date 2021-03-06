-- login with dba
-- https://raw.githubusercontent.com/saubury/kafka-connect-oracle-cdc/master/scripts/oracle_setup_docker.sql
CONNECT SYS/Oradoc_db1 AS SYSDBA;

prompt Starting Setup

prompt Check if the ORACLE database is in archive log mode
select log_mode from v$database;

prompt Turn on ARCHIVELOG mode
SHUTDOWN IMMEDIATE;
STARTUP MOUNT;
ALTER DATABASE ARCHIVELOG;
ALTER DATABASE OPEN;

prompt Check if the ORACLE database is in archive log mode
select log_mode from v$database;

prompt Enable supplemental logging for all columns
ALTER SESSION SET CONTAINER=cdb$root;
ALTER DATABASE ADD SUPPLEMENTAL LOG DATA (ALL) COLUMNS;

-- to be run in the CDB
-- credit : https://docs.confluent.io/kafka-connect-oracle-cdc/current
CREATE ROLE C##CDC_PRIVS;
GRANT CREATE SESSION,
EXECUTE_CATALOG_ROLE,
SELECT ANY TRANSACTION,
SELECT ANY DICTIONARY TO C##CDC_PRIVS;
GRANT SELECT ON SYSTEM.LOGMNR_COL$ TO C##CDC_PRIVS;
GRANT SELECT ON SYSTEM.LOGMNR_OBJ$ TO C##CDC_PRIVS;
GRANT SELECT ON SYSTEM.LOGMNR_USER$ TO C##CDC_PRIVS;
GRANT SELECT ON SYSTEM.LOGMNR_UID$ TO C##CDC_PRIVS;

-- change C##myuser to C##FNSONLT
CREATE USER C##FNSONLT IDENTIFIED BY FNSONLT CONTAINER=ALL;
GRANT C##CDC_PRIVS TO C##FNSONLT CONTAINER=ALL;
ALTER USER C##FNSONLT QUOTA UNLIMITED ON sysaux;
ALTER USER C##FNSONLT SET CONTAINER_DATA = (CDB$ROOT, ORCLPDB1) CONTAINER=CURRENT;

ALTER SESSION SET CONTAINER=CDB$ROOT;
GRANT CREATE SESSION, ALTER SESSION, SET CONTAINER, LOGMINING, EXECUTE_CATALOG_ROLE TO C##FNSONLT CONTAINER=ALL;
GRANT SELECT ON GV_$DATABASE TO C##FNSONLT CONTAINER=ALL;
GRANT SELECT ON V_$LOGMNR_CONTENTS TO C##FNSONLT CONTAINER=ALL;
GRANT SELECT ON GV_$ARCHIVED_LOG TO C##FNSONLT CONTAINER=ALL;
GRANT CONNECT TO C##FNSONLT CONTAINER=ALL;
GRANT CREATE TABLE TO C##FNSONLT CONTAINER=ALL;
GRANT CREATE SEQUENCE TO C##FNSONLT CONTAINER=ALL;
GRANT CREATE TRIGGER TO C##FNSONLT CONTAINER=ALL;

ALTER SESSION SET CONTAINER=cdb$root;
ALTER DATABASE ADD SUPPLEMENTAL LOG DATA (ALL) COLUMNS;

GRANT FLASHBACK ANY TABLE TO C##FNSONLT;
GRANT FLASHBACK ANY TABLE TO C##FNSONLT container=all;

-- change to test table
prompt Create some objects
-- create table
CREATE TABLE C##FNSONLT.CCMP (
    TXN_DATE CHAR(8) NOT NULL,
    TXN_TIME CHAR(8) NOT NULL,
    KAFKA_KEY CHAR(18),
    INFO_TIMING CHAR(1),
    CONSTRAINT pkKAFKA_KEY
    PRIMARY KEY (KAFKA_KEY)
) tablespace sysaux;

-- create sequence
CREATE SEQUENCE C##FNSONLT.kafka_key_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- insert two row to init data
INSERT INTO C##FNSONLT.CCMP (TXN_DATE, TXN_TIME, KAFKA_KEY, INFO_TIMING) 
    VALUES (TO_CHAR(SYSDATE, 'yyyyMMdd'), TO_CHAR(SYSDATE, 'HH24MISS'), C##FNSONLT.kafka_key_seq.NEXTVAL, 'Y');
INSERT INTO C##FNSONLT.CCMP (TXN_DATE, TXN_TIME, KAFKA_KEY, INFO_TIMING) 
    VALUES (TO_CHAR(SYSDATE, 'yyyyMMdd'), TO_CHAR(SYSDATE, 'HH24MISS'), C##FNSONLT.kafka_key_seq.NEXTVAL, 'N');
COMMIT;

prompt All Done

