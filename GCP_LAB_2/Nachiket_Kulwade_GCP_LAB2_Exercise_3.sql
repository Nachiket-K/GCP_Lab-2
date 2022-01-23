SELECT
  date,
  pagePath,
  counter
FROM (
  SELECT
    parse_DATE('%Y%m%d',date) date,
    hts.page.pagePath AS pagePath,
    COUNT(*) AS counter
  FROM
    `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`,
    UNNEST(hits)AS hts
  GROUP BY
    date,
    hts.page.pagePath)
ORDER BY
  date
