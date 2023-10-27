SELECT
r.rolname,
ARRAY(SELECT b.rolname
FROM pg_catalog.pg_auth_members m
JOIN pg_catalog.pg_roles b ON (m.roleid = b.oid)
WHERE m.member = r.oid) as memberof
FROM pg_catalog.pg_roles r
WHERE r.rolname NOT IN ('pg_signal_backend','rds_iam',
'rds_replication','rds_superuser',
'rdsadmin','rdsrepladmin')
ORDER BY 1;

5----------------

ALTER USER pep WITH PASSWORD 'pasword';

6----------------

CREATE USER miriam WITH PASSWORD 'pasword';

7----------------

DROP USER pep;

9----------------

grant connect on all databases to miriam;

10---------------



11---------------

GRANT CONNECT ON DATABASE postgres to miriam;

12---------------

psql -h localhost --u miriam --d postgres

13---------------

CREATE DATABASE miriam;

14--------------- Dar permisos a miriam para crear bases de datos

ALTER ROLE miriam WITH createdb;

15--------------- Verificar usuario actual

select current_user;

17---------------

create user tofol with encrypted password '1234';

alter role tofol with superuser;

18---------------
SELECT username FROM pg_user;

19---------------

alter role miriam with password 'miriam';

20---------------

CREATE ROLE client_rol;

21---------------

ALTER ROLE client_rol CONNECTION LIMIT 10;
ALTER ROLE client_rol LIGIN;

22---------------

ALTER ROL client_rol SUPERUSER CREATEDB CREATEROLE;

23---------------

ALTER ROLE client_rol NOSUPERUSER;

24---------------

CREATE ROLE JOE WITH LOGIN PASSWORD '1234';
create table pract3(prueba varchar(10));
insert into pract3 (prueba) values('1'),('2');

25---------------

select * from pract3;

26---------------

GRANT SELECT ON TABLE pract3 TO joe;

27---------------
28---------------

CREATE USER bob with password '1234' role joe;

29---------------
30---------------
REVOKE SELECT ON TABLE pract3 FROM joe;
