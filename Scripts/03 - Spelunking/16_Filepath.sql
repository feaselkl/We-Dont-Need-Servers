-- Gather information from a single folder and display the file names.
USE [MarsFarming]
GO
SELECT
    arability.filename() AS FileName,
    COUNT_BIG(*) AS NumberOfRows
FROM  
    OPENROWSET
    (
        BULK 'abfss://synapse@bdadatalake.dfs.core.windows.net/marsfarming_curated/ArabilityScore/2120/01/*.parquet',
        FORMAT='PARQUET'
    ) arability
GROUP BY
    arability.filename();

-- Gather information from each year and month's folders, also displaying filenames.
USE [MarsFarming]
GO
SELECT
    arability.filepath(1) AS Year,
    arability.filepath(2) AS Month,
    arability.filename() AS FileName,
    COUNT_BIG(*) AS NumberOfRows
FROM  
    OPENROWSET
    (
        BULK 'abfss://synapse@bdadatalake.dfs.core.windows.net/marsfarming_curated/ArabilityScore/*/*/*.parquet',
        FORMAT='PARQUET'
    ) arability
GROUP BY
    arability.filepath(1),
    arability.filepath(2),
    arability.filename();

-- Ditch the filename.
USE [MarsFarming]
GO
SELECT
    arability.filepath(1) AS Year,
    arability.filepath(2) AS Month,
    COUNT_BIG(*) AS NumberOfRows
FROM  
    OPENROWSET
    (
        BULK 'abfss://synapse@bdadatalake.dfs.core.windows.net/marsfarming_curated/ArabilityScore/*/*/*.parquet',
        FORMAT='PARQUET'
    ) arability
GROUP BY
    arability.filepath(1),
    arability.filepath(2)
ORDER BY
    NumberOfRows DESC;

-- Filter on specific filenames.
USE [MarsFarming]
GO
SELECT
    arability.filepath(1) AS Year,
    arability.filepath(2) AS Month,
    COUNT_BIG(*) AS NumberOfRows
FROM  
    OPENROWSET
    (
        BULK 'abfss://synapse@bdadatalake.dfs.core.windows.net/marsfarming_curated/ArabilityScore/*/*/*.parquet',
        FORMAT='PARQUET'
    ) arability
WHERE
    arability.filename() LIKE N'C%'
GROUP BY
    arability.filepath(1),
    arability.filepath(2)
ORDER BY
    NumberOfRows DESC;