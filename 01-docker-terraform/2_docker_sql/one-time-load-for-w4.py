#!/usr/bin/env python
# coding: utf-8

import argparse
from time import time
import pandas as pd
from sqlalchemy import create_engine
import os


def main():
    user = 'sa'
    pw = 'Mek.920422'
    host = 'localhost'
    port = 5432
    db = 'ny_taxi'
    table = 'fhv_taxi'
    # url = 'https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_'
    url = 'https://github.com/DataTalksClub/nyc-tlc-data/releases/download/fhv/fhv_tripdata_'
    file_format = '.csv.gz'
    # taxi_dtypes = {
    #                 'VendorID': pd.Int64Dtype(),
    #                 'passenger_count': pd.Int64Dtype(),
    #                 'trip_distance': float,
    #                 'RatecodeID':pd.Int64Dtype(),
    #                 'store_and_fwd_flag':str,
    #                 'PULocationID':pd.Int64Dtype(),
    #                 'DOLocationID':pd.Int64Dtype(),
    #                 'payment_type': pd.Int64Dtype(),
    #                 'fare_amount': float,
    #                 'extra':float,
    #                 'mta_tax':float,
    #                 'tip_amount':float,
    #                 'tolls_amount':float,
    #                 'ehail_fee':float,
    #                 'improvement_surcharge':float,
    #                 'total_amount':float,
    #                 'trip_type':pd.Int64Dtype(),
    #                 'congestion_surcharge':float
    #             }
    taxi_dtypes = {
                    'dispatching_base_num':str,
                    'PULocationID':pd.Int64Dtype(),
                    'DOLocationID':pd.Int64Dtype(),
                    'SR_Flag': pd.Int64Dtype(),
                    'Affiliated_base_number':str
                }
    engine = create_engine(f'postgresql://{user}:{pw}@{host}:{port}/{db}')
    new_column_names = {
        'PUlocationID': 'PULocationID',
        'DOlocationID': 'DOLocationID',
        # Add more mappings as needed
    }
    # parse_dates = ['lpep_pickup_datetime', 'lpep_dropoff_datetime']
    # parse_dates = ['pickup_datetime', 'dropoff_datetime']
    # file_list = ['2020-03', '2020-04', '2020-05', '2020-06', '2020-07', '2020-08', '2020-09', '2020-10', '2020-11', '2020-12', '2021-01', '2021-02', '2021-03', '2021-04', '2021-05', '2021-06', '2021-07']
    # file_list = ['2019-02', '2019-03', '2019-04', '2019-05', '2019-06', '2019-07', '2019-08', '2019-09', '2019-10', '2019-11', '2019-12', '2020-01', '2020-02', '2020-03', '2020-04', '2020-05', '2020-06', '2020-07', '2020-08', '2020-09', '2020-10', '2020-11', '2020-12', '2021-01', '2021-02', '2021-03', '2021-04', '2021-05', '2021-06', '2021-07']
    # file_list = ['2019-01', '2019-02', '2019-03', '2019-04', '2019-05', '2019-06', '2019-07', '2019-08', '2019-09', '2019-10', '2019-11', '2019-12', '2020-01', '2020-02', '2020-03', '2020-04', '2020-05', '2020-06', '2020-07', '2020-08', '2020-09', '2020-10', '2020-11', '2020-12', '2021-01', '2021-02', '2021-03', '2021-04', '2021-05', '2021-06', '2021-07']
    file_list = ['2019-01']
    t_start = time()
    for file in file_list:
        print(f'reading {file}...')
        r_start = time()
        # df = pd.read_csv(filepath_or_buffer=f'{url}{file}{file_format}',sep=',',compression='gzip',dtype=taxi_dtypes,parse_dates=parse_dates)
        # df = pd.read_csv(filepath_or_buffer=f'{url}{file}{file_format}',sep=',',compression='gzip',dtype=taxi_dtypes)
        df_iter = pd.read_csv(filepath_or_buffer=f'{url}{file}{file_format}',sep=',',compression='gzip',dtype=taxi_dtypes, iterator=True,chunksize=100000)
        # print(df.columns)
        r_end = time()
        print(f'read! time taken {r_end-r_start:10.3f} seconds.\n')
        # for batch in df:
        for df in df_iter:
        # print(df.columns)
            df = df.rename(columns = new_column_names)            
            print(f'inserting {file}...')
            w_start = time()
            df.to_sql(name=table, con=engine, if_exists='append', index=False)
            # df.to_sql(name=table, con=engine, if_exists='append', index=False)
            w_end = time()
            print(f'inserted! time taken {w_end-w_start:10.3f} seconds.\n')
    t_end = time()   
    print(f'Completed! Total time taken was {t_end-t_start:10.3f} seconds for {len(file_list)} files.')
    # print(df.head())
    # df.tpep_pickup_datetime = pd.to_datetime(df.tpep_pickup_datetime)
    # df.tpep_dropoff_datetime = pd.to_datetime(df.tpep_dropoff_datetime)
    # df.head(n=0).to_sql(name=table, con=engine, if_exists='replace')

if __name__ == "__main__":

    main()





