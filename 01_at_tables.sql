drop trigger if exists _at_medicine on medicine;
drop trigger if exists _at_contract on contract;
drop trigger if exists _at_supplier on supplier;
drop trigger if exists _at_contractlineitem on contractlineitem;
drop trigger if exists _at_draftcontract on draftcontract;

create trigger _at_medicine
    after insert or update or delete on medicine
    for each row execute procedure _at_save_historical_values();

create trigger _at_contract
    after insert or update or delete on contract
    for each row execute procedure _at_save_historical_values();

create trigger _at_supplier
    after insert or update or delete on supplier
    for each row execute procedure _at_save_historical_values();

create trigger _at_contractlineitem
    after insert or update or delete on contractlineitem
    for each row execute procedure _at_save_historical_values();

    create trigger _at_draftcontract
        after insert or update or delete on draftcontract
        for each row execute procedure _at_save_historical_values();
