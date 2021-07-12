from diagrams import Cluster, Diagram
from diagrams.onprem.analytics import Hadoop
from diagrams.azure.analytics import Hdinsightclusters
from diagrams.alibabacloud.analytics import ElaticMapReduce
from diagrams.aws.analytics import EMR

node_attr = {
    "fontsize":"20"
}
graph_attr = {
    "fontsize":"28"
}

with Diagram("", show=False, direction="TB", node_attr=node_attr):
    with Cluster("'Classic' Hadoop", graph_attr=graph_attr):
            mapr = Hadoop("\nMapR")
            cloudera = Hadoop("\nCloudera")

    with Cluster("Cloud PaaS", graph_attr=graph_attr):
        azure = Hdinsightclusters("\n\nAzure\nHDInsight")
        alibaba = ElaticMapReduce("\n\nAlibaba\nE-MapReduce")
        emr = EMR("\n\nAWS\nElastic\nMapReduce")