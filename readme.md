[DuckDB SQL](https://duckdb.org/docs/sql/introduction) is used for all queries and models.

## Setup
- Clone the repo to your local filesystem and take note of the path.
- Install uv.
- Create venv with `uv venv --python 3.13` and activate.
- Run `uv pip install -r requirements.txt`.
- In VS Code, navigate to Extensions and install the Jupyter extensions (ones published by Microsoft).
- The Microsoft Data Wrangler extension is not required to run code but is very helpful in exploratory data analysis.

### DuckDB Setup
- Inside the `rewards` dir, setup the DuckDB database and initial data loads by running `python setup_db.py`.
  - This should create two schemas (`raw` and `core`) and three raw tables (`raw.users`, `raw.brands`, `raw.receipts`).
  - Summary stats for each tables should also be printed out.
- If the Python script doesn't work, the following commands can be run manually:
```sql
create or replace schema raw;

create or replace table raw.brands as from read_json('source_files/brands.json');

create or replace table raw.receipts as from read_json('source_files/receipts.json');

create or replace table raw.users as from read_json('source_files/users.json');

create or replace schema core;
```
- Run `.exit` to exit the CLI.

dbt
- Now let's setup dbt.
- Run `cd rewards_dbt`.
- Run `dbt deps`.
- Navigate to the `rewards_dbt` dir and create a new file named `profiles.yml`.
- Add the following to the file only changing the specific location of your repo directory.
  - NOTE: the path location will vary depending on OS.
```yml
rewards_dbt:
  outputs:
    prod:
      type: duckdb
      path: ~/Documents/code/rewards/rewards.db
      threads: 4

  target: prod
```
- Run `dbt run`. This will attempt to build all existing models in the project.
  - If the command isn't successful, investigate the logs and double-check the paths used.
- Next, run `dbt build` to run both models and data tests.
- You will now see that the models built and data tests were run. There are several warnings configured and these will show up due to potential irregularities in the data. These data tests are set to `warn` and not `fail` for ease of simulation. In a production environment, most if not all would be set to `fail` so they could be addressed.

NOTE: If an `IO Error: Could not set lock on file` error appears, close the process/notebook that is currently utilizing the DuckDB database. Only one process can manipulate the file at a time.

NOTE: If an error similar to `There appear to be 4 leaked semaphore objects to clean up at shutdown` is encountered, kill all running processes/restart IDE to ensure the DuckDB file is in a stable state.
