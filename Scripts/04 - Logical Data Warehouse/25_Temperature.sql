USE [MarsFarming]
GO
DROP VIEW IF EXISTS dbo.Temperature;
GO
CREATE VIEW [dbo].[Temperature] AS
SELECT
    Temperature.*,
    Temperature.filepath(1) AS Year,
    Temperature.filepath(2) AS Month
FROM OPENROWSET
(
    BULK 'abfss://synapse@bdadatalake.dfs.core.windows.net/marsfarming_curated/Temperature/*/*/*.parquet',
    FORMAT = 'Parquet'
)
WITH
(
    PlotID INT,
    ReportDateTime DATETIME2(0),
    Temperature DECIMAL(5,2)
) AS [Temperature];
GO
