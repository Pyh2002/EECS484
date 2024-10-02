SELECT
    DISTINCT s1.Subject
FROM
    Subjects s1
MINUS
SELECT
    DISTINCT s2.Subject
FROM
    Subjects s2,
    Authors a,
    Books b
WHERE
    s1.Subject_ID = b.Subject_ID
    AND b.Author_ID = a.Author_ID
ORDER BY
    s1.Subject ASC;