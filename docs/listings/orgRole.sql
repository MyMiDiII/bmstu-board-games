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
