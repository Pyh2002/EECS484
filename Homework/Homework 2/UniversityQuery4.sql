CREATE VIEW StudentPairs AS
SELECT
    DISTINCT s1.SID AS SID1,
    s2.SID AS SID2
FROM
    Students s1,
    Students s2,
    Enrollments e1,
    Enrollments e2
WHERE
    s1.SID < s2.SID
    AND e1.CID = e2.CID
    AND e1.SID = s1.SID
    AND e2.SID = s2.SID
MINUS
SELECT
    DISTINCT s1.SID AS SID1,
    s2.SID AS SID2
FROM
    Students s1,
    Students s2,
    Members m1,
    Members m2
WHERE
    s1.SID < s2.SID
    AND m1.PID = m2.PID
    AND m1.SID = s1.SID
    AND m2.SID = s2.SID;