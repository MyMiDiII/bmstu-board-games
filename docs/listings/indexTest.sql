--- создание тестовой копии базы данных
CREATE DATABASE "indexTestDB" WITH TEMPLATE "testDB";

SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity 
WHERE pg_stat_activity.datname = 'testDB' AND pid <> pg_backend_pid();

--- удаление данных
--- !!! ПРОВЕРИТЬ ПОДКЛЮЧЕНИЕ !!!
TRUNCATE TABLE "Events" RESTART identity cascade;

--- копирование данных
\copy "Events"("Title", "Date", "StartTime", "Duration", "Cost", "Purchase", "BeginRegistration", "EndRegistration", "State", "OrganizerID", "VenueID", "Deleted") from 'C:\Users\maslo\source\repos\software-design\src\Data\indexesTest\events10.csv' delimiter ',' csv;

--- создание индекса
CREATE INDEX "IX_Events_OrganizerID" ON public."Events" USING btree ("OrganizerID");

create index "DateIndex" on public."Events" using btree("Date");

--- удаление индекса
drop index "IX_Events_OrganizerID";

drop index "DateIndex";

--- запрос
explain analyse select * from public."Events" e order by e."Date";

explain analyse select * from public."Events" e where "Date" = current_date;











set enable_indexscan = OFF;
set enable_bitmapscan = ON;
set enable_seqscan = ON;

explain analyse select * from public."Events" e where "Date" = current_date;

create or replace function random_between(low int, high int)
returns int as 
$$
begin
	return floor(random() * (high - low + 1) + low);
end
$$ language 'plpgsql' strict;

set enable_seqscan = OFF;
explain analyse select * from public."Events" e where e."OrganizerID" = random_between(1, 1000);














