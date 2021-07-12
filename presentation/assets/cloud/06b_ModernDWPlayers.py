from diagrams import Cluster, Diagram
from diagrams.azure.analytics import Databricks
from diagrams.azure.database import DataLake, SQLDatawarehouse
from diagrams.azure.storage import BlobStorage
from diagrams.aws.database import Dynamodb, RDS, Elasticache
from diagrams.aws.analytics import Redshift
from diagrams.aws.storage import S3

node_attr = {
    "fontsize":"20"
}
graph_attr = {
    "fontsize":"28"
}

with Diagram("", show=False, direction="TB", node_attr=node_attr):
    with Cluster("Azure", graph_attr=graph_attr):
        azdatalake = DataLake("\nData Lake\nStorage Gen2")
        databricks = Databricks("\nDatabricks")
        synapse = SQLDatawarehouse("\nSynapse\nAnalytics")
        azdatalake >> databricks
        azdatalake >> synapse
    with Cluster("AWS", graph_attr=graph_attr):
        s3 = S3("\nS3")
        databricks = Databricks("\nDatabricks")
        redshift = Redshift("\nRedshift")
        s3 >> databricks
        s3 >> redshift
        