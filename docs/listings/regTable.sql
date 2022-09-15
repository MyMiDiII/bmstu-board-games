CREATE TABLE "Registrations" (
	"PlayerID" int8 NOT NULL,
	"BoardGameEventID" int8 NOT NULL,
	CONSTRAINT "PK_Registrations"
	PRIMARY KEY ("BoardGameEventID", "PlayerID")
);

ALTER TABLE public."Registrations"
ADD CONSTRAINT "FK_Registrations_Events_BoardGameEventID"
FOREIGN KEY ("BoardGameEventID") REFERENCES "Events"("ID")
ON DELETE CASCADE;

ALTER TABLE public."Registrations"
ADD CONSTRAINT "FK_Registrations_Players_PlayerID"
FOREIGN KEY ("PlayerID") REFERENCES "Players"("ID")ON DELETE CASCADE;
