create role guest with
	login
	nosuperuser
	nocreatedb
	nocreaterole
	noreplication
	password 'guest'
	connection limit -1;

grant select on public."EventGameRelations"
			  , public."Events"
			  , public."Games"
			  , public."Organizers"
			  , public."Venues"
to guest;

create role player with
	login
	nosuperuser
	nocreatedb
	nocreaterole
	noreplication
	password 'player'
	connection limit -1;

grant select on public."EventGameRelations"
			  , public."Events"
			  , public."Games"
			  , public."Organizers"
			  , public."Venues"
			  , public."Favorites"
			  , public."Players"
			  , public."Registrations"
to player;

grant insert on public."Favorites"
		      , public."Registrations"
to player;

grant update ("Name") on public."Players"
to player;

grant delete on public."Favorites"
			  , public."Registrations"
to player;
	
create role organizer with
	login
	nosuperuser
	nocreatedb
	nocreaterole
	noreplication
	password 'organizer'
	connection limit -1;

grant select on public."EventGameRelations"
			  , public."Events"
			  , public."Games"
			  , public."Organizers"
			  , public."Venues"
			  , public."Players"
			  , public."Registrations"
to organizer;

grant insert on public."Events"
to organizer;

grant update on public."Events"
              , public."Organizers" 
to organizer;
	
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