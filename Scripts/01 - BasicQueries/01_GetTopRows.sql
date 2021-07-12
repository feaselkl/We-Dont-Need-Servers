-- Note:  First create a database called MarsFarming using the [+] -> New SQL database option in the Data menu

USE [MarsFarming]
GO
SELECT TOP(10) *
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
) AS [arability];
