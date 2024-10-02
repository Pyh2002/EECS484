-- SELECT
--     a.First_Name,
--     a.Last_Name
-- FROM
--     Authors a,
--     Books b1,
--     Books b2,
--     Subjects s1,
--     Subjects s2
-- WHERE
--     a.Author_ID = b1.Author_ID
--     AND a.Author_ID = b2.Author_ID
--     AND b1.Subject_ID = s1.Subject_ID
--     AND b2.Subject_ID = s2.Subject_ID
--     AND s1.Subject = 'Children/YA'
--     AND s2.Subject = 'Fiction'
-- ORDER BY
--     a.Last_Name ASC,
--     a.First_Name ASC;
SELECT
    DISTINCT a.First_Name,
    a.Last_Name
FROM
    Authors a
WHERE
    a.Author_ID IN (
        SELECT
            a1.Author_ID
        FROM
            Authors a1,
            Books b1,
            Books b2,
            Subjects s1,
            Subjects s2
        WHERE
            a1.Author_ID = b1.Author_ID
            AND a1.Author_ID = b2.Author_ID
            AND b1.Subject_ID = s1.Subject_ID
            AND b2.Subject_ID = s2.Subject_ID
            AND s1.Subject = 'Children/YA'
            AND s2.Subject = 'Fiction'
    )
ORDER BY
    a.Last_Name ASC,
    a.First_Name ASC;