create or replace function check_registration_time()
returns trigger as
$$
declare
	beginReg timestamp;
	endReg   timestamp;
begin
	select e."BeginRegistration", e."EndRegistration"
	from "Events" as e
	where e."ID" = new."BoardGameEventID"
	into beginReg, endReg;

	if beginReg <= current_timestamp
	   and current_timestamp < endReg then
		return new;
	else
		raise exception 'Registration is over!';
	end if;	
end
$$ language plpgsql;

create or replace trigger check_registration_time
before insert on public."Registrations"
for each row execute function check_registration_time();