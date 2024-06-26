import redshift_connector
con = redshift_connector.connect(
    iam=True,
    host="magezoomcamp.381492227382.us-east-2.redshift-serverless.amazonaws.com",
    port=5439,
    database='dev',
    # user=REDSHIFT_USER,
    # password=REDSHIFT_PASSWORD,
    is_serverless=True,
    serverless_work_group='magezoomcamp',
)
# test out the connection

with con.cursor() as cursor:
    cursor.execute("SELECT 1;")
    print(cursor.fetchall())