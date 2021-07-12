USE [MarsFarming]
GO
DECLARE
    @FirstDateInMonth DATE,
    @Year INT = 2115,
    @Month INT = 0,
    @sql NVARCHAR(MAX);
WHILE (@Year < 2120)
BEGIN
    SELECT
        @FirstDateInMonth = cm.CurrentMonth
    FROM
    (
        SELECT CAST('0001-01-01' AS DATE) AS BeginDate
    ) bd
    CROSS APPLY (SELECT DATEADD(YEAR, @Year, bd.BeginDate) AS CurrentYear) cy
    CROSS APPLY(SELECT DATEADD(MONTH, @Month, cy.CurrentYear) AS CurrentMonth) cm

    SET @sql = N'CREATE EXTERNAL TABLE [dbo].[N2Level_{Year}{Month}] WITH (
        LOCATION = ''N2Level/{Year}/{Month}/'',
        DATA_SOURCE = [MarsFarmingCurated],
        FILE_FORMAT = [ParquetFileFormat]
) AS
SELECT *
FROM OPENROWSET
(
    BULK ''abfss://synapse@bdadatalake.dfs.core.windows.net/marsfarming_raw/N2Level/*.txt'',
    FORMAT = ''CSV'',
    PARSER_VERSION = ''2.0'',
    FIELDTERMINATOR = '';'',
    FIRSTROW = 1
)
WITH
(
    PlotID INT,
    ReportDateTime DATETIME2(0),
    N2Level DECIMAL(7,6)
) AS [arability]
WHERE
    YEAR(ReportDateTime) = {Year}
    AND MONTH(ReportDateTime) = {Month};';
    
    SET @sql = REPLACE(@sql, N'{Year}', CAST(@Year+1 AS NVARCHAR(4)));
    SET @sql = REPLACE(@sql, N'{Month}', RIGHT(N'00' + CAST(@Month+1 AS NVARCHAR(2)), 2));
    
    EXEC(@sql);
    IF (@Month >= 11)
    BEGIN
        SET @Month = 0;
        SET @Year = @Year + 1;
    END
    ELSE
    BEGIN
        SET @Month = @Month + 1;
    END
END
