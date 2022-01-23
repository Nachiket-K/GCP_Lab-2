WITH
  info AS
   (
        SELECT
        FORMAT_DATE("%Y",Release_Date) AS year,
        Movie_Title,
        Production_Budget,
        RANK() OVER (PARTITION BY year ORDER BY Production_Budget DESC) AS rank
        FROM 
        ( 
            (
                SELECT *,
                FORMAT_DATE("%Y",Release_Date)AS year
                FROM
                    nttdata-c4e-bde.uc1_5.Movie
                    WHERE
                    (Release_Date BETWEEN '2016-01-01'AND '2020-12-31')
                ORDER BY production_budget DESC 
            ) 
        ) 
  )
SELECT
  year,
  Movie_Title,
  Production_Budget,
  Rank
FROM
  info
WHERE
  rank<=10
ORDER BY
  year DESC,
  rank ASC