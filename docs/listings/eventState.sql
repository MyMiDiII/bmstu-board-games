create or replace
function get_event_state(eventDate date
					   , startTime time
					   , duration bigint
					   , beginReg  timestamp
					   , endReg timestamp
					   , cancelled bool
					   , deleted bool)
returns integer as
$$
declare
	curTime timestamp = now();
	beginEvent timestamp := eventDate + startTime;
	endEvent timestamp := beginEvent + (duration * interval '1 minute');
begin
	case
		when cancelled then
			return 5;
		when deleted then
			return 6;
		when curTime < beginReg then
			return 0;
		when curTime < endReg then
			return 1;
		when curTime < beginEvent then
			return 2;
		when curTime < endEvent then
			return 3;
		else
			return 4;
	end case;
end;
$$ language plpgsql;


create or replace
function get_events_with_states()
returns table ("ID" bigint, "Title" text, "Date" date, "StartTime" time,
			   "Duration" bigint, "Cost" bigint, "Purchase" bool,
			   "OrganizerID" bigint, "VenueID" bigint, "Deleted" bool,
			   "BeginRegistration" timestamp, "EndRegistration" timestamp,
			   "Cancelled" bool, "State" integer)
as
$$
    begin
		return query
		select e."ID", e."Title", e."Date", e."StartTime", e."Duration",
	   		e."Cost", e."Purchase", e."OrganizerID", e."VenueID",
	   		e."Deleted", e."BeginRegistration", e."EndRegistration",
	   		e."Cancelled", get_event_state(e."Date", e."StartTime", e."Duration",
	   			  						   e."BeginRegistration", e."EndRegistration",
	   								  	   e."Cancelled", e."Deleted")  as "State"
		from "Events" e
		where e."Deleted" != true;
	end;
$$ language plpgsql;

create or replace
function get_organizer_events_with_states("organizerID" bigint)
returns table ("ID" bigint, "Title" text, "Date" date, "StartTime" time,
			   "Duration" bigint, "Cost" bigint, "Purchase" bool,
			   "OrganizerID" bigint, "VenueID" bigint, "Deleted" bool,
			   "BeginRegistration" timestamp, "EndRegistration" timestamp,
			   "Cancelled" bool, "State" integer)
as
$$
    begin
		return query
		select e."ID", e."Title", e."Date", e."StartTime", e."Duration",
	   		e."Cost", e."Purchase", e."OrganizerID", e."VenueID",
	   		e."Deleted", e."BeginRegistration", e."EndRegistration",
	   		e."Cancelled", get_event_state(e."Date", e."StartTime", e."Duration",
	   			  						   e."BeginRegistration", e."EndRegistration",
	   								  	   e."Cancelled", e."Deleted") as "State"
		from "Events" e
		where e."OrganizerID" = "organizerID";
	end;
$$ language plpgsql;

create or replace
function get_event_with_state_by_id("eventID" bigint)
returns table ("ID" bigint, "Title" text, "Date" date, "StartTime" time,
			   "Duration" bigint, "Cost" bigint, "Purchase" bool,
			   "OrganizerID" bigint, "VenueID" bigint, "Deleted" bool,
			   "BeginRegistration" timestamp, "EndRegistration" timestamp,
			   "Cancelled" bool, "State" integer)
as
$$
    begin
		return query
		select e."ID", e."Title", e."Date", e."StartTime", e."Duration",
	   		e."Cost", e."Purchase", e."OrganizerID", e."VenueID",
	   		e."Deleted", e."BeginRegistration", e."EndRegistration",
	   		e."Cancelled", get_event_state(e."Date", e."StartTime", e."Duration",
	   			  						   e."BeginRegistration", e."EndRegistration",
	   								  	   e."Cancelled", e."Deleted") as "State"
		from "Events" e
		where e."ID" = "eventID";
	end;
$$ language plpgsql;

DROP FUNCTION get_organizer_events_with_states(bigint);

DROP FUNCTION get_events_with_states();
