from diagrams import Cluster, Diagram
from diagrams.onprem.database import Mssql, Mysql, MariaDB, Oracle, Postgresql
from diagrams.azure.database import SQLDatawarehouse
from diagrams.azure.analytics import AnalysisServices
from diagrams.aws.database import Redshift

node_attr = {
    "fontsize":"20"
}
graph_attr = {
    "fontsize":"28"
}

with Diagram("", show=False, direction="TB", node_attr=node_attr):
    with Cluster("On-Premises", graph_attr=graph_attr):
        with Cluster("Commercial Platforms", graph_attr=graph_attr):
            closed_source = [Oracle("\n+ Essbase\n& Hyperion"), Mssql("\n+ Analysis\nServices")]


        with Cluster("Open Source Platforms", graph_attr=graph_attr):
            with Cluster(""):
                mysql = Mysql("")
                mysql >> [MariaDB("MariaDB")]
            open_source = [mysql, Postgresql("PostgreSQL")]

    with Cluster("Cloud", graph_attr=graph_attr):
        with Cluster("Azure", graph_attr=graph_attr):
                azure = [SQLDatawarehouse("\nAzure\nSynapse\nAnalytics"), AnalysisServices("\n\nAnalysis\nServices")]
        with Cluster("AWS", graph_attr=graph_attr):
            aws = [Redshift("\nRedshift")]
        