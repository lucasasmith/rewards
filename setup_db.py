from pathlib import Path

import duckdb

# Warning: this will delete the DuckDB file if it exists.
file_path = Path("rewards.db")
if file_path.exists():
    file_path.unlink()
    print(f"File {file_path} has been deleted.")

# Setup a DuckDB persistant file and schemas/tables.
with duckdb.connect("rewards.db") as con:
    con.sql("create or replace schema raw;")
    con.sql("create or replace schema core;")

    for table in ["receipts", "brands", "users"]:
        con.sql(
            f"create or replace table raw.{table} as from read_json('source_files/{table}.json');"
        )
        print(con.sql(f"use raw; summarize raw.{table};"))
