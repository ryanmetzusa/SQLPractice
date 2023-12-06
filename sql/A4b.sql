--47--
CREATE TABLE MEMBERSHIP (
MEM_NUM int NOT NULL,
MEM_FNAME varchar(30),
MEM_LNAME varchar(30),
MEM_STREET varchar(30),
MEM_CITY varchar(30),
MEM_STATE varchar(30),
MEM_ZIP int,
MEM_BALANCE decimal (7,2) NULL );

CREATE TABLE RENTAL (
RENT_NUM int NOT NULL,
RENT_DATE datetime,
MEM_NUM int NOT NULL);

CREATE TABLE DETAILRENTAL (
RENT_NUM int NOT NULL,
VID_NUM int NOT NULL,
DETAIL_FEE int,
DETAIL_DUEDATE datetime,
DETAIL_RETURNDATE datetime,
DETAIL_DAILYLATEFEE int);

CREATE TABLE VIDEO (
VID_NUM int NOT NULL,
VID_INDATE datetime,
MOVIE_NUM int NOT NULL);

CREATE TABLE MOVIE (
MOVIE_NUM int NOT NULL,
MOVIE_TITLE varchar(30),
MOVIE_YEAR int,
MOVIE_COST int,
MOVIE_GENRE varchar(30),
PRICE_CODE int NOT NULL);

CREATE TABLE PRICE (
PRICE_CODE int NOT NULL,
PRICE_DESCRIPTION varchar(30),
PRICE_RENTFEE int,
PRICE_DAILYLATEFEE int);


ALTER TABLE MEMBERSHIP
ADD CONSTRAINT PK_MEMBERSHIP PRIMARY KEY (MEM_NUM)

ALTER TABLE RENTAL
ADD CONSTRAINT PK_RENTAL PRIMARY KEY (RENT_NUM),
CONSTRAINT FK_MEMBERSHIP_RENTAL FOREIGN KEY (MEM_NUM) REFERENCES MEMBERSHIP

ALTER TABLE DETAILRENTAL 
ADD CONSTRAINT PK_DETAILRENTAL PRIMARY KEY (RENT_NUM,VID_NUM),
	CONSTRAINT FK_RENTAL_DETAILRENTAL 
		FOREIGN KEY (RENT_NUM) REFERENCES RENTAL,
	CONSTRAINT FK_VIDEO_DETAILRENTAL 
		FOREIGN KEY (VID_NUM) REFERENCES VIDEO

ALTER TABLE VIDEO
ADD CONSTRAINT PK_VIDEO PRIMARY KEY (VID_NUM),
	CONSTRAINT FK_VIDEO FOREIGN KEY (MOVIE_NUM) REFERENCES MOVIE

ALTER TABLE MOVIE
ADD CONSTRAINT PK_MOVIE PRIMARY KEY (MOVIE_NUM),
	CONSTRAINT FK_MOVIE FOREIGN KEY (PRICE_CODE) REFERENCES PRICE

ALTER TABLE PRICE
ADD CONSTRAINT PK_PRICE PRIMARY KEY (PRICE_CODE)

--48--

-- MEMBERSHIP --
INSERT INTO MEMBERSHIP VALUES (102, 'TAMI', 'DAWSON', '2632 TAKLI CIRCLE', 'NORENE', 'TN', '37136', 11);
INSERT INTO MEMBERSHIP VALUES (103, 'CURT', 'KNIGHT', '4025 CORNELL COURT', 'FLATGAP', 'KY', '41219', 6);
INSERT INTO MEMBERSHIP VALUES (104, 'JAMAL', 'MELENDEZ', '788 EAST 145TH AVENUE', 'QUEBECK', 'TN', '38579', 0);
INSERT INTO MEMBERSHIP VALUES (105, 'IVA', 'MCCLAIN', '6045 MUSKET BALL CIRCLE', 'SUMMIT', 'KY', '42783', 15);
INSERT INTO MEMBERSHIP VALUES (106, 'MIRANDA', 'PARKS', '4469 MAXWELL PLACE', 'GERMANTOWN', 'TN', '38183', 0);
INSERT INTO MEMBERSHIP VALUES (107, 'ROSARIO', 'ELLIOTT', '7578 DANNER AVENUE', 'COLUMBIA', 'TN', '38402', 5);
INSERT INTO MEMBERSHIP VALUES (108, 'MATTIE', 'GUY', '4390 EVERGREEN STREET', 'LILY', 'KY', '40740', 0);
INSERT INTO MEMBERSHIP VALUES (109, 'CLINT', 'OCHOA', '1711 ELM STREET', 'GREENEVILLE', 'TN', '37745', 10);
INSERT INTO MEMBERSHIP VALUES (110, 'LEWIS', 'ROSALES', '4524 SOUTHWIND CIRCLE', 'COUNCE', 'TN', '38326', 0);
INSERT INTO MEMBERSHIP VALUES (111, 'STACY', 'MANN', '2789 EAST COOK AVENUE', 'MURFREESBORO', 'TN', '37132', 8);
INSERT INTO MEMBERSHIP VALUES (112, 'LUIS', 'TRUJILLO', '7267 MELVIN AVENUE', 'HEISKELL', 'TN', '37754', 3);
INSERT INTO MEMBERSHIP VALUES (113, 'MINNIE', 'GONZALES', '6430 VASILI DRIVE', 'WILLISTON', 'TN', '38076', 0);

-- RENTAL --
INSERT INTO RENTAL VALUES (1001, '2018-03-01', 103);
INSERT INTO RENTAL VALUES (1002, '2018-03-01', 105);
INSERT INTO RENTAL VALUES (1003, '2018-03-02', 102);
INSERT INTO RENTAL VALUES (1004, '2018-03-02', 110);
INSERT INTO RENTAL VALUES (1005, '2018-03-02', 111);
INSERT INTO RENTAL VALUES (1006, '2018-03-02', 107);
INSERT INTO RENTAL VALUES (1007, '2018-03-02', 104);
INSERT INTO RENTAL VALUES (1008, '2018-03-03', 105);
INSERT INTO RENTAL VALUES (1009, '2018-03-03', 111);

-- DETAILRENTAL --
INSERT INTO DETAILRENTAL VALUES (1001, 34342, 2, '2018-03-04', '2018-03-02', NULL);
INSERT INTO DETAILRENTAL VALUES (1001, 34366, 3.5, '2018-03-04', '2018-03-02', 3);
INSERT INTO DETAILRENTAL VALUES (1001, 61353, 2, '2018-03-04', '2018-03-03', 1);
INSERT INTO DETAILRENTAL VALUES (1002, 59237, 3.5, '2018-03-04', '2018-03-04', 3);
INSERT INTO DETAILRENTAL VALUES (1003, 54325, 3.5, '2018-03-04', '2018-03-09', 3);
INSERT INTO DETAILRENTAL VALUES (1003, 61369, 2, '2018-03-06', '2018-03-09', 1);
INSERT INTO DETAILRENTAL VALUES (1003, 61388, 0, '2018-03-06', '2018-03-09', 1);
INSERT INTO DETAILRENTAL VALUES (1004, 34341, 2, '2018-03-07', '2018-03-07', 1);
INSERT INTO DETAILRENTAL VALUES (1004, 34367, 3.5, '2018-03-05', '2018-03-07', 3);
INSERT INTO DETAILRENTAL VALUES (1004, 44392, 3.5, '2018-03-05', '2018-03-07', 3);
INSERT INTO DETAILRENTAL VALUES (1005, 34342, 2, '2018-03-07', '2018-03-05', 1);
INSERT INTO DETAILRENTAL VALUES (1005, 44397, 3.5, '2018-03-05', '2018-03-05', 3);
INSERT INTO DETAILRENTAL VALUES (1006, 34366, 3.5, '2018-03-05', '2018-03-04', 3);
INSERT INTO DETAILRENTAL VALUES (1006, 61367, 2, '2018-03-07', NULL, 1);
INSERT INTO DETAILRENTAL VALUES (1007, 34368, 3.5, '2018-03-05', NULL, 3);
INSERT INTO DETAILRENTAL VALUES (1008, 34369, 3.5, '2018-03-05', '2018-03-05', 3);
INSERT INTO DETAILRENTAL VALUES (1009, 54324, 3.5, '2018-03-05', NULL, 3);


-- VIDEO --
INSERT INTO VIDEO VALUES (54321, '2017-06-18', 1234);
INSERT INTO VIDEO VALUES (54324, '2017-06-18', 1234);
INSERT INTO VIDEO VALUES (54325, '2017-06-18', 1234);
INSERT INTO VIDEO VALUES (34341, '2016-01-22', 1235);
INSERT INTO VIDEO VALUES (34342, '2016-01-22', 1235);
INSERT INTO VIDEO VALUES (34366, '2018-03-02', 1236);
INSERT INTO VIDEO VALUES (34367, '2018-03-02', 1236);
INSERT INTO VIDEO VALUES (34368, '2018-03-02', 1236);
INSERT INTO VIDEO VALUES (34369, '2018-03-02', 1236);
INSERT INTO VIDEO VALUES (44392, '2017-10-21', 1237);
INSERT INTO VIDEO VALUES (44397, '2017-10-21', 1237);
INSERT INTO VIDEO VALUES (59237, '2018-02-14', 1237);
INSERT INTO VIDEO VALUES (61388, '2016-01-25', 1239);
INSERT INTO VIDEO VALUES (61353, '2015-01-28', 1245);
INSERT INTO VIDEO VALUES (61354, '2015-01-28', 1245);
INSERT INTO VIDEO VALUES (61367, '2017-07-30', 1246);
INSERT INTO VIDEO VALUES (61369, '2017-07-30', 1246);

-- MOVIE --
INSERT INTO MOVIE VALUES (1234, 'The Cesar Family Christmas', 2016, 39.95, 'FAMILY', 2);
INSERT INTO MOVIE VALUES (1235, 'Smokey Mountain Wildlife', 2013, 59.95, 'ACTION', 1);
INSERT INTO MOVIE VALUES (1236, 'Richard Goodhope', 2017, 59.95, 'DRAMA', 2);
INSERT INTO MOVIE VALUES (1237, 'Beatnik Fever', 2016, 29.95, 'COMEDY', 2);
INSERT INTO MOVIE VALUES (1238, 'Constant Companion', 2017, 89.95, 'DRAMA', NULL);
INSERT INTO MOVIE VALUES (1239, 'Where Hope Dies', 2007, 25.49, 'DRAMA', 3);
INSERT INTO MOVIE VALUES (1245, 'Time to Burn', 2014, 45.49, 'ACTION', 1);
INSERT INTO MOVIE VALUES (1246, 'What He Doesn''t Know', 2015, 58.29, 'COMEDY', 1);

--Price --
INSERT INTO PRICE VALUES (1, 'Standard', 2, 1);
INSERT INTO PRICE VALUES (2, 'New Release', 3.5, 3);
INSERT INTO PRICE VALUES (3, 'Discount', 1.5, 1);
INSERT INTO PRICE VALUES (4, 'Weekly Special', 1, .5);



-- 49. Write the SQL command to change the movie year for movie number 1245 to 2014.
SELECT *
FROM MOVIE

update movie
Set movie_year=2006
Where movie_num=1245;

-- 50. Write the SQL command to change the price code for all action movies to price code 3.
 UPDATE Movie SET PRICE_CODE = 3 WHERE MOVIE_GENRE = 'Action';
 SELECT * FROM MOVIE;

--51. Write a single SQL command to increase all price rental fee values in the PRICE table by $0.50.
UPDATE Price SET PRICE_CODE = PRICE_CODE + 0.50;

SELECT * FROM PRICE;


--52. Alter the DETAILRENTAL table to include a derived attribute named DETAIL_DAYSLATE to store integers of up to three digits. 
--The attribute should accept null values.

ALTER TABLE DETAILRENTAL 
Add column DETAIL_DAYSLATE NUMBER(3, 0);

SELECT * FROM detailrental

--53. Update the DETAILRENTAL table to set the values in DETAIL_RETURNDATE to include a time component. 
--Make each entry match the values shown in the following table.

update detailrental 
set detail_returndate ='02-Mar-2016 10:00 am' 
where detail_returndate ='02-Mar-2016'

update detailrental 
set detail_returndate ='03-Mar-2016 11:30 am'
 where detail_returndate ='03-Mar-2016'

update detailrental 
set detail_returndate ='04-Mar-2016 03:30 pm' 
where detail_returndate ='04-Mar-2016'

update detailrental 
set detail_returndate ='07-Mar-2016 09:00 am' 
where detail_returndate ='07-Mar-2016'

update detailrental 
set detail_returndate ='09-Mar-2016 04:00 pm' 
where detail_returndate ='09-Mar-2016'

update detailrental
 set detail_returndate ='05-Mar-2016 12:30 pm' 
where detail_returndate ='05-Mar-2016'

update detailrental 
set detail_returndate ='05-Mar-2016 09:30 pm' 
where rent_num =1008

update detailrental set detail_returndate ='04-Mar-2016 10:15 pm' where vid_num =34366 and rent_num =1006

SELECT * FROM detailrental

--54. Alter the VIDEO table to include an attribute named VID_STATUS to store character data up to 4 characters long.
--The attribute should not accept null values. 
--The attribute should have a constraint to enforce the domain (�IN�, �OUT�, and �LOST�) and have a default value of �IN�.

ALTER TABLE VIDEO 
ADD VID_STATUS VARCHAR(4) DEFAULT 'IN' NOT NULL 
CHECK (VID_STATUS IN ('IN', 'OUT', 'LOST'));

SELECT * FROM VIDEO


--55. Update the VID_STATUS attribute of the VIDEO table using a subquery to set the VID_STATUS to �OUT� for all videos that have a null value in the DETAIL_RETURNDATE attribute of the DETAILRENTAL table.
--UPDATE video SET Vid_Status = 'OUT' 

UPDATE VIDEO SET VID_STATUS = 'OUT' 
WHERE VID_NUM IN 
(SELECT VID_NUM FROM DETAILRENTAL WHERE DETAIL_RETURNDATE IS NULL);

SELECT * FROM VIDEO

--56. Alter the PRICE table to include an attribute named PRICE_RENTDAYS to store integers up to 2 digits. The attribute should not acceptnull values, and should have a default value of 3.

ALTER TABLE PRICE
ADD PRICE_RENTDAYS INT DEFAULT 3 NOT NULL;

SELECT * FROM PRICE

--57. Update the PRICE table to place the values shown in the following table in the
--PRICE_RENTDAYS attribute.
UPDATE PRICE
SET PRICE_RENTDAYS = 5
WHERE Price_Code = 1;
UPDATE PRICE
SET PRICE_RENTDAYS = 3
WHERE Price_Code = 2;
UPDATE PRICE
SET PRICE_RENTDAYS = 5
WHERE Price_Code = 3;
UPDATE PRICE
SET PRICE_RENTDAYS = 7
WHERE Price_Code = 4;

SELECT * FROM PRICE