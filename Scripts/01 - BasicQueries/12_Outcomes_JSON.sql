USE [MarsFarming]
GO
SELECT
    JSON_VALUE(doc, '$.OutcomeID') AS OutcomeID,
    JSON_VALUE(doc, '$.OutcomeName') AS OutcomeName,
    doc
FROM OPENROWSET
(
    BULK 'abfss://synapse@bdadatalake.dfs.core.windows.net/marsfarming_metadata/Outcome.json',
    FORMAT = 'CSV',
    FIELDTERMINATOR = '0x0b',
    FIELDQUOTE = '0x0b'
)
WITH
(doc VARCHAR(MAX)) AS [outcome];
