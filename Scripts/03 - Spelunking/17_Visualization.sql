USE [MarsFarming]
GO
WITH plots AS
(
    SELECT
        JSON_VALUE(doc, '$.PlotID') AS PlotID,
        JSON_VALUE(doc, '$.OwnerID') AS OwnerID,
        JSON_VALUE(doc, '$.City') as City,
        JSON_VALUE(doc, '$.SizeInAcres') as SizeInAcres
    FROM OPENROWSET
    (
        BULK 'abfss://synapse@bdadatalake.dfs.core.windows.net/marsfarming_metadata/Plot.json',
        FORMAT = 'CSV',
        FIELDTERMINATOR = '0x0b',
        FIELDQUOTE = '0x0b',
        ROWTERMINATOR = '\n'
    )
    WITH
    (doc NVARCHAR(MAX)) AS [plot]
),
o2level AS
(
    SELECT
        PlotID,
        AVG(O2Level) AS AvgO2Level
    FROM OPENROWSET
    (
        BULK 'abfss://synapse@bdadatalake.dfs.core.windows.net/marsfarming_curated/O2Level/*/*/*.parquet',
        FORMAT = 'Parquet'
    ) AS [o2]
    GROUP BY
        PlotID
)
SELECT
    p.City,
    AVG(o.AvgO2Level) AS AvgO2Level
FROM o2level o
    INNER JOIN plots p
        ON o.PlotID = p.PlotID
GROUP BY
    p.City;