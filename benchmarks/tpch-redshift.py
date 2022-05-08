"""
Usage:
  tpch-redshift.py [--conn=<conn>]

Options:
  --conn=<conn>          The connection url to use [default: REDSHIFT_URL].
  -h --help              Show this screen.
  --version              Show version.
"""
import os
import pandas_redshift as pr
from contexttimer import Timer
from docopt import docopt
import pandas as pd
from sqlalchemy.engine.url import make_url


if __name__ == "__main__":
    args = docopt(__doc__, version="Naval Fate 2.0")
    conn = os.environ[args["--conn"]]
    conn = make_url(conn)

    with Timer() as timer:
        pr.connect_to_redshift(dbname = conn.database,
                        host = conn.host,
                        port = conn.port,
                        user = conn.username,
                        password = conn.password)
        df = pr.redshift_to_pandas('select * from lineitem')
        print("time get pandas without date conversion:", timer.elapsed)

        df[["l_shipdate", "l_commitdate", "l_receiptdate"]] = df[["l_shipdate", "l_commitdate", "l_receiptdate"]].apply(pd.to_datetime)

    print("time in total:", timer.elapsed)

    print(df)
    print(df.dtypes)
