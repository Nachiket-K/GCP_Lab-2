SELECT
  owner_user_id AS id_user,
  COUNT(owner_user_id) AS count
FROM
  bigquery-public-data.stackoverflow.posts_answers
WHERE
  (owner_user_id IN (
    SELECT
      id
    FROM
      bigquery-public-data.stackoverflow.users)
    AND EXTRACT(year
    FROM
      creation_date)=2010)
GROUP BY
  owner_user_id
ORDER BY
  count DESC
limit 10