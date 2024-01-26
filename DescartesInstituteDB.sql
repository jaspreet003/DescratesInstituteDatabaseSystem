/** 1.CREATING DATABASE SCHEMA **/
USE master;

--Cheack if the database already exists
if exists(
		  SELECT * FROM sysdatabases WHERE name = 'descartesdb'
		 )
	DROP DATABASE descartesdb;

-- 1.1 Creating database descartesdb 
EXEC('CREATE DATABASE descartesdb')
GO

USE descartesdb;
GO

--1.2.1 Primary tables
CREATE TABLE student(
	studentId INT,
	firstName NVARCHAR(20),
	lastName NVARCHAR(20),
	ssn INT,
	gender NVARCHAR(20),
	);

CREATE TABLE course(
    courseId INT,
    title NVARCHAR(50),
    courseHours INT,
    credits INT,
    fees INT,
    prerequisite INT
);

CREATE TABLE department(
	departmentId INT,
	departmentName NVARCHAR(20)
);

CREATE TABLE teacher(
	teacherId INT,
	firstName NVARCHAR(20),
	lastName NVARCHAR(20),
	grade NVARCHAR(20),
	gender NVARCHAR(20),
	experience INT,
	ssn INT,
	departmentId INT
);

--1.2.2 Associative tables
CREATE TABLE studentCourse(
	studentId INT,
	courseId INT,
	joinDate NVARCHAR(20),
	registrationNumber INT
);

CREATE TABLE courseTeacher(
	courseId INT,
	teacherId INT,
	contractNumber INT,
	teacherHours INT,
	rate INT,
	startDate NVARCHAR(20),
	endDate NVARCHAR(20)
);

-- 1.4 Creating SEQUENCE 
CREATE SEQUENCE SEQ_Number AS INT START WITH 1 INCREMENT BY 1;

-- Adding new identifier to each table --
ALTER TABLE courseTeacher ADD salary AS (teacherHours * rate);
ALTER TABLE course ADD total AS (credits * fees);

ALTER TABLE student ADD email nvarchar(25);
ALTER TABLE course ADD roomNumber int;
ALTER TABLE teacher ADD email nvarchar(25);
ALTER TABLE department ADD field nvarchar(25);
 

/** 2.DATA INTEGRITY **/
-- ** 2.1 Domain Integrity ***

-- 2.1.1 Not Null constraint
ALTER TABLE department ALTER COLUMN departmentName NVARCHAR(20) NOT NULL;
ALTER TABLE department ALTER COLUMN departmentId INT NOT NULL;
ALTER TABLE student ALTER COLUMN studentId INT NOT NULL;
ALTER TABLE course ALTER COLUMN courseId INT NOT NULL;
ALTER TABLE teacher ALTER COLUMN teacherId INT NOT NULL;
ALTER TABLE course ALTER COLUMN prerequisite INT;

-- 1.3 Index on the department name
CREATE INDEX index_department ON department(departmentName); -- CREATE INDEX AFTER QUESTION 2.1.1

-- 2.1.2 Unique constraint	
ALTER TABLE student ADD CONSTRAINT UQ_SSN UNIQUE (ssn);
ALTER TABLE teacher ADD CONSTRAINT UQ_TSSN UNIQUE (ssn);

-- 2.1.3 Default constraint
ALTER TABLE teacher ADD CONSTRAINT DF_experience DEFAULT 0 FOR experience;

-- 2.1.4 Check constraint 
ALTER TABLE course ADD CONSTRAINT CK_credits CHECK( credits>0);

-- ** 2.2 ENTITY INTEGRITY	

-- Adding primary keys
ALTER TABLE student ADD CONSTRAINT PK_studentID PRIMARY KEY (studentId);
ALTER TABLE teacher ADD CONSTRAINT PK_teacherID PRIMARY KEY (teacherId);
ALTER TABLE course ADD CONSTRAINT PK_courseID PRIMARY KEY (courseId);
ALTER TABLE department ADD CONSTRAINT PK_departmentID PRIMARY KEY (departmentId);

-- ** 2.3 REFERENTIAL INTEGRITY

-- Adding foreign keys
ALTER TABLE studentCourse ADD CONSTRAINT FK_courseID FOREIGN KEY (courseId) REFERENCES course;
ALTER TABLE studentCourse ADD CONSTRAINT FK_studentID FOREIGN KEY (studentId) REFERENCES student;
ALTER TABLE courseTeacher ADD CONSTRAINT FK_courseteacherID FOREIGN KEY (courseId) REFERENCES course;
ALTER TABLE courseTeacher ADD CONSTRAINT FK_teacherID FOREIGN KEY (teacherId) REFERENCES teacher(teacherId);
ALTER TABLE teacher ADD CONSTRAINT FK_departmentID FOREIGN KEY (departmentId) REFERENCES department;
ALTER TABLE course ADD CONSTRAINT FK_course_preReq FOREIGN KEY (prerequisite) REFERENCES course(courseId);

/** 3. Populating the tables **/
INSERT INTO course (courseId, title, courseHours, credits, fees, prerequisite, roomNumber) VALUES (1, 'Math', 8, 10, 800, NULL, 957);
INSERT INTO course (courseId, title, courseHours, credits, fees, prerequisite, roomNumber) VALUES (2, 'DB1', 6, 10, 600, NULL, 942);
INSERT INTO course (courseId, title, courseHours, credits, fees, prerequisite, roomNumber) VALUES (3, 'DB2', 8, 10, 800, 2, 691);
INSERT INTO course (courseId, title, courseHours, credits, fees, prerequisite, roomNumber) VALUES (4, 'OOP1', 6, 10, 600, NULL, 740);
INSERT INTO course (courseId, title, courseHours, credits, fees, prerequisite, roomNumber) VALUES (5, 'OOP2', 6, 10, 600, 4, 384);
INSERT INTO course (courseId, title, courseHours, credits, fees, prerequisite, roomNumber) VALUES (6, 'OS', 2, 10, 200, NULL, 552);
INSERT INTO course (courseId, title, courseHours, credits, fees, prerequisite, roomNumber) VALUES (7, 'Networking', 4, 10, 400, NULL, 422);
INSERT INTO course (courseId, title, courseHours, credits, fees, prerequisite, roomNumber) VALUES (8, 'French1', 8, 10, 800, NULL, 677);
INSERT INTO course (courseId, title, courseHours, credits, fees, prerequisite, roomNumber) VALUES (9, 'French2', 8, 10, 800, 8, 946);
INSERT INTO course (courseId, title, courseHours, credits, fees, prerequisite, roomNumber) VALUES (10, 'English1', 2, 10, 200, NULL, 433);
INSERT INTO course (courseId, title, courseHours, credits, fees, prerequisite, roomNumber) VALUES (11, 'English2', 6, 10, 600, 10, 790);
INSERT INTO course (courseId, title, courseHours, credits, fees, prerequisite, roomNumber) VALUES (12, 'WebDev', 8, 10, 800, NULL, 819);
INSERT INTO course (courseId, title, courseHours, credits, fees, prerequisite, roomNumber) VALUES (13, 'PhysicalED', 4, 10, 400, NULL, 590);
INSERT INTO course (courseId, title, courseHours, credits, fees, prerequisite, roomNumber) VALUES (14, 'MobileDev1', 8, 10, 800, NULL, 628);
INSERT INTO course (courseId, title, courseHours, credits, fees, prerequisite, roomNumber) VALUES (15, 'MobileDev2', 10, 10, 1000, 14, 594);

INSERT INTO department (departmentId, departmentName, field) VALUES (NEXT VALUE FOR SEQ_Number, 'Computer Science', 'Science');
INSERT INTO department (departmentId, departmentName, field) VALUES (NEXT VALUE FOR SEQ_Number, 'Mathematics', 'Science');
INSERT INTO department (departmentId, departmentName, field) VALUES (NEXT VALUE FOR SEQ_Number, 'Spanish', 'Language');
INSERT INTO department (departmentId, departmentName, field) VALUES (NEXT VALUE FOR SEQ_Number, 'English', 'Language');
INSERT INTO department (departmentId, departmentName, field) VALUES (NEXT VALUE FOR SEQ_Number, 'French', 'Language');
INSERT INTO department (departmentId, departmentName, field) VALUES (NEXT VALUE FOR SEQ_Number, 'Networking', 'Cisco');
INSERT INTO department (departmentId, departmentName, field) VALUES (NEXT VALUE FOR SEQ_Number, 'Development', 'Algorithm');
INSERT INTO department (departmentId, departmentName, field) VALUES (NEXT VALUE FOR SEQ_Number, 'Engineering', 'Science');
INSERT INTO department (departmentId, departmentName, field) VALUES (NEXT VALUE FOR SEQ_Number, 'Fashion', 'Gallery');
INSERT INTO department (departmentId, departmentName, field) VALUES (NEXT VALUE FOR SEQ_Number, 'Business', 'Commercial');
INSERT INTO department (departmentId, departmentName, field) VALUES (NEXT VALUE FOR SEQ_Number, 'Design', 'Clothes');
INSERT INTO department (departmentId, departmentName, field) VALUES (NEXT VALUE FOR SEQ_Number, 'Accounting', 'Tax');
INSERT INTO department (departmentId, departmentName, field) VALUES (NEXT VALUE FOR SEQ_Number, 'Tourism', 'Canada');
INSERT INTO department (departmentId, departmentName, field) VALUES (NEXT VALUE FOR SEQ_Number, 'Electronics', 'IT');
INSERT INTO department (departmentId, departmentName, field) VALUES (NEXT VALUE FOR SEQ_Number, 'Medicine', 'Animal');

INSERT INTO student (studentId, firstName, lastName, ssn, gender, email) VALUES (1,'Burhanuddin', 'Abdolhossein', 382779, 'male', 'Burh.sein@lasalle.ca');
INSERT INTO student (studentId, firstName, lastName, ssn, gender, email) VALUES (2,'Rafael', 'Leyla', 382780, 'male', 'Rafa.eyla@lasalle.ca');
INSERT INTO student (studentId, firstName, lastName, ssn, gender, email) VALUES (3,'María Dolores', 'Renato', 382781, 'male', 'Marí.nato@lasalle.ca');
INSERT INTO student (studentId, firstName, lastName, ssn, gender, email) VALUES (4,'Calixto', 'Gregorio', 382782, 'female', 'Cali.orio@lasalle.ca');
INSERT INTO student (studentId, firstName, lastName, ssn, gender, email) VALUES (5,'Rut', 'Carlito', 382783, 'female', 'Rut.lito@lasalle.ca');
INSERT INTO student (studentId, firstName, lastName, ssn, gender, email) VALUES (6,'Amin', 'Justa', 382784, 'female', 'Amin.usta@lasalle.ca');
INSERT INTO student (studentId, firstName, lastName, ssn, gender, email) VALUES (7,'Sanjay', 'Fina', 382785, 'male', 'Sanj.Fina@lasalle.ca');
INSERT INTO student (studentId, firstName, lastName, ssn, gender, email) VALUES (8,'Mostafa', 'Negin', 382786, 'female', 'Most.egin@lasalle.ca');
INSERT INTO student (studentId, firstName, lastName, ssn, gender, email) VALUES (9,'Isaac', 'Clímaco', 382787, 'male', 'Isaa.maco@lasalle.ca');
INSERT INTO student (studentId, firstName, lastName, ssn, gender, email) VALUES (10,'Yésica', 'Fereydoun', 382788, 'male', 'Yési.doun@lasalle.ca');
INSERT INTO student (studentId, firstName, lastName, ssn, gender, email) VALUES (11,'Crescencia', 'Bahram', 382789, 'male', 'Cres.hram@lasalle.ca');
INSERT INTO student (studentId, firstName, lastName, ssn, gender, email) VALUES (12,'Plácida', 'Elvira', 382790, 'female', 'Plác.vira@lasalle.ca');
INSERT INTO student (studentId, firstName, lastName, ssn, gender, email) VALUES (13,'Noé', 'Enrique', 382791, 'female', 'Noé.ique@lasalle.ca');
INSERT INTO student (studentId, firstName, lastName, ssn, gender, email) VALUES (14,'Kartik', 'Gauri', 382792, 'female', 'Kart.auri@lasalle.ca');
INSERT INTO student (studentId, firstName, lastName, ssn, gender, email) VALUES (15,'Hortensia', 'Manu', 382793, 'male', 'Hort.Manu@lasalle.ca');

INSERT INTO teacher (teacherId, firstName, lastName, grade, gender, experience, ssn, departmentId, email) VALUES (1,'lisa','kudrow','master','female',4,9832779,3,'lisa.kudr@lasalle.ca');
INSERT INTO teacher (teacherId, firstName, lastName, grade, gender, experience, ssn, departmentId, email) VALUES (2,'courteney','cox','master','female',1,9832780,1,'cour.cox@lasalle.ca');
INSERT INTO teacher (teacherId, firstName, lastName, grade, gender, experience, ssn, departmentId, email) VALUES (3,'davis','milan','PHD','male',1,9832781,1,'davi.mila@lasalle.ca');
INSERT INTO teacher (teacherId, firstName, lastName, grade, gender, experience, ssn, departmentId, email) VALUES (4,'steve','smith','master','male',4,9832782,5,'stev.smit@lasalle.ca');
INSERT INTO teacher (teacherId, firstName, lastName, grade, gender, experience, ssn, departmentId, email) VALUES (5,'watson','hennery','master','male',3,9832783,2,'wats.henn@lasalle.ca');
INSERT INTO teacher (teacherId, firstName, lastName, grade, gender, experience, ssn, departmentId, email) VALUES (6,'brad','pitt','master','male',1,9832784,2,'brad.pitt@lasalle.ca');
INSERT INTO teacher (teacherId, firstName, lastName, grade, gender, experience, ssn, departmentId, email) VALUES (7,'matthew','perry','PHD','male',3,9832785,4,'matt.perr@lasalle.ca');
INSERT INTO teacher (teacherId, firstName, lastName, grade, gender, experience, ssn, departmentId, email) VALUES (8,'anna','faris','PHD','female',1,9832786,4,'anna.fari@lasalle.ca');
INSERT INTO teacher (teacherId, firstName, lastName, grade, gender, experience, ssn, departmentId, email) VALUES (9,'minnie','driver','master','female',4,9832787,2,'minn.driv@lasalle.ca');
INSERT INTO teacher (teacherId, firstName, lastName, grade, gender, experience, ssn, departmentId, email) VALUES (10,'denise','richards','master','female',5,9832788,2,'deni.rich@lasalle.ca');
INSERT INTO teacher (teacherId, firstName, lastName, grade, gender, experience, ssn, departmentId, email) VALUES (11,'jae suh','park','PHD','female',1,9832789,3,'jae .park@lasalle.ca');
INSERT INTO teacher (teacherId, firstName, lastName, grade, gender, experience, ssn, departmentId, email) VALUES (12,'adam','demos','PHD','male',7,9832790,9,'adam.demo@lasalle.ca');
INSERT INTO teacher (teacherId, firstName, lastName, grade, gender, experience, ssn, departmentId, email) VALUES (13,'sarah','shahi','master','female',8,9832791,3,'sara.shah@lasalle.ca');
INSERT INTO teacher (teacherId, firstName, lastName, grade, gender, experience, ssn, departmentId, email) VALUES (14,'mike','vogel','PHD','male',3,9832792,1,'mike.voge@lasalle.ca');
INSERT INTO teacher (teacherId, firstName, lastName, grade, gender, experience, ssn, departmentId, email) VALUES (15,'amir','mehmood','PHD','male',2,9832793,7,'amir.mehm@lasalle.ca');

INSERT INTO courseTeacher (courseId,teacherId,contractNumber,teacherHours,rate,startDate,endDate) VALUES (1,10,732787,2,25,'2022/05/05',NULL);
INSERT INTO courseTeacher (courseId,teacherId,contractNumber,teacherHours,rate,startDate,endDate) VALUES (2,3,213124,4,35,'2021/04/15','20211229');
INSERT INTO courseTeacher (courseId,teacherId,contractNumber,teacherHours,rate,startDate,endDate) VALUES (3,2,563645,8,25,'2020/12/19',NULL);
INSERT INTO courseTeacher (courseId,teacherId,contractNumber,teacherHours,rate,startDate,endDate) VALUES (4,9,454526,10,25,'2012/11/15','20221110');
INSERT INTO courseTeacher (courseId,teacherId,contractNumber,teacherHours,rate,startDate,endDate) VALUES (5,7,654654,10,25,'2021/05/22',NULL);
INSERT INTO courseTeacher (courseId,teacherId,contractNumber,teacherHours,rate,startDate,endDate) VALUES (6,9,456645,4,25,'2022/08/11',NULL);
INSERT INTO courseTeacher (courseId,teacherId,contractNumber,teacherHours,rate,startDate,endDate) VALUES (7,1,546364,4,25,'2022/04/27',NULL);
INSERT INTO courseTeacher (courseId,teacherId,contractNumber,teacherHours,rate,startDate,endDate) VALUES (8,5,245652,4,20,'2012/06/19','20221210');
INSERT INTO courseTeacher (courseId,teacherId,contractNumber,teacherHours,rate,startDate,endDate) VALUES (9,12,633645,8,25,'2022/09/15','20221210');
INSERT INTO courseTeacher (courseId,teacherId,contractNumber,teacherHours,rate,startDate,endDate) VALUES (10,7,655655,2,25,'2021/11/23',NULL);
INSERT INTO courseTeacher (courseId,teacherId,contractNumber,teacherHours,rate,startDate,endDate) VALUES (11,11,453453,2,20,'2021/12/13',NULL);
INSERT INTO courseTeacher (courseId,teacherId,contractNumber,teacherHours,rate,startDate,endDate) VALUES (12,15,456634,4,22,'2021/01/27',NULL);
INSERT INTO courseTeacher (courseId,teacherId,contractNumber,teacherHours,rate,startDate,endDate) VALUES (13,5,546354,6,30,'2022/10/20',NULL);
INSERT INTO courseTeacher (courseId,teacherId,contractNumber,teacherHours,rate,startDate,endDate) VALUES (14,8,653425,8,45,'2022/01/11',NULL);
INSERT INTO courseTeacher (courseId,teacherId,contractNumber,teacherHours,rate,startDate,endDate) VALUES (15,9,789896,6,15,'2020/01/12','20221210');

INSERT INTO studentCourse(studentId,courseId,joinDate,registrationNumber) VALUES (2211239,8,'2022/01/10',1000001);
INSERT INTO studentCourse(studentId,courseId,joinDate,registrationNumber) VALUES (2211239,9,'2022/01/10',1000002);
INSERT INTO studentCourse(studentId,courseId,joinDate,registrationNumber) VALUES (2211239,10,'2022/01/10',1000003);
INSERT INTO studentCourse(studentId,courseId,joinDate,registrationNumber) VALUES (2211239,11,'2022/01/10',1000004);
INSERT INTO studentCourse(studentId,courseId,joinDate,registrationNumber) VALUES (2211239,12,'2022/01/10',1000005);
INSERT INTO studentCourse(studentId,courseId,joinDate,registrationNumber) VALUES (2233445,11,'2022/01/10',1000006);
INSERT INTO studentCourse(studentId,courseId,joinDate,registrationNumber) VALUES (2233445,12,'2022/01/10',1000007);
INSERT INTO studentCourse(studentId,courseId,joinDate,registrationNumber) VALUES (2233445,13,'2022/01/10',1000008);
INSERT INTO studentCourse(studentId,courseId,joinDate,registrationNumber) VALUES (2233445,14,'2022/01/10',1000009);
INSERT INTO studentCourse(studentId,courseId,joinDate,registrationNumber) VALUES (2233445,15,'2022/01/10',1000010);
INSERT INTO studentCourse(studentId,courseId,joinDate,registrationNumber) VALUES (2353561,1,'2022/01/10',1000011);
INSERT INTO studentCourse(studentId,courseId,joinDate,registrationNumber) VALUES (2353561,2,'2022/01/10',1000012);
INSERT INTO studentCourse(studentId,courseId,joinDate,registrationNumber) VALUES (2353561,3,'2022/01/10',1000013);
INSERT INTO studentCourse(studentId,courseId,joinDate,registrationNumber) VALUES (2353561,4,'2022/01/10',1000014);
INSERT INTO studentCourse(studentId,courseId,joinDate,registrationNumber) VALUES (2353561,5,'2022/01/10',1000015);