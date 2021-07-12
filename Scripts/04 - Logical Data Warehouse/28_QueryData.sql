USE [MarsFarming]
GO
SELECT TOP(5) *
FROM dbo.WaterScore;
GO

-- Figure out what plots looked like on a particular date and time.
SELECT
    p.PlotID,
    p.City,
    p.SizeInAcres,
    a.ReportDateTime,
    a.ArabilityScore,
    c.CO2Level,
    o.O2Level,
    n.N2Level,
    ph.Ph,
    t.Temperature,
    w.WaterScore
FROM dbo.Plot p
    INNER JOIN dbo.ArabilityScore a
        ON p.PlotID = a.PlotID
    INNER JOIN dbo.CO2Level c
        ON p.PlotID = c.PlotID
        AND a.ReportDateTime = c.ReportDateTime
    INNER JOIN dbo.O2Level o
        ON p.PlotID = o.PlotID
        AND a.ReportDateTime = o.ReportDateTime
    INNER JOIN dbo.N2Level n
        ON p.PlotID = n.PlotID
        AND a.ReportDateTime = n.ReportDateTime
    INNER JOIN dbo.PhLevel ph
        ON p.PlotID = ph.PlotID
        AND a.ReportDateTime = ph.ReportDateTime
    INNER JOIN dbo.Temperature t
        ON p.PlotID = t.PlotID
        AND a.ReportDateTime = t.ReportDateTime
    INNER JOIN dbo.WaterScore w
        ON p.PlotID = w.PlotID
        AND a.ReportDateTime = w.ReportDateTime
WHERE
    a.ReportDateTime = '2118-03-15 08:00:00'
    -- Note that these filters make a *huge* difference!
    -- Without these explicit filters, you'll spend a lot more time and cents
    -- running this query!
    AND a.Year = 2118
    AND a.Month = 3
    AND c.Year = 2118
    AND c.Month = 3
    AND o.Year = 2118
    AND o.Month = 3
    AND n.Year = 2118
    AND n.Month = 3
    AND ph.Year = 2118
    AND ph.Month = 3
    AND t.Year = 2118
    AND t.Month = 3
    AND w.Year = 2118
    AND w.Month = 3;
    