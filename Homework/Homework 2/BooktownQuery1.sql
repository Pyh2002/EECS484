SELECT
    DISTINCT a.Author_ID
FROM
    Authors a
    JOIN Books b ON a.Author_ID = b.Author_ID
GROUP BY
    a.Author_ID
HAVING
    COUNT(b.Book_ID) = 1
ORDER BY
    a.Author_ID ASC;