//**********ques1****************//
/--Write a query to display the total number of objects and the object type from the database.


select count(*) as TOTAL_OBJECTS, object_type from user_objects group by object_type ORDER BY OBJECT_TYPE ASC;

TOTAL_OBJECTS OBJECT_TYPE
------------- -------------------
           19 INDEX
            4 SEQUENCE
           10 TABLE


/--write a query to display the list of 10 tables from the database schema.
 select table_name from user_tables ORDER BY TABLE_NAME ASC;

TABLE_NAME
------------------------------
COURSE
ENROLLMENT
GRADE
GRADE_CONVERSION
GRADE_TYPE
GRADE_TYPE_WEIGHT
INSTRUCTOR
SECTION
STUDENT
ZIPCODE

10 rows selected.






/**********QUES 2****************/
/* Write a query to display the FIRST_NAME and LAST_NAME of all instructors who are living in 
the city of New York. */

select i.FIRST_NAME, i.LAST_NAME from INSTRUCTOR i JOIN ZIPCODE z on i.ZIP = z.ZIP where z.CITY = 'New York';

FIRST_NAME                LAST_NAME
------------------------- -------------------------
03ilyn                    Frantzen
Fernand                   Hanks
Anita                     Morris
Rick                      Chow
Tom                       Wojick
Nina                      Schorin
Todd                      Smythe
Charles                   Lowry
Gary                      Pertez

9 rows selected.





/************QUES3************/
/* Write a query to display the FIRST_NAME, LAST_NAME, STREET_ADDRESS, CITY and 
STATE of all students who live in Manchester (MA) and Ohio(OH). */

select s.FIRST_NAME, s.LAST_NAME, s.STREET_ADDRESS, z.CITY, z.STATE from STUDENT s JOIN ZIPCODE z on s.ZIP = z.ZIP where z.STATE = 'MA' or z.STATE = 'OH';

FIRST_NAME                LAST_NAME
------------------------- -------------------------
STREET_ADDRESS                                     CITY                      ST
-------------------------------------------------- ------------------------- --
James E.                  Norman
PO Box 809 Curran Hwy                              North Adams               MA

George                    Kocka
24 Beaufield St.                                   Dorchester                MA

Judy                      Sethi
Stratton Hall                                      Tufts Univ. Bedford       MA


FIRST_NAME                LAST_NAME
------------------------- -------------------------
STREET_ADDRESS                                     CITY                      ST
-------------------------------------------------- ------------------------- --
Thomas E.                 La Blank
49 Raleigh Rd                                      Weymouth                  MA

Walter                    Boremmann
88 Old Fields Rd                                   Sandwich                  MA

Phil                      Gilloon
4244 Morestown Ct. E                               Columbus                  OH


6 rows selected.







/***********QUES4***********/
/* Write a query to display the location, and the highest and lowest capacity for each location.*/

select LOCATION, min(CAPACITY), max(CAPACITY) from SECTION group by LOCATION;
LOCATION                                           MIN(CAPACITY) MAX(CAPACITY)
-------------------------------------------------- ------------- -------------
H310                                                          15            15
L214                                                          15            25
L210                                                          15            25
M500                                                          25            25
M311                                                          25            25
L507                                                          15            25
L206                                                          15            15
L500                                                          12            15
L511                                                          25            25
M200                                                          15            15
L509                                                          10            25

LOCATION                                           MIN(CAPACITY) MAX(CAPACITY)
-------------------------------------------------- ------------- -------------
L211                                                          15            25

12 rows selected.










/********QUES5**********/
/* Write a query to display the STUDENT_ID and FINAL_GRADE of students having the highest 
FINAL_GRADE (of all SECTIONS).*/

select s.STUDENT_ID, e.FINAL_GRADE from STUDENT s join ENROLLMENT e on s.STUDENT_ID = e.STUDENT_ID where e.FINAL_GRADE = (select max(FINAL_GRADE) from ENROLLMENT);
STUDENT_ID FINAL_GRADE
---------- -----------
       102          92










/************ QUES6 ***************/

/* Write a query to display COURSE_NO, DESCRIPTION, COST, and PREREQUISITE of all 
courses that have a minimum cost */

select c.COURSE_NO, c.DESCRIPTION, c.COST, c.PREREQUISITE from COURSE c where c.COST = (select min(COST) from COURSE);
select c.COURSE_NO, c.DESCRIPTION, c.COST, c.PREREQUISITE from COURSE c where c.COST = (select min(COST) from COURSE);

 COURSE_NO DESCRIPTION                                              COST
---------- -------------------------------------------------- ----------
PREREQUISITE
------------
       135 Unix Tips and Techniques                                 1095
         134

       230 Intro to the Internet                                    1095
          10

       240 Intro to the BASIC Language                              1095
          25


