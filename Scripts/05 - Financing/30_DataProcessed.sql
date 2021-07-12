SELECT * FROM sys.dm_external_data_processed;

-- Approximate calculation of price
SELECT
    [type],
    [data_processed_mb],
    CAST(5 * [data_processed_mb] / (1024.0 * 1024.0) AS DECIMAL(12,2)) AS ApproximateCost
FROM sys.dm_external_data_processed;