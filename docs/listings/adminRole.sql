create role "admin" with
	login
	nosuperuser
	nocreatedb
	nocreaterole
	noreplication
	password 'admin'
	connection limit -1;

grant all privileges on all tables in schema public to "admin";

select * from pg_catalog.pg_roles;

SELECT *
FROM information_schema.role_table_grants
where grantee = 'admin';
