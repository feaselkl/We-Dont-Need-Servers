USE MarsFarming
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.external_tables t
    WHERE
        t.name = N'ArabilityTest_212001'
)
BEGIN
    CREATE EXTERNAL TABLE [dbo].[ArabilityTest_212001]
    (
        PlotID INT,
        ReportDateTime DATETIME2(0),
        ArabilityScore NUMERIC(3,2)
    )
    WITH (
            LOCATION = 'ArabilityScore/2120/01/',
            DATA_SOURCE = [MarsFarmingCurated],
            FILE_FORMAT = [ParquetFileFormat]
    );
END

-- Let's try it out.
SELECT TOP(10) *
FROM dbo.ArabilityTest_212001;

SELECT * 
FROM dbo.ArabilityTest_212001
WHERE
    PlotID = 4462
    AND ReportDateTime < '2120-03-01';