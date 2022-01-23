SELECT
  lang.name AS language_name,
  COUNT(lang.name) AS count
FROM
  bigquery-public-data.github_repos.languages,
  UNNEST(LANGUAGE)AS lang
GROUP BY
  lang.name
ORDER BY
  count DESC
LIMIT
  1;