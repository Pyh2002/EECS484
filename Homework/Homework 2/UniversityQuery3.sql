SELECT
    DISTINCT s.SID
FROM
    Students s
    JOIN Enrollments e1 ON s.SID = e1.SID
    JOIN Enrollments e2 ON s.SID = e2.SID
    JOIN Enrollments e3 ON s.SID = e3.SID
    JOIN Courses c1 ON e1.CID = c1.CID
    JOIN Courses c2 ON e2.CID = c2.CID
    JOIN Courses c3 ON e3.CID = c3.CID
WHERE
    (
        (
            c1.C_Name = 'EECS442'
            AND c2.C_Name = 'EECS445'
            AND c3.C_Name = 'EECS492'
        )
        OR (
            c1.C_Name = 'EECS482'
            AND c2.C_Name = 'EECS486'
        )
        OR (c1.C_Name = 'EECS281')
    )
ORDER BY
    s.SID ASC;