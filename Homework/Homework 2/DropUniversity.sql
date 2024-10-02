-- Drop all tables in the university schema
BEGIN
    FOR rec IN (SELECT table_name FROM user_tables) LOOP
        EXECUTE IMMEDIATE 'DROP TABLE ' || rec.table_name || ' CASCADE CONSTRAINTS';
    END LOOP;
END;
/

-- Optionally, drop other objects like views, sequences, etc.
BEGIN
    FOR rec IN (SELECT view_name FROM user_views) LOOP
        EXECUTE IMMEDIATE 'DROP VIEW ' || rec.view_name;
    END LOOP;
END;
/

BEGIN
    FOR rec IN (SELECT sequence_name FROM user_sequences) LOOP
        EXECUTE IMMEDIATE 'DROP SEQUENCE ' || rec.sequence_name;
    END LOOP;
END;
/
