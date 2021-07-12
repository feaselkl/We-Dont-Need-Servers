USE [MarsFarming]
GO
SELECT TOP(10)
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
(doc NVARCHAR(MAX)) AS [plot];
