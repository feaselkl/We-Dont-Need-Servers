USE [MarsFarming]
GO
DROP VIEW IF EXISTS dbo.WaterScore;
GO
CREATE VIEW [dbo].[WaterScore] AS
SELECT
    Water.*,
    Water.filepath(1) AS Year,
    Water.filepath(2) AS Month
FROM OPENROWSET
(
    BULK 'abfss://synapse@bdadatalake.dfs.core.windows.net/marsfarming_curated/WaterScore/*/*/*.parquet',
    FORMAT = 'Parquet'
)
WITH
(
    PlotID INT,
    ReportDateTime DATETIME2(0),
    WaterScore DECIMAL(5,2)
) AS [Water];
GO
