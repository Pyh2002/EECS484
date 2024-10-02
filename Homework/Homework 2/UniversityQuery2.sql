SELECT s1.SID, s1.NAME
FROM Students s1
JOIN Students s2 ON s1.SID <> s2.SID
JOIN Members m1 ON s1.SID = m1.SID
JOIN Members m2 ON s2.SID = m2.SID
WHERE m1.PID = m2.PID
AND s2.SID IN
(
    SELECT e1.SID
    FROM Enrollments e1
    JOIN Enrollments e2 ON e1.SID = e2.SID
    JOIN Enrollments e3 ON e1.SID = e3.SID
    JOIN Courses c1 ON e1.CID = c1.CID
    JOIN Courses c2 ON e2.CID = c2.CID
    JOIN Courses c3 ON e3.CID = c3.CID
    WHERE e1.CID <> e2.CID
    AND e1.CID <> e3.CID
    AND e2.CID <> e3.CID
    AND (c1.C_Name = 'EECS482' OR c1.C_Name = 'EECS483')
    AND (c2.C_Name = 'EECS484' OR c2.C_Name = 'EECS485')
    AND c3.C_Name = 'EECS280'
)
ORDER BY s1.NAME DESC;