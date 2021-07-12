from diagrams import Cluster, Diagram
from diagrams.onprem.database import Mssql
from diagrams.onprem.network import Apache
from diagrams.onprem.logging import Logstash
from diagrams.onprem.client import Users

from diagrams.aws.compute import ECS, EKS, Lambda
from diagrams.aws.database import Redshift
from diagrams.aws.integration import SQS
from diagrams.aws.storage import S3

with Diagram("", show=False):
    source = Mssql("SQL Server")
    website = Apache("Web Server")
    logstash = Logstash("Network share for Logs")
    users = Users("Excel Users")

    source >> website >> logstash
    source >> users