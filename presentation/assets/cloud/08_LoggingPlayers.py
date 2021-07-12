from diagrams import Cluster, Diagram, Edge
from diagrams.onprem.logging import Fluentd, Loki
from diagrams.elastic.elasticsearch import Logstash, Elasticsearch, Kibana
from diagrams.onprem.search import Solr
from diagrams.onprem.database import Influxdb, Mongodb
from diagrams.onprem.monitoring import Datadog, Grafana,  Prometheus, Thanos, Splunk
from diagrams.azure.analytics import LogAnalyticsWorkspaces
from diagrams.aws.management import Cloudwatch

node_attr = {
    "fontsize":"20"
}
graph_attr = {
    "fontsize":"28"
}

with Diagram("", show=False, node_attr=node_attr):
    with Cluster("Logging", graph_attr=graph_attr):
        logstash = Logstash("\nLogstash")
        fluentd = Fluentd("\nFluentd")
        loki = Loki("\nLoki")
        logstash - [fluentd] - loki
    
    with Cluster("Monitoring", graph_attr=graph_attr):
        prometheus = Prometheus("\nPrometheus")
        thanos = Thanos("\nThanos")
        prometheus - thanos

    with Cluster("Storage", graph_attr=graph_attr):
        with Cluster("Logs", graph_attr = graph_attr):
            elasticsearch = Elasticsearch("\nElasticsearch")
            solr = Solr("\nSolr")
            mongodb = Mongodb("\nMongoDB")
            elasticsearch - solr - mongodb

        with Cluster("Metrics", graph_attr = graph_attr):
            influx = Influxdb("\nInfluxDB")
            prometheus2 = Prometheus("\nPrometheus")
            prometheus2 - influx

        loki >> elasticsearch
        thanos >> prometheus2

    with Cluster("Visualization", graph_attr=graph_attr):
        kibana = Kibana("\nKibana")
        grafana = Grafana("\nGrafana")
        influx >> kibana
        mongodb >> grafana

    with Cluster("Cloud", graph_attr=graph_attr):
        with Cluster("Azure", graph_attr=graph_attr):
            azlog = LogAnalyticsWorkspaces("\nLog Analytics")
        with Cluster("AWS", graph_attr=graph_attr):
            awslog = Cloudwatch("\nCloudwatch")

    grafana >> Edge(color="white") >> azlog