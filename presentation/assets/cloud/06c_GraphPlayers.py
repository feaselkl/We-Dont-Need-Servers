from diagrams import Cluster, Diagram
from diagrams.onprem.database import Neo4J, Mssql
from diagrams.azure.database import CosmosDb
from diagrams.aws.database import Neptune

node_attr = {
    "fontsize":"20"
}
graph_attr = {
    "fontsize":"28"
}

with Diagram("", show=False, direction="TB", node_attr=node_attr):
    with Cluster("On-Premises", graph_attr=graph_attr):
        with Cluster("Not Good", graph_attr=graph_attr):
            sql = [Mssql("\n")]
        with Cluster("Good", graph_attr=graph_attr):
            onprem = [Neo4J("\nNeo4J")]

    with Cluster("Cloud", graph_attr=graph_attr):
        with Cluster("Azure", graph_attr=graph_attr):
                azure = [CosmosDb("\nCosmos DB")]
        with Cluster("AWS", graph_attr=graph_attr):
            aws = [Neptune("\nNeptune")]
        