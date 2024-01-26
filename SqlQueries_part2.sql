
//**** QUES1 ****//

/*Display the last name and the first name of the teachers as well as the number of the department in which they work
*/
select LASTNAME, FIRSTNAME,  DepartmentID from TEACHER;

LASTNAME                       FIRSTNAME                      DEPARTMENTID
------------------------------ ------------------------------ ------------
kaur                           parmpreet                              1001
kaur                           jaspreet                               1002
kaur                           parmjeet                               1006
singh                          mandeep                                1008
singh                          jasminder                              1009
kaur                           sukhwinder                             1005
singh                          jasdeep                                1010
kaur                           mandeep                                1012
kaur                           manjit                                 1011
singh                          parminder                              1011
singh                          sanjeet                                1004

LASTNAME                       FIRSTNAME                      DEPARTMENTID
------------------------------ ------------------------------ ------------
singh                          manpreet                               1003
kaur                           sandeep                                1000
singh                          parmjit                                1010
kaur                           jasjeet                                1011

15 rows selected.






//***** QUES2 ****//

 /* Display the total number of teachers working in the same department as well as the department number ordered by department number */ 
select count(*) AS Total_TEACHERS , DepartmentID from Teacher group by DepartmentID;
TOTAL_TEACHERS DEPARTMENTID
-------------- ------------
             1         1009
             3         1011
             1         1003
             1         1000
             1         1006
             1         1001
             1         1002
             2         1010
             1         1004
             1         1008
             1         1005

TOTAL_TEACHERS DEPARTMENTID
-------------- ------------
             1         1012

12 rows selected.






//***** QUES3 ****//
/* Display the name, the department number, DepartmentName, SSN in descending order by salary. */
Select t.FIRSTNAME as name, t.DepartmentID, d.DepartmentName, t.SSN 
       From TEACHER t , Department d 
	       Where t.DepartmentID = d.DepartmentID
			             Order by FIRSTNAME DESC;

NAME                           DEPARTMENTID DEPARTMENTNAME              SSN
------------------------------ ------------ -------------------- ----------
sukhwinder                             1005 Networking              9832754
sanjeet                                1004 French                  9832759
sandeep                                1000 Computer Science        9832761
parmpreet                              1001 Mathematics             9832749
parmjit                                1010 Design                  9832762
parmjeet                               1006 Development             9832751
parminder                              1011 Accounting              9832758
manpreet                               1003 English                 9832760
manjit                                 1011 Accounting              9832757
mandeep                                1008 Fashion                 9832752
mandeep                                1012 Tourism                 9832756

NAME                           DEPARTMENTID DEPARTMENTNAME              SSN
------------------------------ ------------ -------------------- ----------
jaspreet                               1002 Spanish                 9832750
jasminder                              1009 Business                9832753
jasjeet                                1011 Accounting              9832763
jasdeep                                1010 Design                  9832755

15 rows selected.





//***** QUES4 ****//

/* Display the first name and experience of the teacher whose name start with j and m. */
SELECT FIRSTNAME as NAME, Experience FROM Teacher WHERE FIRSTNAME LIKE 'j%' OR FIRSTNAME LIKE 'm%';

NAME                           EXPERIENCE
------------------------------ ----------
jaspreet                                2
mandeep                                 2
jasminder                              10
jasdeep                                 3
mandeep                                22
manjit                                 13
manpreet                                9
jasjeet                                 0

8 rows selected.


//***** QUES5 ****//
/* Write a query that displays the last name and student id of any student enrolled in the same course as jaspreet */
SELECT s.lastName, s.studentId FROM student s join studentcourse sc on s.studentId=sc.studentId WHERE (sc.courseId IN(
	SELECT sc2.courseId FROM student s2 join studentcourse sc2 on s2.studentId=sc2.studentId where s2.firstName='Jaspreet'
 ));

LASTNAME              STUDENTID
-------------------- ----------
Kaur                          1
Kaur                          1




//***** QUES6 ****//

/* Write the title and fee of course whose fees is greater than average fees. */
SELECT Title, Fees FROM Course where Fees > (SELECT AVG(Fees) FROM Course);
TITLE                                FEES
------------------------------ ----------
Math                                  800
DB2                                   800
French1                               800
French2                               800
WebDev                                800
MobileDev1                            800
MobileDev2                           1000

7 rows selected.






//***** QUES7 ****//
/* Display the department number, last name, and experience for every teacher in the Mathematics department. */
SELECT t.departmentId, t.lastName, t.experience FROM teacher t JOIN department d on t.departmentId = d.departmentId WHERE d.departmentName = 'Mathematics';
DEPARTMENTID LASTNAME                       EXPERIENCE
------------ ------------------------------ ----------
        1001 kaur                                    1