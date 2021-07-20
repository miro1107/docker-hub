-- login with dba
CONNECT SYS/Oradoc_db1 AS SYSDBA;

-- add supplemental when use kafka-connect-oracle-cdc
ALTER DATABASE ADD SUPPLEMENTAL LOG DATA (ALL) COLUMNS;
select supplemental_log_data_min, supplemental_log_data_pk, supplemental_log_data_all from v$database;