create table if not exists name_changes_audit
(
	change_id int not null,
	change_date text not null
);

create or replace function name_log_func()
returns trigger as
$example_table$
   begin
      insert into name_changes_audit(change_id, change_date) values (new.id, current_timestamp);
      return new;
   end;
$example_table$ language plpgsql;

create trigger ppl_name_upd
	after update of name on people
	for each row
	--when (old.name is distinct from new.name)
	execute procedure name_log_func();
	