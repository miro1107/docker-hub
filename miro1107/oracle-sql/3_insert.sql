-- connect by new user
CONNECT C##FNSONLT/FNSONLT;

-- insert table 1 Y 9 N
INSERT INTO CCMP (TXN_DATE, TXN_TIME, KAFKA_KEY, INFO_TIMING) 
    VALUES (TO_CHAR(SYSDATE, 'yyyyMMdd'), TO_CHAR(SYSDATE, 'HH24MISS'), kafka_key_seq.NEXTVAL, 'Y');
INSERT INTO CCMP (TXN_DATE, TXN_TIME, KAFKA_KEY, INFO_TIMING) 
    VALUES (TO_CHAR(SYSDATE, 'yyyyMMdd'), TO_CHAR(SYSDATE, 'HH24MISS'), kafka_key_seq.NEXTVAL, 'N');
INSERT INTO CCMP (TXN_DATE, TXN_TIME, KAFKA_KEY, INFO_TIMING) 
    VALUES (TO_CHAR(SYSDATE, 'yyyyMMdd'), TO_CHAR(SYSDATE, 'HH24MISS'), kafka_key_seq.NEXTVAL, 'N');
INSERT INTO CCMP (TXN_DATE, TXN_TIME, KAFKA_KEY, INFO_TIMING) 
    VALUES (TO_CHAR(SYSDATE, 'yyyyMMdd'), TO_CHAR(SYSDATE, 'HH24MISS'), kafka_key_seq.NEXTVAL, 'N');
INSERT INTO CCMP (TXN_DATE, TXN_TIME, KAFKA_KEY, INFO_TIMING) 
    VALUES (TO_CHAR(SYSDATE, 'yyyyMMdd'), TO_CHAR(SYSDATE, 'HH24MISS'), kafka_key_seq.NEXTVAL, 'N');
INSERT INTO CCMP (TXN_DATE, TXN_TIME, KAFKA_KEY, INFO_TIMING) 
    VALUES (TO_CHAR(SYSDATE, 'yyyyMMdd'), TO_CHAR(SYSDATE, 'HH24MISS'), kafka_key_seq.NEXTVAL, 'N');
INSERT INTO CCMP (TXN_DATE, TXN_TIME, KAFKA_KEY, INFO_TIMING) 
    VALUES (TO_CHAR(SYSDATE, 'yyyyMMdd'), TO_CHAR(SYSDATE, 'HH24MISS'), kafka_key_seq.NEXTVAL, 'N');
INSERT INTO CCMP (TXN_DATE, TXN_TIME, KAFKA_KEY, INFO_TIMING) 
    VALUES (TO_CHAR(SYSDATE, 'yyyyMMdd'), TO_CHAR(SYSDATE, 'HH24MISS'), kafka_key_seq.NEXTVAL, 'N');
INSERT INTO CCMP (TXN_DATE, TXN_TIME, KAFKA_KEY, INFO_TIMING) 
    VALUES (TO_CHAR(SYSDATE, 'yyyyMMdd'), TO_CHAR(SYSDATE, 'HH24MISS'), kafka_key_seq.NEXTVAL, 'N');
INSERT INTO CCMP (TXN_DATE, TXN_TIME, KAFKA_KEY, INFO_TIMING) 
    VALUES (TO_CHAR(SYSDATE, 'yyyyMMdd'), TO_CHAR(SYSDATE, 'HH24MISS'), kafka_key_seq.NEXTVAL, 'N');

-- commit
commit;