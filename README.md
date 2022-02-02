# ConnectorX: Accelerating Data Loading From Databases to Dataframes

## Environment Setup
* Python version used for benchmark: 3.8.10
* Install [Just](https://github.com/casey/just#installation)
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

## Datasets and Workloads

#### TPC-H

* Use [TPC-H toolkit](https://github.com/gregrahn/tpch-kit) to generate schemas and tables. Example for PostgreSQL:
    * Download TPC-H toolkit and compile: `git clone https://github.com/gregrahn/tpch-kit.git && cd tpch-kit/dbgen && make MACHINE=LINUX DATABASE=POSTGRESQL`
    * Generate tables (scale factor=10): `./dbgen -s 10`
    * Schemas and tables could be found at `dbgen/dss.ddl` and `dbgen/*.tbl`
    * For SQLite, directly use [TPCH-sqlite](https://github.com/lovasoa/TPCH-sqlite) to generate `.db` file
* 22 SPJ queries can be found at `tpch-spj-workload`

#### DDOS

* Public dataset from [Kaggle](https://www.kaggle.com/devendra416/ddos-datasets), [here](https://www.dropbox.com/s/53w7cjcar0m5k44/ddos.tar.gz?dl=0) to download the processed csv file.
* Schemas could be found from `dataset/ddos`

## Benchmarks

Peak memory usage is captured using script `scripts/mem_monitor.sh` after running the following `just` commands.

The following example commands are used for running benchmarks:

#### pandas

* PostgreSQL:
    * tpch: `just run-tpch pandas --conn POSTGRES_URL`
    * ddos: `just run-ddos pandas --conn POSTGRES_URL`

#### modin (# partition=4)

* PostgreSQL:
    * tpch: `just run-tpch modin 4 --conn POSTGRES_URL`
    * ddos: `just run-ddos modin 4 --conn POSTGRES_URL`
* MySQL:
    * tpch:
    * ddos: `just run-ddos modin 4 --conn MYSQL_URL --driver mysql+mysqldb`

#### dask (# partition=4)

* PostgreSQL:
    * tpch: `just run-tpch dask 4 --conn POSTGRES_URL`
    * ddos: `just run-ddos dask 4 --conn POSTGRES_URL --table ddos`

#### turbodbc

* PostgreSQL:
    * tpch: `just run-tpch turbodbc --driver PostgreSQL`
    * ddos: `just run-ddos turbodbc --driver PostgreSQL`

#### connectorx (# partition=4)

* PostgreSQL:
    * tpch: `just run-tpch cx 4 --conn POSTGRES_URL`
    * ddos: `just run-ddos cx 4 --conn POSTGRES_URL`



