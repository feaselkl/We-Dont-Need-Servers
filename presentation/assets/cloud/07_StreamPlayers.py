from diagrams import Cluster, Diagram
from diagrams.onprem.analytics import Hadoop, Flink, Spark, Hive
from diagrams.onprem.database import Cassandra
from diagrams.onprem.queue import Activemq, Celery, Kafka, Rabbitmq, Zeromq
from diagrams.azure.analytics import Hdinsightclusters
from diagrams.alibabacloud.analytics import ElaticMapReduce
from diagrams.aws.analytics import EMR

node_attr = {
    "fontsize":"20"
}
graph_attr = {
    "fontsize":"28"
}

with Diagram("", show=False, node_attr=node_attr):
    with Cluster("Brokers", graph_attr=graph_attr):
        kafka = Kafka("\nKafka")
        activemq = Activemq("\nActiveMQ")
        rabbitmq = Rabbitmq("\nRabbitMQ")
        zeromq = Zeromq("\nZeroMQ")
        kafka - activemq
        rabbitmq - zeromq

    with Cluster("Speed Layer", graph_attr=graph_attr):
        kstream = Kafka("\nKafka\nStreams")
        sparks = Spark("\nSpark Streaming")
        flink = Flink("\nFlink")
        #stream_group = [kstream, sparks, flink]
        kstream - [sparks] - flink

    with Cluster("Batch Layer", graph_attr=graph_attr):
        hdfs = Hadoop("\nHDFS")

    with Cluster("Serving Layer", graph_attr=graph_attr):
        hive = Hive("\nHive")
        sparksql = Spark("\nSpark SQL")
        cassandra = Cassandra("\nCassandra")
        hive - [sparksql] - cassandra
        serve_group = [hive, sparksql, cassandra]

    activemq >> kstream
    zeromq >> hdfs
    flink >> sparksql
    hdfs >> hive