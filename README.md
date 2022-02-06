# ConnectorX Experiments & Benchmarks

## Environment Setup
* Python version used for benchmark: 3.8.10
* Install [Just](https://github.com/casey/just#installation):
* Install Poetry: `pip install poetry`
* Install Python dependencies: `just install-dependencies`
* Setup environment variables: please create a `.env` file under the project directory and follow the instructions in `env_template` file
* Setup ODBC configuration for baseline `turbodbc` [Optional]: please follow this [tutorial](https://turbodbc.readthedocs.io/en/latest/pages/odbc_configuration.html)

## Database Setup

#### PostgreSQL
```
docker pull postgres
docker run --rm --name postgres --shm-size=512MB -e POSTGRES_USER=$username -e POSTGRES_DB=$db -e POSTGRES_PASSWORD=$password -d -p $port:5432 -v /your/volume/path:/var/lib/postgresql/data postgres -c shared_buffers=10GB
```

#### MySQL
```
docker pull mysql
docker run --rm --name mysql --cap-add=sys_nice -e MYSQL_ROOT_PASSWORD=$password -e MYSQL_DATABASE=$db -p $port:3306 -v /your/volume/path:/var/lib/mysql -d mysql:latest
```

#### MSSQL
```
docker pull mcr.microsoft.com/mssql/server
docker run --rm --name mssql -e ACCEPT_EULA=Y -e SA_PASSWORD=$password -p $port:1433 -v /your/volume/path:/var/opt/mssql/data -d mcr.microsoft.com/mssql/server:2019-latest
```

#### Oracle
Using AWS RDS, instance: db.r5.4xlarge

## Datasets and Workloads

#### TPC-H

* Use [TPC-H toolkit](https://github.com/gregrahn/tpch-kit) to generate schemas and tables. Example for PostgreSQL:
    * Download TPC-H toolkit and compile: `git clone https://github.com/gregrahn/tpch-kit.git && cd tpch-kit/dbgen && make MACHINE=LINUX DATABASE=POSTGRESQL`
    * Generate tables (scale factor=10): `./dbgen -s 10`
    * Schemas and tables could be found at `dbgen/dss.ddl` and `dbgen/*.tbl`
    * For SQLite, directly use [TPCH-sqlite](https://github.com/lovasoa/TPCH-sqlite) to generate `.db` file
* 22 SPJ queries can be found at `tpch-spj-workload`
   * `tpch-spj-workload/spj`: path for original queries
   * `tpch-spj-workload/spj_part`: first row specifies partition column, query starts from second row

#### DDOS

* Public dataset from [Kaggle](https://www.kaggle.com/devendra416/ddos-datasets), [here](https://www.dropbox.com/s/53w7cjcar0m5k44/ddos.tar.gz?dl=0) to download the processed csv file.
* Schemas could be found from `dataset/ddos`

## Benchmarks

* Peak memory usage is captured using script `scripts/mem_monitor.sh` after running the following `just` commands.
* The {env_var_conn} should be configured in `.env` file following the `env_template`.
* Parameters specified using `--{param_name}` are optional parameters. For default values please check `benchmarks/*.py`.
* In our benchmark, we set `--driver mysql+mysqldb` and `--driver mssql+pymssql` for pandas, modin and dask on mysql and mssql respectively. For more configuration about engine in sqlalchemy please checkout [here](https://docs.sqlalchemy.org/en/14/core/engines.html).

#### pandas

`just run-{dataset} pandas --conn {env_var_conn} --driver {driver}`

Examples:
* PostgreSQL tpch: `just run-tpch pandas --conn POSTGRES_URL`
* MySQL ddos: `just run-ddos pandas --conn MYSQL_URL --driver mysql+mysqldb`

#### modin

`just run-{dataset} modin {partition_num} --conn {env_var_conn} --driver {driver}`

Examples:

* SQLite tpch 4 partitions: `just run-tpch modin 4 --conn SQLITE_URL`
* MySQL ddos no partition: `just run-ddos modin 1 --conn MYSQL_URL --driver mysql+mysqldb`

#### dask

`just run-{dataset} dask {partition_num} --conn {env_var_conn} --driver {driver} --table {table} --index {index}`

Use `--table` and `--index` since dask is case sensitive

Examples:

* MSSQL ddos no partition: `just run-ddos dask 1 --conn MSSQL_URL --driver mssql+pymssql --index ID`
* PostgreSQL ddos 4 partitions: `just run-ddos dask 4 --conn POSTGRES_URL --table ddos`

#### turbodbc

`just run-{dataset} turbodbc --driver {driver}`

The `--driver` here is the driver name in odbc configuration.

Examples:

* PostgreSQL tpch: `just run-tpch turbodbc --driver PostgreSQL`
* MySQL ddos: `just run-ddos turbodbc --driver MySQL`

#### connectorx

`just run-{dataset} cx {partition_num} --conn {env_var_conn}`

Examples:

* PostgreSQL tpch 4 partitions: `just run-tpch cx 4 --conn POSTGRES_URL`
* SQLite ddos no partition: `just run-ddos cx 1 --conn SQLITE_URL`

## Run SPJ queries

Script for building index could be found `dataset/tpch/index.sql`. Need to set up the query path for `TPCH_QUERIES` to `/project_path/tpch-spj-workload/spj` in `.env` file.

* Run all queries on pandas: `bash scripts/tpch-queries-pd.sh POSTGRES_URL`
* Run 22 queries on connectorx: `bash scripts/tpch-queries-cx.sh POSTGRES_URL {partition_num}`
* Run single query on pandas: `just run-tpch queries-pd {query_id} --conn {env_var_conn}`
* Run single query on connectorx: `just run-tpch queries-cx 1 --conn {env_var_conn} --part {partition_num}`

## Ablation Study

* Please build connectorx locally following this [guide](https://github.com/sfu-db/connector-x/blob/main/CONTRIBUTING.md#environment-setup).
* To disable streaming, change `DB_BUFFER_SIZE` in `connectorx/src/constants.rs` to the total number of rows of the entire query result.
* To disable string optimization, change `PYSTRING_BUFFER_SIZE` in `connectorx-python/src/constants.rs` to 0.

## Server-Side Result Partitioning

The implementation is only a PoC prototype for the server-side partitioning proposal, targeting on simple queries like "SELECT * FROM TABLE" and static environment. It is by no means a complete solution.
* Prototype (Plan Partition): https://github.com/wangxiaoying/postgres/tree/part_plan
* Alternative (Result Partition): https://github.com/wangxiaoying/postgres/tree/glob_plan
* Client code for using server-side partitioning: https://github.com/sfu-db/connector-x/tree/db_cursor
