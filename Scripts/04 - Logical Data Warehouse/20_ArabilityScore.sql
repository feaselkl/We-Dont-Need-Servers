USE [MarsFarming]
GO
DROP VIEW IF EXISTS dbo.ArabilityScore;
GO
CREATE VIEW [dbo].[ArabilityScore] AS
SELECT
    arability.*,
    arability.filepath(1) AS Year,
    arability.filepath(2) AS Month
FROM OPENROWSET
(
    BULK 'abfss://synapse@bdadatalake.dfs.core.windows.net/marsfarming_curated/ArabilityScore/*/*/*.parquet',
    FORMAT = 'Parquet'
)
WITH
(
    -- Because these are Parquet files, the names have to
    -- match what's in the file metadata.  Or we can remove the WITH clause!
    PlotID INT,
    ReportDateTime DATETIME2(0),
    ArabilityScore DECIMAL(3,2)
) AS [arability];
GO
