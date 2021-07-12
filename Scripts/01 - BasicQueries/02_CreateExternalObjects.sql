USE [MarsFarming]
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.symmetric_keys
)
BEGIN
    CREATE MASTER KEY;
END
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.database_scoped_credentials dsc
    WHERE
        dsc.name = N'SasTokenWrite'
)
BEGIN
    CREATE DATABASE SCOPED CREDENTIAL [SasTokenWrite]
        WITH IDENTITY = 'SHARED ACCESS SIGNATURE',
        SECRET = '<SAS TOKEN>';
END
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.external_data_sources ds
    WHERE
        ds.name = N'MarsFarmingCurated'
)
BEGIN
    CREATE EXTERNAL DATA SOURCE [MarsFarmingCurated] WITH
    (
        LOCATION = N'https://bdadatalake.dfs.core.windows.net/synapse/marsfarming_curated',
        CREDENTIAL = [SasTokenWrite]
    );
END
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.external_file_formats ff
    WHERE
        ff.name = N'ParquetFileFormat'
)
BEGIN
    CREATE EXTERNAL FILE FORMAT [ParquetFileFormat] WITH
    (
        FORMAT_TYPE = PARQUET,
        DATA_COMPRESSION = 'org.apache.hadoop.io.compress.SnappyCodec'
    );
END
GO
