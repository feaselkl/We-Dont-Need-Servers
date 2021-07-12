from diagrams import Cluster, Diagram
from diagrams.onprem.database import Mssql, Mysql, MariaDB, Oracle, Postgresql
from diagrams.azure.database import SQLDatabases, SQLManagedInstances, SQLServers, DatabaseForMysqlServers, DatabaseForMariadbServers, DatabaseForPostgresqlServers
from diagrams.aws.database import RDS, Aurora, Database

node_attr = {
    "fontsize":"20"
}
graph_attr = {
    "fontsize":"28"
}

with Diagram("", show=False, direction="TB", node_attr=node_attr):
    with Cluster("On-Premises", graph_attr=graph_attr):
        with Cluster("Commercial Platforms", graph_attr=graph_attr):
            closed_source = [Oracle(""), Mssql("")]


        with Cluster("Open Source Platforms", graph_attr=graph_attr):
            with Cluster(""):
                mysql = Mysql("")
                mysql >> [MariaDB("MariaDB")]
            open_source = [mysql, Postgresql("PostgreSQL")]

    with Cluster("Cloud", graph_attr=graph_attr):
        with Cluster("Azure", graph_attr=graph_attr):
            with Cluster("SQL Server", graph_attr=graph_attr):
                azure = [SQLDatabases("\nAzure SQL\nDatabase"), SQLManagedInstances("\n\nSQL\nManaged\nInstances"), SQLServers("\nSQL Server\n(IaaS)")]
            with Cluster("Other", graph_attr=graph_attr):
                azure2 = [DatabaseForMysqlServers("\nMySQL"), DatabaseForMariadbServers("\nMariaDB"), DatabaseForPostgresqlServers("\nPostgreSQL")]
        with Cluster("AWS", graph_attr=graph_attr):
            aws = [RDS("\n\nRelational\nDatabase\nServices"), Aurora("\nAurora"), Database("\nDatabases\n(IaaS)")]
        