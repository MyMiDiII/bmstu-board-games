CREATE TABLE "Favorites" (
	"BoardGameID" int8 NOT NULL,
	"PlayerID" int8 NOT NULL,
	CONSTRAINT "PK_Favorites"
	PRIMARY KEY ("BoardGameID", "PlayerID")
);

ALTER TABLE public."Favorites"
ADD CONSTRAINT "FK_Favorites_Games_BoardGameID"
FOREIGN KEY ("BoardGameID") REFERENCES "Games"("ID")
ON DELETE CASCADE;

ALTER TABLE public."Favorites"
ADD CONSTRAINT "FK_Favorites_Players_PlayerID"
FOREIGN KEY ("PlayerID") REFERENCES "Players"("ID")
ON DELETE CASCADE;
