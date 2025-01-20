## Setup
- Install uv.
- Create venv with `uv venv --python 3.13` and activate.
- Run `uv pip install -r requirements.txt`.
- In VS Code, navigate to Extensions and install the Jupyter extensions (ones published by Microsoft).

### DuckDB Setup
- Inside the `rewards` dir, run the following commands:
- `duckdb rewards_db.duckdb` -- This will create the DuckDB db in a local file.
- Next, all the following commands can be run at once:
```sql
create or replace schema raw;

create or replace table raw.brands as from read_json('source_files/brands.json');

create or replace table raw.receipts as from read_json('source_files/receipts.json');

create or replace table raw.users as from read_json('source_files/users.json');

create or replace schema core;
```
- To double check successful load, run `select * from raw.users limit 3;` with the DuckDB CLI.
```
┌────────────────────────────────────┬─────────┬──────────────────────────┬──────────────────────────┬─────────────┬──────────────┬─────────┐
│                _id                 │ active  │       createdDate        │        lastLogin         │    role     │ signUpSource │  state  │
│       struct("$oid" varchar)       │ boolean │  struct("$date" bigint)  │  struct("$date" bigint)  │   varchar   │   varchar    │ varchar │
├────────────────────────────────────┼─────────┼──────────────────────────┼──────────────────────────┼─────────────┼──────────────┼─────────┤
│ {'$oid': 5ff1e194b6a9d73a3a9f1052} │ true    │ {'$date': 1609687444800} │ {'$date': 1609687537858} │ consumer    │ Email        │ WI      │
│ {'$oid': 5ff1e194b6a9d73a3a9f1052} │ true    │ {'$date': 1609687444800} │ {'$date': 1609687537858} │ consumer    │ Email        │ WI      │
│ {'$oid': 5ff1e194b6a9d73a3a9f1052} │ true    │ {'$date': 1609687444800} │ {'$date': 1609687537858} │ consumer    │ Email        │ WI      │
```
- Run `.exit` to exit the CLI.

dbt
- Now let's setup dbt.
- Run `cd rewards_dbt`.
- Run `dbt deps`.
- Navigate to the `rewards_dbt` dir and create a new file named `profiles.yml`.
- Add the following to the file only changing the specific location of your repo dir.
```yml
rewards_dbt:
  outputs:
    prod:
      type: duckdb
      path: ~/Documents/code/rewards/rewards_db.duckdb
      threads: 4

  target: prod
```
- Run `dbt run`. This will attempt to build all existing models in the project.
- Next, run `dbt build` to run both models and data tests.
- You will now see that the models built and data tests were run. There are several warning configured and these will show up due to potential irregularities in the data. These data tests are set to `warn` and not `fail` for ease of simulation. In a production environment, most if not all would be set to `fail` so they could be addressed.
