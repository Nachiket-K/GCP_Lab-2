SELECT
  repo_name,
  diff.old_path AS file,
  committer.date AS date,
  LAG(COMMIT,1,NULL) OVER (ORDER BY committer.date) AS previous_commit,
  COMMIT,
  lead (COMMIT,1,NULL) OVER(ORDER BY commiter.date) AS next_commit
FROM
  bigquery-public-data.github_repos.sample_commits,
  UNNEST(difference) AS diff
WHERE
  diff.old_path='kernel/acct.c'
ORDER BY date