CREATE EXTERNAL TABLE [dbo].[Arability_211601] WITH (
        LOCATION = 'ArabilityScore/2116/01/',
        DATA_SOURCE = [MarsFarmingCurated],
        FILE_FORMAT = [ParquetFileFormat]
) AS
SELECT *
FROM OPENROWSET
(
    BULK 'abfss://synapse@bdadatalake.dfs.core.windows.net/marsfarming_raw/ArabilityScore/*.txt',
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
WHERE
    YEAR(ReportDateTime) = 2116
    AND MONTH(ReportDateTime) = 1;

-- Now let's try it out.
SELECT
    PlotID,
    COUNT(*) AS NumberOfRecords
FROM dbo.Arability_211601
GROUP BY
    PlotID
ORDER BY
    NumberOfRecords DESC;