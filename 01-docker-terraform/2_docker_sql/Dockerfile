FROM python:3.12.4

# RUN apt-get install wget
# RUN pip install pandas sqlalchemy psycopg2
RUN pip install pandas

WORKDIR /app
# COPY ingest_data.py ingest_data.py 
COPY pipeline.py pipeline.py

# ENTRYPOINT [ "python", "ingest_data.py" ]
ENTRYPOINT [ "python", "pipeline.py" ]


# ENTRYPOINT ["bash"]
