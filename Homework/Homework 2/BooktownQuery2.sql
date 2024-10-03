SELECT
    Subject
FROM
    (
        SELECT
            DISTINCT s1.Subject
        FROM
            Subjects s1
        MINUS
        SELECT
            DISTINCT s2.Subject
        FROM
            Subjects s2
            JOIN Books b ON s2.Subject_ID = b.Subject_ID
            JOIN Authors a ON b.Author_ID = a.Author_ID
    ) result
ORDER BY
    Subject ASC;