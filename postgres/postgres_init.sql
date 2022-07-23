CREATE ROLE synapse_user 
    WITH 
    PASSWORD '{DB_ROLE_PASSWORD}';

CREATE DATABASE synapse 
    WITH 
    TEMPLATE = template0 
    OWNER = synapse_user
    ENCODING = 'UTF8' 
    LC_COLLATE = 'C'
    LC_CTYPE = 'C';


