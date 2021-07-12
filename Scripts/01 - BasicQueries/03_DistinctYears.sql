USE [MarsFarming]
GO
SELECT DISTINCT
    YEAR(ReportDateTime) AS ReportYear
FROM OPENROWSET
(
    BULK 'abfss://synapse@bdadatalake.dfs.core.windows.net/marsfarming_raw/ArabilityScore/ArabilityScore_1.txt',
    FORMAT = 'CSV',
    PARSER_VERSION = '2.0',
    FIELDTERMINATOR = ';',
    FIRSTROW = 1
)
WITH
(
    PlotID INT,
    ReportDateTime DATETIME2(0),
    ArabilityScore DECIMAL(3,2)
) AS [arability]
ORDER BY
    ReportYear ASC;
