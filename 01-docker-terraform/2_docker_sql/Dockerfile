FROM python:3.12.4

RUN apt-get install wget
RUN pip install pandas sqlalchemy psycopg2 pyarrow fastparquet
# RUN pip install pandas

WORKDIR /app
COPY upload-data.py upload-data.py 
# COPY pipeline.py pipeline.py

# ENTRYPOINT [ "python", "ingest_data.py" ]
ENTRYPOINT [ "python", "upload-data.py" ]


# ENTRYPOINT ["bash"]
