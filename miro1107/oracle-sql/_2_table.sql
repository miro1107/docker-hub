-- connect by new user
CONNECT C##FNSONLT/FNSONLT;

-- create table
CREATE TABLE CCMP (
    TXN_DATE CHAR(8) NOT NULL,
    TXN_TIME CHAR(8) NOT NULL,
    KAFKA_KEY CHAR(18),
    INFO_TIMING CHAR(1),
    CONSTRAINT pkKAFKA_KEY
        PRIMARY KEY (KAFKA_KEY)
);

-- create sequence
CREATE SEQUENCE kafka_key_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;