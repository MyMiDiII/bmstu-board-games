CREATE TABLE "Players" (
	"ID" int8 NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	"Name" text NOT NULL,
	"League" text NOT NULL,
	"Rating" int8 NOT NULL,
	"Deleted" bool NOT NULL,
	CONSTRAINT "PK_Players" PRIMARY KEY ("ID")
);
