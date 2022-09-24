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
