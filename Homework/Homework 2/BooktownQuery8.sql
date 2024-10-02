SELECT
    DISTINCT p.Publisher_ID,
    p.Name
FROM
    Publishers p,
    Editions e,
    Authors a,
    Books b
WHERE
    e.Publisher_ID = p.Publisher_ID
    AND b.Author_ID = a.Author_ID
    AND b.Book_ID = e.Book_ID
    AND a.Author_ID IN (
        SELECT
            a.Author_ID
        FROM
            Authors a
        WHERE
            a.Author_ID IN (
                SELECT
                    b.Author_ID
                FROM
                    Books b
                GROUP BY
                    b.Author_ID
                HAVING
                    COUNT(b.Book_ID) = 3
            )
    )
ORDER BY
    p.Publisher_ID DESC;