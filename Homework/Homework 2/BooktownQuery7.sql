SELECT
    DISTINCT b.Title,
    SUM(e.Pages) AS Total_Pages
FROM
    Books b,
    Editions e
WHERE
    e.Book_ID = b.Book_ID
GROUP BY
    b.Title
ORDER BY
    Total_Pages DESC;