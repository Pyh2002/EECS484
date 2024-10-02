SELECT
    e.ISBN
FROM
    Editions e,
    Authors a,
    Books b
WHERE
    e.Book_ID = b.Book_ID
    AND a.Author_ID = b.Author_ID
    AND a.Last_Name = 'Christie'
    AND a.First_Name = 'Agatha'
ORDER BY
    e.ISBN ASC;