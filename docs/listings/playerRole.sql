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
