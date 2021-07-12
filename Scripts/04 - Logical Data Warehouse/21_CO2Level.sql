USE [MarsFarming]
GO
DROP VIEW IF EXISTS dbo.CO2Level;
GO
CREATE VIEW [dbo].[CO2Level] AS
SELECT
    co2.*,
    co2.filepath(1) AS Year,
    co2.filepath(2) AS Month
FROM OPENROWSET
(
    BULK 'abfss://synapse@bdadatalake.dfs.core.windows.net/marsfarming_curated/CO2Level/*/*/*.parquet',
    FORMAT = 'Parquet'
)
WITH
(
    PlotID INT,
    ReportDateTime DATETIME2(0),
    CO2Level DECIMAL(7,6)
) AS [co2];
GO
