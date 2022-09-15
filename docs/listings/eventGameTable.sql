CREATE TABLE "EventGameRelations" (
	"BoardGameID" int8 NOT NULL,
	"BoardGameEventID" int8 NOT NULL,
	CONSTRAINT "PK_EventGameRelations"
	PRIMARY KEY ("BoardGameID", "BoardGameEventID"));

ALTER TABLE public."EventGameRelations"
ADD CONSTRAINT "FK_EventGameRelations_Events_BoardGameEventID"
FOREIGN KEY ("BoardGameEventID") REFERENCES "Events"("ID")
ON DELETE CASCADE;

ALTER TABLE public."EventGameRelations"
ADD CONSTRAINT "FK_EventGameRelations_Games_BoardGameID"
FOREIGN KEY ("BoardGameID") REFERENCES "Games"("ID")
ON DELETE CASCADE;
