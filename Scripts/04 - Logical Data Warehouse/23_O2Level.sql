USE [MarsFarming]
GO
DROP VIEW IF EXISTS dbo.O2Level;
GO
CREATE VIEW [dbo].[O2Level] AS
SELECT
    O2.*,
    O2.filepath(1) AS Year,
    O2.filepath(2) AS Month
FROM OPENROWSET
(
    BULK 'abfss://synapse@bdadatalake.dfs.core.windows.net/marsfarming_curated/O2Level/*/*/*.parquet',
    FORMAT = 'Parquet'
)
WITH
(
    PlotID INT,
    ReportDateTime DATETIME2(0),
    O2Level DECIMAL(7,6)
) AS [O2];
GO
