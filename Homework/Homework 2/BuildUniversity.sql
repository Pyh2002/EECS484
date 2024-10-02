-- Create tables
CREATE TABLE Students (
    SID INT PRIMARY KEY,
    Name VARCHAR(100),
    Major VARCHAR(50)
);

CREATE TABLE Enrollments (
    CID INT,
    SID INT,
    PRIMARY KEY (CID, SID),
    FOREIGN KEY (SID) REFERENCES Students(SID)
);

-- Insert sample data
INSERT INTO Students (SID, Name, Major) VALUES
(1, 'Alice', 'CS');  

INSERT INTO Students (SID, Name, Major) VALUES
(2, 'Bob', 'Math');   

INSERT INTO Students (SID, Name, Major) VALUES
(3, 'Charlie', NULL); 

INSERT INTO Students (SID, Name, Major) VALUES
(4, 'David', 'CS');   

INSERT INTO Students (SID, Name, Major) VALUES
(5, 'Eve', 'Biology'); 

-- Insert into Enrollments with valid SID references
INSERT INTO Enrollments (CID, SID) VALUES
(101, 1);  -- SID 1 exists

INSERT INTO Enrollments (CID, SID) VALUES
(101, 2);  -- SID 2 exists

INSERT INTO Enrollments (CID, SID) VALUES
(101, 3);  -- SID 3 exists

INSERT INTO Enrollments (CID, SID) VALUES
(102, 1);  -- SID 1 exists

INSERT INTO Enrollments (CID, SID) VALUES
(102, 4);  -- SID 4 exists

INSERT INTO Enrollments (CID, SID) VALUES
(102, 5);  -- SID 5 exists

INSERT INTO Enrollments (CID, SID) VALUES
(103, 1);  -- SID 1 exists