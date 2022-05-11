import argparse
from pyspark import SparkContext, HiveContext

parser = argparse.ArgumentParser()
parser.add_argument("--file", help="some useful description.")
parser.add_argument("--database", help="some useful description.")
args = parser.parse_args()
file_path = args.file
database = args.database

sc = SparkContext(appName = "spark_SQL")
sqlContext = HiveContext(sc)

with open(file_path, 'r') as f:
    query = f.read()
    use_statement = "USE "+ database
    sqlContext.sql(use_statement)
    sqlContext.sql(query).show()
