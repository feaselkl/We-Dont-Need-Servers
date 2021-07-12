USE [MarsFarming]
GO
DROP VIEW IF EXISTS dbo.N2Level;
GO
CREATE VIEW [dbo].[N2Level] AS
SELECT
    N2.*,
    N2.filepath(1) AS Year,
    N2.filepath(2) AS Month
FROM OPENROWSET
(
    BULK 'abfss://synapse@bdadatalake.dfs.core.windows.net/marsfarming_curated/N2Level/*/*/*.parquet',
    FORMAT = 'Parquet'
)
WITH
(
    PlotID INT,
    ReportDateTime DATETIME2(0),
    N2Level DECIMAL(7,6)
) AS [N2];
GO
