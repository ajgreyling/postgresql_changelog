create or replace view audit_trail as
(
	select table_name, tstamp,type,data from _at_historical_values hv
)
