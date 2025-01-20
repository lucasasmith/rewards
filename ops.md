Create a DuckDB database/schemas/raw tables:

`duckdb rewards.duckdb`

`create schema raw`

`create table raw.brands as from read_json('source_files/brands.json');`

`create table raw.receipts as from read_json('source_files/receipts.json');`

`create table raw.users as from read_json('source_files/users.json');`

`create schema core;`
