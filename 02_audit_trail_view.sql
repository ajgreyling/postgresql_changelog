create or replace view audit_trail as
(

	select a._firstnames, a._surname, hv.table_name, hv.tstamp,type,data from _at_historical_values hv
	join __he_sync_transaction_log__ hl on hl.tx_id = hv.tx_id
	join edpadmin a on a."_id_" = hl.identity_id

	union

	select a._firstnames, a._surname, hv.table_name, hv.tstamp,type,data from _at_historical_values hv
	join __he_sync_transaction_log__ hl on hl.tx_id = hv.tx_id
	join administrator a on a."_id_" = hl.identity_id

	union

	select a._firstnames, a._surname, hv.table_name, hv.tstamp,type,data from _at_historical_values hv
	join __he_sync_transaction_log__ hl on hl.tx_id = hv.tx_id
	join gmhpluser a on a."_id_" = hl.identity_id

	union

	select a._firstnames, a._surname, hv.table_name, hv.tstamp,type,data from _at_historical_values hv
	join __he_sync_transaction_log__ hl on hl.tx_id = hv.tx_id
	join initiator a on a."_id_" = hl.identity_id

	union

	select a._firstnames, a._surname, hv.table_name, hv.tstamp,type,data from _at_historical_values hv
	join __he_sync_transaction_log__ hl on hl.tx_id = hv.tx_id
	join webuser a on a."_id_" = hl.identity_id
)
