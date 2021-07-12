from diagrams import Cluster, Diagram
from diagrams.onprem.database import Mssql
from diagrams.onprem.analytics import Hadoop, Hive, Beam
from diagrams.onprem.workflow import Airflow, Nifi
from diagrams.onprem.etl import Embulk
from diagrams.oci.storage import DataTransfer
from diagrams.azure.analytics import Databricks, DataFactories
from diagrams.azure.database import SQLDatawarehouse
from diagrams.azure.compute import FunctionApps
from diagrams.aws.compute import Lambda
from diagrams.aws.analytics import Glue

node_attr = {
    "fontsize":"20"
}
graph_attr = {
    "fontsize":"28"
}

with Diagram("", show=False, direction="TB", node_attr=node_attr):
    with Cluster("On-Premises", graph_attr=graph_attr):
        with Cluster("Hadoop", graph_attr=graph_attr):
            beam = Beam("\nBeam")
            airflow = Airflow("\nAirflow")
            sqoop = Hadoop("\nSqoop")
            beam - [airflow] - sqoop
            pig = Hadoop("\nPig")
            hive = Hive("\nHive")
            nifi = Nifi("\nNiFi")
            pig - [hive] - nifi
        with Cluster("Classic ETL", graph_attr=graph_attr):
            sql = Mssql("\nSSIS")
            abinitio = DataTransfer("\nAb Initio")
            embulk = Embulk("\nEmbulk")
            informatica = DataTransfer("\nInformatica")
            embulk - [abinitio]
            sql - [informatica]

    with Cluster("Cloud", graph_attr=graph_attr):
        with Cluster("Azure", graph_attr=graph_attr):
            adf = DataFactories("\nData\nFactory")
            azdatabricks = Databricks("\nDatabricks")
            polybase = SQLDatawarehouse("\nPolyBase\nin Synapse")
            fn = FunctionApps("\nAzure\nFunctions")
            adf - [azdatabricks]
            polybase - [fn]
        with Cluster("AWS", graph_attr=graph_attr):
            glue = Glue("\nGlue")
            awsdatabricks = Databricks("\nDatabricks")
            l = Lambda("\nLambda")
            glue - [awsdatabricks]
            l