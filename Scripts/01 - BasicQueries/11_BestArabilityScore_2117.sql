USE [MarsFarming]
GO
SELECT
    MAX(ArabilityScore) AS MaxArabilityScore
FROM OPENROWSET
(
    BULK 'abfss://synapse@bdadatalake.dfs.core.windows.net/marsfarming_curated/ArabilityScore/2117/*/*.parquet',
    FORMAT = 'Parquet'
) AS [arability];
