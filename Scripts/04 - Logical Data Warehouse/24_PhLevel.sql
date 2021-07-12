USE [MarsFarming]
GO
DROP VIEW IF EXISTS dbo.PhLevel;
GO
CREATE VIEW [dbo].[PhLevel] AS
SELECT
    Ph.*,
    Ph.filepath(1) AS Year,
    Ph.filepath(2) AS Month
FROM OPENROWSET
(
    BULK 'abfss://synapse@bdadatalake.dfs.core.windows.net/marsfarming_curated/Ph/*/*/*.parquet',
    FORMAT = 'Parquet'
)
WITH
(
    PlotID INT,
    ReportDateTime DATETIME2(0),
    Ph DECIMAL(4,2)
) AS [Ph];
GO
