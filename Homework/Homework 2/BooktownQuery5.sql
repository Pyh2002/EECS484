SELECT
    a.Author_ID,
    a.First_Name,
    a.Last_Name
FROM
    Authors a
WHERE
    NOT EXISTS (
        SELECT
            1
        FROM
            Books b_jk
            JOIN Subjects s_jk ON b_jk.Subject_ID = s_jk.Subject_ID
        WHERE
            b_jk.Author_ID = (
                SELECT
                    Author_ID
                FROM
                    Authors
                WHERE
                    First_Name = 'J. K.'
                    AND Last_Name = 'Rowling'
            )
            AND NOT EXISTS (
                SELECT
                    1
                FROM
                    Books b_a
                WHERE
                    b_a.Author_ID = a.Author_ID
                    AND b_a.Subject_ID = s_jk.Subject_ID
            )
    )
ORDER BY
    a.Last_Name ASC,
    a.Author_ID DESC;