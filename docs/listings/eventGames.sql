create or replace
procedure update_event_games("gamesIDs" bigint[], "eventID" bigint)
language plpgsql as
$$
begin
	delete from "EventGameRelations" egr
	where egr."BoardGameEventID" = "eventID"
	      and egr."BoardGameID" <> all("gamesIDs");
	
	insert into "EventGameRelations"("BoardGameEventID" , "BoardGameID")
	select "eventID", unnest("gamesIDs")
	on conflict ("BoardGameEventID", "BoardGameID") do nothing;
end
$$

DROP PROCEDURE update_event_games(bigint[],bigint);

call update_event_games('{1,2}', 1001);