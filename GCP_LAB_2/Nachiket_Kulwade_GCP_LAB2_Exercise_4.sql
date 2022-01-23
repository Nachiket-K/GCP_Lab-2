WITH
  country_info AS (
  SELECT
    country,
    ARRAY_AGG(STRUCT(operatingSystem,
        browser,
        rank)
    LIMIT
      3) AS country_rank
  FROM (
    SELECT
      country,
      operatingSystem,
      browser,
      rank
    FROM (
      SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY country ORDER BY counter DESC ) AS rank
      FROM (
        SELECT
          geoNetwork.country AS country,
          device.operatingSystem AS operatingSystem,
          device.browser AS browser,
          COUNT(*) AS counter
        FROM
          bigquery-public-data.google_analytics_sample.ga_sessions_20170801
        WHERE
          device.isMobile=TRUE
        GROUP BY
          country,
          operatingSystem,
          browser
        ORDER BY
          country ) ) )
  WHERE
    country NOT LIKE '(%)'
  GROUP BY
    country )
SELECT
  *
FROM
  country_info
ORDER BY
  country