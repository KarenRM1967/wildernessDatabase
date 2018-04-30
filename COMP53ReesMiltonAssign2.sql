-- Karen Rees-Milton. March 19, 2018. COMP53 Assign2
-- Eastern Ontario Wilderness Outdoor Courses

DROP DATABASE IF EXISTS ReesMiltonWilderness;
CREATE DATABASE ReesMiltonWilderness;
USE ReesMiltonWilderness;

CREATE TABLE course
(
	courseID				CHAR(2)			PRIMARY KEY,
    courseName				VARCHAR(20),		
    courseDifficulty		VARCHAR(10),
    courseCost				DEC(5, 2),
    courseGearWeightKG		INT
);

INSERT INTO course VALUES
('C1', 'Wild Edibles', 'beginner', 120.50, 0),
('C2', 'Animal Tracking', 'beginner', 75, 3),
('C3', 'Building Shelters', 'difficult', 250, 15);

CREATE TABLE participant
(
	partID			CHAR(2)			PRIMARY KEY,
    partFName		VARCHAR(5),	
    partLName		VARCHAR(15),
    partEmail		VARCHAR(20)
);

INSERT INTO participant VALUES
('P1', 'Joe', 'Suzuki', 'suzuki@live.com'),
('P2', 'Pat', 'Johnston', 'jston@hotmail.com'),
('P3', 'Ezra', 'Jones', 'ezjones@gmail.com'),
('P4', 'Sue', 'Lee', 'sue78@hotmail.com'),
('P5', 'Karen', 'Rees-Milton', 'KRM@yahoo.com');

CREATE TABLE courseParticipant
(
	courseID				CHAR(2),
    partID					CHAR(2),
    coursePartTakenBefore	BOOL,
    
    PRIMARY KEY (courseID, partID),
    
    FOREIGN KEY (courseID)
		REFERENCES course(courseID),
        
	FOREIGN KEY (partID)
		REFERENCES participant(partID)
);

INSERT INTO courseParticipant VALUES
('C1', 'P1', FALSE),
('C2', 'P2', FALSE),
('C3', 'P3', TRUE),
('C1', 'P3', TRUE),
('C1', 'P2', TRUE),
('C2', 'P4', TRUE),
('C3', 'P4', FALSE),
('C2', 'P1', TRUE);

CREATE TABLE courseLocation
(
	courseID					CHAR(2)			PRIMARY KEY,
    courseLocation				VARCHAR(40),
    courseLocationCarAccess		BOOL,
    
    FOREIGN KEY (courseID)
		REFERENCES course(courseID)
);

INSERT INTO courseLocation VALUES
('C1', 'Charleston Lake', TRUE),
('C2', 'Algonquin Park', FALSE),
('C3', 'Cataraqui Creek Conservation Area', TRUE);

/*

-- query#1
SELECT * FROM course
WHERE courseDifficulty = 'beginner'
	AND courseCost < 100;
    
-- query#2
SELECT * FROM course
WHERE courseCost BETWEEN 100 AND 300
ORDER BY courseCost DESC;

-- query#3
SELECT partFName, partLName
FROM participant
WHERE partLName LIKE 'J%'
	OR partLName LIKE 'L%'
ORDER BY partFName;

-- query#4
SELECT courseName, courseCost, 
	CASE
		WHEN courseDifficulty = 'beginner'
			THEN (FORMAT(courseCost * 1.2, 2)) 
		ELSE courseCost
	END AS newCost 
FROM course
ORDER BY newCost;

-- query#5
SELECT courseName, courseLocation
FROM course c
	JOIN courseLocation cl
		ON c.courseID = cl.courseID
ORDER BY courseLocation;

-- query#6
SELECT partFName, partLName
FROM participant p
	JOIN courseParticipant cp
		ON p.partID = cp.partID
	JOIN course c
		ON cp.courseID = c.courseID
WHERE courseName = 'Building Shelters'
	AND coursePartTakenBefore = FALSE;

-- query#7
SELECT partFName, partLName, partEmail
FROM participant p
	LEFT JOIN courseParticipant cp
		ON p.partID = cp.partID
WHERE coursePartTakenBefore IS NULL;

-- query#8
SELECT CONCAT(partFName, ', ', courseName, '-', courseLocation)
	   AS Participant_Summary
FROM participant p
	JOIN courseParticipant cp
		ON p.partID = cp.partID
	JOIN courseLocation cl
		ON cp.courseID = cl.courseID
	JOIN course c
		ON cl.courseID = c.courseID
WHERE courseGearWeightKG <> 0;
    
    
    



















