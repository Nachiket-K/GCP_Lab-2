SELECT
  visitId,
  visitStartTime,
  hts.page.pageTitle,
  hts.page.pagePath
FROM
  bigquery-public-data.google_analytics_sample.ga_sessions_20170801,
  UNNEST(hits)AS hts;