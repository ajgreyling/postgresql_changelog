DO $$
BEGIN
    IF NOT EXISTS (
    	SELECT 1 FROM pg_type t join pg_namespace n on n.oid = t.typnamespace
			WHERE t.typname = '_at_type' and n.nspname = current_schema)
		THEN
			create type _at_type as enum ('INSERT', 'UPDATE', 'DELETE');
    END IF;
    --more types here...
END$$;

create table if not exists _at_historical_values(
   id bigserial not null primary key,
    table_name varchar(64) not null,
    tstamp timestamp with time zone not null,
    tx_id bigint not null,
    "type" _at_type not null,
    "data" jsonb not null
);

CREATE OR REPLACE FUNCTION _at_save_historical_values()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
begin
    if (TG_OP = 'DELETE') then
    	execute 'insert into ' || TG_TABLE_SCHEMA || '._at_historical_values(table_name, tstamp, tx_id, "type", "data")
            values(''' || TG_TABLE_NAME || ''', now(), txid_current(), ''' || TG_OP || '''::' || TG_TABLE_SCHEMA || '._at_type,''' || to_jsonb(OLD) || ''')';
    else
        execute 'insert into ' || TG_TABLE_SCHEMA || '._at_historical_values(table_name, tstamp, tx_id, "type", "data")
            values(''' || TG_TABLE_NAME || ''', now(), txid_current(), ''' || TG_OP || '''::' || TG_TABLE_SCHEMA || '._at_type,''' || to_jsonb(NEW) || ''')';
    end if;
    return NEW;
end;
$function$
;
