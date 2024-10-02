SELECT
    DISTINCT b.Title,
    e.Publication_Date,
    a.Author_ID,
    a.First_Name,
    a.Last_Name
FROM
    Books b,
    Editions e,
    Authors a
WHERE
    b.Book_ID = e.Book_ID
    AND b.Author_ID = a.Author_ID
    AND a.Author_ID IN(
        SELECT
            a.Author_ID
        FROM
            Authors a,
            Books b,
            Editions e
        WHERE
            e.Book_ID = b.Book_ID
            AND a.Author_ID = b.Author_ID
            AND e.Publication_Date >= '2003-01-01'
            AND e.Publication_Date <= '2008-12-31'
    )
ORDER BY
    a.Author_ID ASC,
    b.Title ASC,
    e.Publication_Date DESC;