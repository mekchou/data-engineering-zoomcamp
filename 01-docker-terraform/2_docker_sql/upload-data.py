#!/usr/bin/env python
# coding: utf-8

import argparse
import pandas as pd
from sqlalchemy import create_engine
import os


def main(params):
    user = params.user
    pw = params.pw
    host = params.host
    port = params.port
    db = params.db
    table = params.table
    url = params.url
    parquet_name = 'output.parquet'

    os.system(f"wget {url} -O {parquet_name}")

    engine = create_engine(f'postgresql://{user}:{pw}@{host}:{port}/{db}')

    df = pd.read_parquet(parquet_name)
    df.tpep_pickup_datetime = pd.to_datetime(df.tpep_pickup_datetime)
    df.tpep_dropoff_datetime = pd.to_datetime(df.tpep_dropoff_datetime)
    df.head(n=0).to_sql(name=table, con=engine, if_exists='replace')
    df.head(100).to_sql(name=table, con=engine, if_exists='append')

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
                        prog='upload-data',
                        description='ingest parquet data to postgres')

    parser.add_argument("--user")
    parser.add_argument("--pw")
    parser.add_argument("--host")
    parser.add_argument("--port")
    parser.add_argument("--db")
    parser.add_argument("--table")
    parser.add_argument("--url")
    args = parser.parse_args()
    
    main(args)





