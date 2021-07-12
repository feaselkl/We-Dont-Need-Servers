<style>
.reveal section img { background:none; border:none; box-shadow:none; }
</style>

## The Curated Data Platform
### Last Revision:  November 2020

<a href="http://www.catallaxyservices.com">Kevin Feasel</a> (<a href="https://twitter.com/feaselkl">@feaselkl</a>)<br />
<a href="http://csmore.info/on/cdp">http://CSmore.info/on/cdp</a>

---

@title[Who Am I?]

@div[left-60]
<table>
	<tr>
		<td><a href="https://csmore.info"><img src="https://www.catallaxyservices.com/media/Logo.png" height="133" width="119" /></a></td>
		<td><a href="https://csmore.info">Catallaxy Services</a></td>
	</tr>
	<tr>
		<td><a href="https://curatedsql.com"><img src="https://www.catallaxyservices.com/media/CuratedSQLLogo.png" height="133" width="119" /></a></td>
		<td><a href="https://curatedsql.com">Curated SQL</a></td>
	</tr>
	<tr>
		<td><a href="https://www.apress.com/us/book/9781484254608"><img src="https://www.catallaxyservices.com/media/PolyBaseRevealed.png" height="153" width="107" /></a></td>
		<td><a href="https://www.apress.com/us/book/9781484254608">PolyBase Revealed</a></td>
	</tr>
</table>
@divend

@div[right-40]
	<br /><br />
	<a href="https://www.twitter.com/feaselkl"><img src="https://www.catallaxyservices.com/media/HeadShot.jpg" height="358" width="315" /></a>
	<br />
	<a href="https://www.twitter.com/feaselkl">@feaselkl</a>
</div>
@divend

---?image=presentation/assets/background/questions.jpg&size=cover&opacity=20

### Which data platform is right for me?

The website <a href="https://db-engines.com/en/ranking">DB-Engines</a> keeps track of over 350 different data platform technologies, ranging from relational databases to data warehouses, document databases, key-value stores, search engines, time series, graph databases, and more.

---?image=presentation/assets/background/motivation.jpg&size=cover&opacity=20

### Motivation

My goals in this talk:

* Walk you through several scenarios.
* Discuss when different data storage types make sense.
* Cover relevant cloud options in AWS and Azure.
* Describe technologies for integrating everything together.

---?image=presentation/assets/background/caution.jpg&size=cover&opacity=20

### A Brief Warning

This talk covers data platform technologies as a broad swath and does not spend much time covering the merits of individual products with respect to one another.

Often times, "the platform you have" is a perfectly reasonable answer for "Which platform should I choose?"  Understanding how (and when!) to use these platforms is my goal for today.

---

@title[An Overview]

## Agenda
1. **An Overview**
2. Tracking Finances
3. Product Catalog
4. Busy Website
5. Data Analytics
6. IoT, Real-Time, and Mobile
7. Logging and Metrics
8. Tying it All Together

---?image=presentation/assets/background/scale.jpg&size=cover&opacity=20

### Our Scenario

We work for Catallaxy Widgets, a major retailer of fine widgets and widget accessories.  Our holdings include hundreds of stores around the world, as well as a major website.

Our IT team is looking to modernize several key systems in the organization and asked for our guidance.

---

### The Current System

<img src="presentation/assets/image/Current%20Architecture.png" /><br />

---?image=presentation/assets/background/ugh.jpg&size=cover&opacity=20

### Pain Points

Our current system has worked, but we're experiencing some pain points:

* Finances in Excel spreadsheets is clunky.
* Customers experience slowness searching through our vast product catalog.
* Customers experience slowness navigating through our website and making orders.
* No support for the data science team.
* Log review is painful for IT.

---?image=presentation/assets/background/telephones.jpg&size=cover&opacity=20

### The Upshot

For each of these problem domains, we will look at data platform technologies well-suited for the domain.

Not all of these technologies are necessary and we can certainly make substitutions, but these are solid choices for the job.
---

@title[Tracking Finances]

## Agenda
1. An Overview
2. **Tracking Finances**
3. Product Catalog
4. Busy Website
5. Data Analytics
6. IoT, Real-Time, and Mobile
7. Logging and Metrics
8. Tying it All Together

---?image=presentation/assets/background/binders.jpg&size=cover&opacity=20

### Key Requirements

* Data MUST be correct.  Eventual consistency and even a few missed records won't work for us.
* Systems should be easy for non-IT staff to access, ideally within Excel.
* It's okay for some reports to update nightly rather than real-time.  We also need a real-time app AP and AR can use for their day-to-day work.
* Performance is less important than correctness, but still a factor.

---?image=presentation/assets/background/circuitboards.jpg&size=cover&opacity=20

### Key Technologies

* Relational database (OLTP -- On-Line Transactional Processing) for storing financial data.
* Relational database (OLAP -- On-Line Analytical Processing) for connectivity to Excel and reviewing results.

---

### Why OLTP?

* Non-distributed, relational database because the data must be correct for everybody, and ACID compliance helps us considerably.
* Performance will generally be good, though analysts far from the data center may need to deal with slower queries.

---

### Key Players:  OLTP

@cloud[width=1000](presentation/assets/cloud/02_OLTPPlayers.py)

---

### Why OLAP?

* Specifically, the Kimball model for warehousing.
* The data must be correct but may be delayed.  We can use an ETL process to populate the warehouse.
* Data marts may be distributed across the globe to meet the performance needs of analysts, along with a central data warehouse to store the full set of data.
* Excel tools like Power Query are designed to work with Kimball-style warehouses.

---

### Key Players:  OLAP

@cloud[width=1000](presentation/assets/cloud/03_OLAPPlayers.py)

---

@snap[west span-70]
Relational databases can serve as either OLTP or OLAP--these are database designs rather than distinct technologies.

There are also technologies dedicated to extending beyond relational OLAP, such as SQL Server Analysis Services and Oracle Essbase.
@snapend

@snap[east span-30]
@cloud[width=700, skewx=-30, skewy=15](presentation/assets/cloud/02b_OnPremPlayers.py)
@snapend

---

### Reference Architecture

<img src="presentation/assets/image/Datawarehouse_reference_architecture.jpg" height="400" /><br />

<a href="https://commons.wikimedia.org/wiki/File:Datawarehouse_reference_architecture.jpg">Data Warehouse reference architecture, Wikimedia</a>

---

@title[Product Catalog]

## Agenda
1. An Overview
2. Tracking Finances
3. **Product Catalog**
4. Busy Website
5. Data Analytics
6. IoT, Real-Time, and Mobile
7. Logging and Metrics
8. Tying it All Together

---?image=presentation/assets/background/binders.jpg&size=cover&opacity=20

### Key Requirements

* Performance is critical.  As a global e-commerce company, we need fast response times across the globe.
* Consistency is not critical.  Product data can be out of date or show different results between regions for a minute or two.
* We still want a single source of truth for product data, including quantity on hand, price, etc.

---?image=presentation/assets/background/circuitboards.jpg&size=cover&opacity=20

### Key Technologies

* Document database for "republishing" OLTP data and maximizing performance.
* (Optional) Relational database (OLTP) to act as the single source of truth.

---

### What is a Document DB?

* Key-value store
* The value is a complex document, often JSON (or JSON-like)
* The value may be nested:  `Product` has `Images`, `PriceChanges`, and `StoreAvailability` as well as attributes like `Price`, `Title`, and `Brand`
* Data retrieval is typically one record at a time, but allows for scans of data

---

### Key Players:  Document DBs

@cloud[width=700](presentation/assets/cloud/04_DocumentPlayers.py)

---?image=presentation/assets/background/monkey-thinking.jpg&size=cover&opacity=20

### Is OLTP Necessary Here?

Short answer:  no.

Long answer:  an OLTP database may be a good choice for a busy product catalog, as it gives you a correct source system and it allows you to "true up" the document database(s).

---

### Reference Architecture

<img src="presentation/assets/image/product-catalog.png" height="350" /><br />

<a href="https://docs.microsoft.com/en-us/azure/cosmos-db/use-cases#retail-and-marketing">Cosmos DB Use Case:  Retail and marketing</a>

---

@title[Busy Website]

## Agenda
1. An Overview
2. Tracking Finances
3. Product Catalog
4. **Busy Website**
5. Data Analytics
6. IoT, Real-Time, and Mobile
7. Logging and Metrics
8. Tying it All Together

---?image=presentation/assets/background/binders.jpg&size=cover&opacity=20

### Key Requirements

* Performance is critical.  As a global e-commerce company, we need fast response times across the globe.
* Many of the site assets are static, but there are several dynamic sections:  shopping carts, order and invoice history, etc.
* Consistency is critical for some things (e.g., orders) but less so for others (e.g., product description, order history).

---?image=presentation/assets/background/circuitboards.jpg&size=cover&opacity=20

### Key Technologies

* In-memory key-value caching for fast lookups.
* Simple storage for static content.
* Relational database (OLTP) to act as the single source of truth.
* (Optional) Document database for "republishing" OLTP data and maximizing performance.

---

### Cache versus Document DB

| | Cache     | Document DB |
| - | ------    | ----------  |
| Structure | Key-value | Key-value   |
| Lookup | Singleton | One to many |
| Resident | In Memory | On Disk |
| Structure | Often simple | Simple to complex |
| Size | Small | Small to medium |
| Best Use | Dictionary | Serialized Object |

---

### Key Players:  Websites

@cloud[height=500](presentation/assets/cloud/05_WebPlayers.py)

---?image=presentation/assets/background/shopping_carts.jpg&size=cover&opacity=20

### A Note on Shopping Carts

I'd recommend using an OLTP system for the shopping cart unless your company is enormous like Amazon.

If you do get to that point, a key-value store or document database can work well for the shopping cart, but be sure to have post-order mechanisms to ensure that products are available, prices were correct, the method of billing was successful, etc.  Use message brokers to split apart these systems.

---

### Reference Architecture

<img src="presentation/assets/image/scalable-web-app.png" height="350" /><br />

<a href="https://docs.microsoft.com/en-us/azure/architecture/reference-architectures/app-service-web-app/scalable-web-app">Scalable web application</a>

---

@title[Data Analytics]

## Agenda
1. An Overview
2. Tracking Finances
3. Product Catalog
4. Busy Website
5. **Data Analytics**
6. IoT, Real-Time, and Mobile
7. Logging and Metrics
8. Tying it All Together

---?image=presentation/assets/background/binders.jpg&size=cover&opacity=20

### Key Requirements

* Need to collect more data than is available in relational databases or even data warehouses.
* Need to collect "multi-structured" data like text files, as well as "unstructured" data like audio and video clips.
* Need to store a comprehensive history of data changes over time.

---?image=presentation/assets/background/circuitboards.jpg&size=cover&opacity=20

### Key Technologies

* Apache Hadoop
* Apache Spark
* Data Lake storage
* Distributed quasi-relational database (OLAP)
* Graph databases

---?image=presentation/assets/background/elephant1.jpg&size=cover&opacity=20

### Apache Hadoop

Hadoop is a massive, distributed, batch processing system.  Hadoop itself has three key components:  the Hadoop Distributed File System (HDFS), the MapReduce library, and the resource allocation engine Yet Another Resource Negotiator (YARN).

The MapReduce library has fallen out of vogue along with pure Hadoop clusters, but the Hadoop ecosystem is thriving, especially Apache Spark.

---

### Hadoop Ecosystem

<img src="presentation/assets/image/hadoop-ecosystem.png" height="350" /><br />

<a href="https://subscription.packtpub.com/book/application_development/9781788995092/1/ch01lvl1sec14/overview-of-the-hadoop-ecosystem">Hadoop Ecosystem</a>

---

### Key Players:  Hadoop

@cloud[height=500](presentation/assets/cloud/06_HadoopPlayers.py)

---?image=presentation/assets/background/sparkler.jpg&size=cover&opacity=20

### Apache Spark

Spark provides in-memory cluster computing, avoiding MapReduce's reliance on heavy I/O use.

Spark ties into several major cloud technologies, including Databricks, HDInsight / ElasticMapReduce, and Azure Data Factory / AWS Glue.

---?image=presentation/assets/background/lake.jpg&size=cover&opacity=20

### The Data Lake

HDFS opened up the possibility of massive, distributed storage of data, including multi-structured and unstructured data, which typically would not fit well in a classic data warehouse.

The data lake provides a central location for historical storage of a broad array of company data for the purpose of data science and machine learning activities.

---?image=presentation/assets/background/warehouse-water.jpg&size=cover&opacity=20

### The Data Lakehouse

Databricks has coined the term Lakehouse to represent the combination of data warehouse and data lake in one managed area.

---

### The Data Lakehouse

<img src="presentation/assets/image/data-lakehouse.png" height="350" /><br />

<a href="https://databricks.com/glossary/data-lakehouse">Data Lakehouse</a>

---

### Key Players:  Modern DW

@cloud[height=500](presentation/assets/cloud/06b_ModernDWPlayers.py)

---?image=presentation/assets/background/complexity.jpg&size=cover&opacity=20

### Graph Databases

Graph databases have a niche in the analytics space.  Graph databases combine **nodes** (which represent entities) and **edges** (which represent connections between entities).

---?image=presentation/assets/background/jump.jpg&size=cover&opacity=20

### Graph Databases' Wheelhouse

1. Path calculation (especially with weights, such as distance between cities)
2. Fraud detection via link analysis:  observe the links between known fraudulent entities and non-marked entities.
3. Modeling fluid relationships between entities.
4. Laying out network maps and other complex topologies.

---?image=presentation/assets/background/surfer-crash.jpg&size=cover&opacity=20

### The Problem with Graph Databases

The biggest problem with graph databases is that you can do the same things with relational databases, but with only one concept (the relation) versus two (nodes and edges).

The second-biggest problem with graph databases is that there is no common graph language like SQL or common implementation specs between products.

---

### Key Players:  Graph Databases

@cloud[height=500](presentation/assets/cloud/06c_GraphPlayers.py)

---

### Reference Architecture

<img src="presentation/assets/image/aws-modern-data-warehouse.png" height="450" /><br />

<a href="https://aws.amazon.com/blogs/big-data/how-i-built-a-data-warehouse-using-amazon-redshift-and-aws-services-in-record-time/">Data warehouse with Redshift</a>

---

### Reference Architecture

<img src="presentation/assets/image/modern-data-warehouse.png" height="350" /><br />

<a href="https://docs.microsoft.com/en-us/azure/architecture/solution-ideas/articles/modern-data-warehouse">Modern Data Warehouse Architecture</a>

---

### Reference Architecture

<img src="presentation/assets/image/hadoop-warehouse.jpg" height="430" /><br />

<a href="https://www.datavirtualizationblog.com/logical-architectures-big-data-analytics/">Logical Architectures for Big Data Analytics</a>

---

@title[IoT, Real-Time, and Mobile]

## Agenda
1. An Overview
2. Tracking Finances
3. Product Catalog
4. Busy Website
5. Data Analytics
6. **IoT, Real-Time, and Mobile**
7. Logging and Metrics
8. Tying it All Together

---?image=presentation/assets/background/binders.jpg&size=cover&opacity=20

### Key Requirements

* Asynchronous message passing:  devices push notifications and let services respond.
* Separate producers of messages from consumers of messages.
* Handle large (potentially very large) numbers of messages.

---?image=presentation/assets/background/circuitboards.jpg&size=cover&opacity=20

### Key Technologies

* Message broker
* Stream processing
* Long-term storage over HDFS
* Document or Relational DB for fast data access

---

### Message Brokers

Message brokers receive messages from **producers** and send messages to **consumers**. They provide a logical disconnect between the two.

![](presentation/assets/image/Kafka_Overall.png)

---?image=presentation/assets/background/stream.jpg&size=cover&opacity=20

### Stream Processing

Stream processing handles messages one at a time (e.g., Kafka Streams, Flink) or in microbatches (Spark Streaming).

---

### The Lambda Architecture

<img src="presentation/assets/image/hadoop-lambda.png" height="350" /><br />

<a href="https://www.jamesserra.com/archive/2016/08/what-is-the-lambda-architecture/">What is the Lambda Architecture?</a>

---

@snap[west span-60]
1. Data is dispatched to the batch and speed layers.<br />
2. Batch layer provides permanent storage and pre-computes batch views.<br />
3. Serving layer indexes the batch views for performance.<br />
4. Speed layer handles recent data.<br />
5. Queries merge results from batch and speed layers.
@snapend

@snap[east span-40]
![width=500, skewx=-35, skewy=15](presentation/assets/image/hadoop-lambda.png)
@snapend

---

### Key Players:  Lambda

@cloud[height=500](presentation/assets/cloud/07_StreamPlayers.py)

---

### Lambda Pros and Cons

| Pro | Con |
| --- | --- |
| Balances speed and reliability | Code replicated in multiple services |
| Scales out extremely well | Batch needs full re-processing |
| Can solve two different classes of problems | Many working parts |

---

### Reference Architecture

<img src="presentation/assets/image/connected-vehicle-solution-architecture.png" height="450" /><br />

<a href="https://docs.aws.amazon.com/solutions/latest/connected-vehicle-solution/architecture.html">AWS Connected Vehicle Solution</a>

---

### Reference Architecture

<img src="presentation/assets/image/iot.png" height="400" /><br />

<a href="https://docs.microsoft.com/en-us/azure/architecture/reference-architectures/iot">Azure IoT reference architecture</a>

---

@title[Logging and Metrics]

## Agenda
1. An Overview
2. Tracking Finances
3. Product Catalog
4. Busy Website
5. Data Analytics
6. IoT, Real-Time, and Mobile
7. **Logging and Metrics**
8. Tying it All Together

---?image=presentation/assets/background/binders.jpg&size=cover&opacity=20

### Key Requirements

* Need a central source for logging across multiple services.
* Sometimes logs will follow a specific format, but no guarantee all records have the same shape.
* Queries are often "What happened at this time?" or "What errors do we see?"

---?image=presentation/assets/background/circuitboards.jpg&size=cover&opacity=20

### Key Technologies

* The ELK Stack as a pattern
	- Log storage:  Elasticsearch
	- Log shipping and event handling:  Logstash
	- Log querying and visualization:  Kibana
* Standalone logging services

---?image=presentation/assets/background/skeleton-thinking.jpg&size=cover&opacity=20

### Roll Your Own or Purchase?

There are full-service logging solutions, such as Splunk, Datadog, Loggly, and SumoLogic.  These products perform quite well and tend to be accessible for developers and administrators.  The downside is that they tend to be quite expensive.

On the other side, open source products exist as well and can be quite powerful when used correctly, but the learning curve tends to be much higher.

---

### Key Players:  Logging

@cloud[height=500](presentation/assets/cloud/08_LoggingPlayers.py)

---

### Reference Architecture

<img src="presentation/assets/image/elk-stack.png" /><br />

<a href="https://logz.io/learn/complete-guide-elk-stack/">The Complete Guide to the ELK Stack</a>

---

@title[Tying it All Together]

## Agenda
1. An Overview
2. Tracking Finances
3. Product Catalog
4. Busy Website
5. Data Analytics
6. IoT, Real-Time, and Mobile
7. Logging and Metrics
8. **Tying it All Together**

---?image=presentation/assets/background/you-are-here.jpg&size=cover&opacity=20

### Data on the Move

As soon as you have two data platform systems, you introduce the need to combine data.

There are three major approaches to data movement:  ETL, ELT, and Data Virtualization.

---?image=presentation/assets/background/spiral-staircase.jpg&size=cover&opacity=20

### ETL to ELT

For a long time, the normal pattern for data movement was Extract-Transform-Load (ETL).  With the massive increase in data sizes, we have seen a move toward Extract-Load-Transform (ELT).

---

### ETL to ELT:  the Difference

ETL modifies data during the movement process:  Extract data from a system, Transform it in the mover, and then Load the resulting data into your destination.

By contrast, with ELT, we Extract data from a system, Load it into a staging area on the destination, and Transform the data into its final form using the destination's compute resources.

---

### Key Players:  ETL/ELT

@cloud[height=500](presentation/assets/cloud/09_ETLPlayers.py)

---

### Data Virtualization

In addition to moving data from system to system, we can **virtualize** data, making it appear to move while remaining in its current location.  Virtualization tools are commonly third-party products which sit on top of several data platform technologies and offer a "single pane of glass" view of databases.  Functionality typically includes the ability to join between sources.

The downside to virtualization is that performance typically suffers with larger sets of data.

---

### Key Players:  Data Virtualization

* Actifio
* Denodo
* IBM Cloud Pak
* Informatica PowerCenter
* Oracle Data Service Integrator
* Starburst Presto

---?image=presentation/assets/background/connections.jpg&size=cover&opacity=20

### PolyBase

SQL Server 2019 extends a Microsoft technology called PolyBase, which allows you to virtualize data from a number of different data platform technologies, including Hadoop, Azure Blob Storage, SQL Server, Oracle, MongoDB, Cosmos DB, Spark, DB/2, Excel, and more.

For more, go to <a href="https://csmore.info/on/polybase">https://csmore.info/on/polybase</a>.

---

### PolyBase and ELT

One difference between PolyBase and other data virtualization products is that PolyBase enables ELT into SQL Server.  You can create an external table from a remote data source and use that to land data into SQL Server.

---?image=presentation/assets/background/wrappingup.jpg&size=cover&opacity=20

### Wrapping Up

This has been a look at the data platform space as it stands.  This is a fast-changing field with interesting competitors entering and leaving the market regularly.

To learn more, go here:  <a href="http://csmore.info/on/cdp">http://CSmore.info/on/cdp</a>

And for help, contact me:  <a href="mailto:feasel@catallaxyservices.com">feasel@catallaxyservices.com</a> | <a href="https://www.twitter.com/feaselkl">@feaselkl</a>

Catallaxy Services consulting:  <a href="https://csmore.info/contact">https://CSmore.info/on/contact</a>
