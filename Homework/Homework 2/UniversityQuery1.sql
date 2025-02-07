SELECT
    CID
FROM
    Enrollments e
    JOIN Students s ON e.SID = s.SID
GROUP BY
    e.CID
HAVING
    COUNT(
        CASE
            WHEN s.Major IS NULL
            OR s.Major != 'CS' THEN 1
        END
    ) < 10
ORDER BY
    e.CID DESC;