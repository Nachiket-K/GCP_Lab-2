WITH
  info AS (
  SELECT
    repo_name
  FROM
    bigquery-public-data.github_repos.languages,
    UNNEST(LANGUAGE)
  WHERE
    name='Java' )
SELECT
  committer.name,
  COUNT(*) AS count
FROM
  bigquery-public-data.github_repos.sample_commits
WHERE
  repo_name IN (
  SELECT
    repo_name
  FROM
    info)
  AND EXTRACT(year
  FROM
    committer.date)=2016
GROUP BY
  (committer.name)
ORDER BY
  count DESC
LIMIT
  10