-- Replace <table_0n> with the actual table names. 
drop trigger if exists _at_medicine on <table_01>;

create trigger _at_<table_01>
    after insert or update or delete on <table_01>
    for each row execute procedure _at_save_historical_values();

drop trigger if exists _at_contract on <table_02>;

create trigger _at_<table_02>
    after insert or update or delete on <table_02>
    for each row execute procedure _at_save_historical_values();
