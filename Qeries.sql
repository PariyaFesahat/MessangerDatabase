/************************** USE SCHEMA MESSANGER **************************/
Use Messanger

/************************** CREATE TABLE COMMANDS **************************/

CREATE TABLE Users(
Contact_ID char(7) PRIMARY KEY
);

CREATE TABLE Accessibility(
A_ID char(7) PRIMARY KEY,
photo nvarchar(MAX),
Descriptions nvarchar(200),
inv_link nvarchar(MAX),
);

CREATE TABLE Setting(
Set_ID char(7) PRIMARY KEY,
storage_Path nvarchar(MAX),
UnlockDou TiMe,
usage char(4)
	CHECK(usage = 'Wifi' OR usage = 'Data'),
twoStep nvarchar(MAX)
	CHECK(LEN(twoStep) >= 4),
sound int
	CHECK(sound >= 1 AND sound <= 100),
passcode nvarchar(25)
	CHECK(LEN(passcode) >= 12),
);

CREATE TABLE Chat(
Chat_ID char(7) PRIMARY KEY,
Archive bit
);

CREATE TABLE PV(
Chat_ID char(7) PRIMARY KEY,

FOREIGN KEY(Chat_ID) REFERENCES Chat(Chat_ID)
ON DELETE NO ACTION   ON UPDATE CASCADE
);

CREATE TABLE Saved_Message(
Saved_ID char(7) PRIMARY KEY,
Use_ID char(7),

FOREIGN KEY(Use_ID) REFERENCES Users(Contact_ID)
ON DELETE NO ACTION   ON UPDATE CASCADE
);

CREATE TABLE Contact(
ID char(7) PRIMARY KEY,
F_Name nvarchar(50),
L_Name nvarchar(50),
phone char(11),
profile_pic image,
bio nvarchar(150),
);

CREATE TABLE Contact_Of_User(
Contact_ID char(7),
Use_ID char(7),

FOREIGN KEY(Contact_ID) REFERENCES Contact(ID),
FOREIGN KEY(Use_ID) REFERENCES Users(COntact_ID)
ON DELETE NO ACTION  ON UPDATE CASCADE
);

CREATE TABLE Sender(
Contact_ID char(7) PRIMARY KEY,

FOREIGN KEY(Contact_ID) REFERENCES Contact(ID)
ON DELETE NO ACTION   ON UPDATE CASCADE
);

CREATE TABLE Receiver(
Contact_ID char(7) PRIMARY KEY,

FOREIGN KEY(Contact_ID) REFERENCES Contact(ID)
ON DELETE NO ACTION   ON UPDATE CASCADE
);

CREATE TABLE Admin(
Contact_ID char(7) PRIMARY KEY,

FOREIGN KEY(Contact_ID) REFERENCES Contact(ID)
ON DELETE NO ACTION   ON UPDATE CASCADE
);


CREATE TABLE MSG(
MSG_ID char(7) PRIMARY KEY,
Chat_ID char(7),
Sender_ID char(7),
txt text,
times time,
dates date,
locations geometry,
Picture image,
music nvarchar(MAX),
files nvarchar(MAX),
video nvarchar(MAX)

FOREIGN KEY(Sender_ID) REFERENCES Sender(Contact_ID),
FOREIGN KEY(Chat_ID) REFERENCES Chat(Chat_ID)
ON DELETE NO ACTION   ON UPDATE CASCADE
);

CREATE TABLE Channel(
Chat_ID char(7) PRIMARY KEY,
A_ID char(7),
Ch_name nvarchar(50)

FOREIGN KEY(Chat_ID) REFERENCES Chat(Chat_ID),
FOREIGN KEY(A_ID) REFERENCES Accessibility(A_ID)
ON DELETE NO ACTION   ON UPDATE CASCADE
);

CREATE TABLE Groups(
Chat_ID char(7) PRIMARY KEY,
A_ID char(7),
G_name nvarchar(50)

FOREIGN KEY(Chat_ID) REFERENCES Chat(Chat_ID),
FOREIGN KEY(A_ID) REFERENCES Accessibility(A_ID)
ON DELETE NO ACTION   ON UPDATE CASCADE
);

CREATE TABLE Call(
Contact_ID char(7),
Use_ID char(7),
call_time DateTime,
call_type nvarchar(20),

fOREIGN KEY(USE_ID) REFERENCES Users(CONTACT_ID),
fOREIGN KEY(Contact_ID) REFERENCES Contact(ID)
ON DELETE NO ACTION   ON UPDATE CASCADE
);

CREATE TABLE Session(
Session_ID char(7) PRIMARY KEY,
Use_ID char(7),
Set_ID char(7),
timeStamps datetime,
IPs nvarchar(20),
device nvarchar(50),

FOREIGN KEY(Use_ID) REFERENCES Users(Contact_ID),
FOREIGN KEY(Set_ID) REFERENCES Setting(Set_ID)
ON DELETE NO ACTION   ON UPDATE CASCADE
);



CREATE TABLE Receives(
Receiver_ID char(7),
MSG_ID char(7),

FOREIGN KEY(Receiver_ID) REFERENCES Receiver(Contact_ID),
FOREIGN KEY(MSG_ID) REFERENCES MSG(MSG_ID)
ON DELETE NO ACTION   ON UPDATE CASCADE
);

------------HAS-------------

CREATE TABLE Has_SM(
Saved_ID char(7),
MSG_ID char(7)

FOREIGN KEY(Saved_ID) REFERENCES Saved_Message(Saved_ID),
FOREIGN KEY(MSG_ID) REFERENCES MSG(MSG_ID)
ON DELETE NO ACTION   ON UPDATE CASCADE
);

CREATE TABLE Has_AA(
A_ID char(7),
Admin_ID char(7),
privilege int,
recentACC bit,

FOREIGN KEY(A_ID) REFERENCES Accessibility(A_ID),
FOREIGN KEY(Admin_ID) REFERENCES Admin(Contact_ID)
ON DELETE NO ACTION   ON UPDATE CASCADE
);




ALTER TABLE Has_AA
ALTER COLUMN privilege nvarchar(15);

/************************** INSERT COMMANDS (ALTER|DROP|DELETE) **************************/
--Delete Rows
--Drop Columns
--Alter Data Types
--Add New Columns
--Remove PK Constraints

INSERT INTO Contact
VALUES('5692101', 'Jack', 'Sparow', '09122678423', 'https://picture.com/2692101', 'Only God Can Judge Me :D'),
	('5692102', 'Angelina', 'Joli', '09121878912', 'https://picture.com/2692102', 'No Code NO Life'),
	('5692103', 'Brad', 'Pit', '09135710018', 'https://picture.com/2692103', ''),
	('5692104', 'Dare', 'Pit', '09194571697', 'https://picture.com/2692104', ''),
	('5692105', 'Kim', 'Chon On', '09199647564', 'https://picture.com/2692105', 'Be ma Nemikhori, Heh ...'),
	('5692106', 'Amo', 'Porang', '09215544112', 'https://picture.com/2692106', '');
	--('5692105', 'Ali', 'Sadeghi', '09122112366', 'https://picture.com/2692105', ''),
	--('5692103', 'Emilia', 'Clark', '09379698521', 'https://picture.com/2692103', 'No Code NO Life');
INSERT INTO Contact
VALUES
('1569547','karamali','aghajani','09352148569','C:\Users\<1569547>\Downloads\Messanger','karam ali az tehran 20 sale '),
('1364758','AmirHossein','Lotfinejad','09125421368','C:\Users\<1364758>\Downloads\Messanger','AmirHossein az shiraz 12 sale '),
('5896547','Naser','Hosseini','09012547852','C:\Users\<5896547>\Downloads\Messanger','Naser az ghazvin 56 sale '),
('3654852','Karim','Khajezade','09986521341','C:\Users\<3654852>\Downloads\Messanger','Karim az esfahan 22 sale '),
('9814523','Mosa','rezaei','09415237895','C:\Users\<9814523>\Downloads\Messanger','Mosa az kordestan 14 sale '),
('3652148','Alirad','radnejad','09135431289','C:\Users\<3652148>\Downloads\Messanger','Alirad az bandar abbass 17 sale '),
('8512452','AliSam','Samannejad','09253369854','C:\Users\<8512452>\Downloads\Messanger','AliSam az tabriz 36 sale ');

INSERT INTO Users
VALUES('1569547'),('1364758'),('5896547'),('3654852'),('9814523'),('3652148'),('8512452');
INSERT INTO Users (Contact_ID)
VALUES
	('5692101'),
	('5692102'),
	('5692103'),
	('5692104'),
	('5692105'),
	('5692106');

INSERT INTO Contact_Of_User
VALUES
('1569547','1364758'),
('5896547','1364758'),
('3654852','1364758'),
('3652148','1364758'),
('1364758','8512452'),
('3652148','8512452'),
('3654852','8512452'),
('1569547','8512452'),
('8512452','9814523'),
('3654852','9814523'),
('1569547','9814523');
INSERT INTO Contact_Of_User
VALUES
	('5692102', '5692103'),
	('5692101', '5692103'),
	('5692101', '5692106'),
	('5692102', '5692106'),
	('5692103', '5692106'),
	('5692104', '5692106'),
	('5692105', '5692106'),
	('5692106', '5692106'),
	('5692104', '5692105'),
	('5692105', '5692104');

INSERT INTO Setting
VALUES
	('6692103', 'C:\Users\5692101\Downloads\Messanger', '00:02:00', 'Data', '254523', 60, '3636521478956'),
	('6692105', 'C:\Users\5692101\Downloads\Messanger', '00:03:00', 'Wifi', '932215', 60, '7847458745213'),
	('6692106', 'C:\Users\5692101\Downloads\Messanger', '00:02:00', 'Data', '251423', 20, '9874847558945'),
	('6692107', 'C:\Users\5692101\Downloads\Messanger', '00:03:00', 'Wifi', '984215', 54, '9874584521523'),
	('6692104', 'C:\Users\5692101\Downloads\Messanger', '00:04:00', 'Data', '631548', 36, '5485612548956'),
	('6692101', 'C:\Users\5692101\Downloads\Messanger', '00:01:00', 'Data', '908070', 60, '1245789123654'),
	('6692102', 'C:\Users\5692102\Downloads\Messanger', '00:00:45', 'Wifi', '963258', 60, '8523691236547');
INSERT INTO Setting (Set_ID, storage_Path, UnlockDou, usage, twoStep, sound, passcode)
VALUES
	('#Set120', 'C:\Users\5692101\Downloads\Messanger', '00:01:00', 'Data', '908070', 60, '1245789123654'),
	('#Set121', 'C:\Users\5692103\Downloads\Messanger', '00:01:00', 'Wifi', '784565', 100, '14441789123654'),
	('#Set122', 'C:\Users\5692104\Downloads\Messanger', '00:01:00', 'Data', '741454', 90, '578918912123654'),
	('#Set123', 'C:\Users\5692105\Downloads\Messanger', '00:00:45', 'Wifi', '852565', 65, '9889789123654'),
	('#Set124', 'C:\Users\5692106\Downloads\Messanger', '00:05:00', 'Wifi', '789134', 70, '78917891852369'),
	('#Set125', 'C:\Users\5692102\Downloads\Messanger', '00:00:45', 'Wifi', '112233', 1, '8523691236547');

INSERT INTO Session
VALUES
	('1111111','1569547','6692103','2020-08-25 13:10:02','6.45.24.1','SM-K2453'),
	('1111112','1364758','6692105','2020-03-01 13:10:02','6.45.24.1','SM-J1485'),
	('1111113','5896547','6692106','2020-02-23 13:10:02','6.45.24.1','SM-A3697'),
	('1111114','3654852','6692107','2020-11-12 13:10:02','6.45.24.1','SM-D2236'),
	('1111115','9814523','6692104','2020-01-14 13:10:02','6.45.24.1','SM-F8978'),
	('1111116','3652148','6692101','2020-05-07 13:10:02','6.45.24.1','SM-S1254'),
	('1111117','8512452','6692102','2020-06-09 13:10:02','6.45.24.1','SM-T3333');
INSERT INTO Session
VALUES
	('#Ses001', '5692101', '#Set120', GETDATE(), '192.168.43.1', 'Sony Z1'),
	('#Ses002', '5692102', '#Set121', GETDATE(), '192.168.12.1', 'LG G3 d855'),
	('#Ses003', '5692103', '#Set122', GETDATE(), '192.168.03.1', 'Xiaomi M9t'),
	('#Ses004', '5692104', '#Set123', GETDATE(), '192.168.13.1', 'Xiaomi Mi10 Pro'),
	('#Ses005', '5692105', '#Set124', GETDATE(), '192.168.22.1', 'Huawei Mate 10'),
	('#Ses006', '5692106', '#Set125', GETDATE(), '192.168.91.1', 'Xiaomi redmi note 8');


--ALTER TABLE Accessibility
--ALTER COLUMN photo nvarchar(MAX);
--ALTER TABLE Accessibility
--ALTER COLUMN privilege nvarchar(15);

INSERT INTO Accessibility
VALUES
	('1111111', '#change', 'Music jadid Mikhay? -> Bemon To channel', 'https://Messanger/joinchannel/l6AOabsCylFBlMzNk', 'Owner', 1),
	('2222222', '#change', '- United State OF TehranKaraj -', 'https://Messanger/joinchannel/k2ZOgfbTCylLQlTvHo', 'Owner', 0);

--Alter Table Accessibility
--Drop Column privilege;
--Alter Table Accessibility
--Drop Column recentAcc;
--Alter Table Has_AA
--Add privilege nvarchar(15)
--Alter Table Has_AA
--Add recentAcc bit

INSERT INTO Admin
VALUES('5692103'), ('5692102'), ('5692104');

INSERT INTO Call
VALUES
	('5692106', '5692104', GetDate(), 'Video'),
	('5692105', '5692104', GetDate(), 'Video'),
	('5692101', '5692102', GetDate(), 'Voice');

INSERT INTO Channel
VALUES('2000000', '1111111', '-_MUSIC_-');

ALTER TABLE Chat
ALTER COLUMN Archive bit;

INSERT INTO Chat
VALUES
	('1000000', 0),
	('2000000', 1);
Insert Into Chat
Values ('3000000', 0);



--Delete From Contact
--Drop Table Contact
--ALTER TABLE Contact
--DROP COLUMN ID;


INSERT INTO Contact_Of_User
VALUES
	('5692102', '5692103'),
	('5692101', '5692103'),
	('5692101', '5692106'),
	('5692102', '5692106'),
	('5692103', '5692106'),
	('5692104', '5692106'),
	('5692105', '5692106'),
	('5692106', '5692106'),
	('5692104', '5692105'),
	('5692105', '5692104');

INSERT INTO Groups
VALUES('3000000', '2222222', '|-TEHKAJ-|');

INSERT INTO Has_AA
VALUES
	('1111111', '5692103', 'Owner', '1'),
	('2222222', '5692104', 'Admin', '0'),
	('2222222', '5692102', 'Owner', '1');

Drop Table Has_AC
Drop Table Has_AG
--INSERT INTO Has_AC
--VALUES();
--INSERT INTO Has_AG
--VALUES();

ALTER TABLE Has_SM
DROP CONSTRAINT PK_Has_SM;

INSERT INTO Has_SM
VALUES
	('#C00003', '0MSG121'),
	('#C00003', '0MSG122');

INSERT INTO MSG (MSG_ID, Chat_ID, Sender_ID, txt, times, dates)
VALUES
	('0MSG125', '3000000', '5692106', 'Bache Karaj Bakht nmide', '11:00:42', '2021-04-04'),
	('0MSG126', '3000000', '5692104', 'Halal Olsoon', '10:31:11', '2021-04-04');
INSERT INTO MSG (MSG_ID, Chat_ID, Sender_ID, txt, times, dates)
VALUES
	('0MSG121', '1000000', '5692101', 'SUP?', '12:00:42', '2021-01-12'),
	('0MSG122', '1000000', '5692101', 'Are U Ok?', '12:01:01', '2021-01-12');
INSERT INTO MSG (MSG_ID, Chat_ID, Sender_ID, txt, times, dates, Picture)
VALUES
	('0MSG123', '1000000', '5692102', 'Nokaram dadash, badkha ina dari bego biyam randash konam', '12:01:40', '2021-01-12', 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwisgoon.com%2Fpin%2F14688551%2F&psig=AOvVaw2h7jbvhflBDn9unl0RIPvt&ust=1622986855838000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCMCrsLLPgPECFQAAAAAdAAAAABAP');
Insert INTO MSG (MSG_ID, Chat_ID, Sender_ID, txt, times, dates, music)
Values ('0MSG124', '2000000', '5692103', 'Hayedeh Hamishe Jadide!', '06:40:51', '2021-02-01', 'http://dl.sarimusic.net/1396/02/13/Old/4-01%20Shabeh%20Eshgh.mp3');

INSERT INTO PV
VALUES
	('1000000');

INSERT INTO Sender
VALUES
	('5692101'),
	('5692102'),
	('5692103');
INSERT INTO Sender
VALUES
	('5692104'),
	('5692106');

INSERT INTO Receiver
VALUES
	('5692106'),
	('5692105'),
	('5692104');
Insert INTO Receiver
Values
	('5692102'),
	('5692101');

Insert INTO Receives
Values
	('5692104', '0MSG125'),
	('5692106', '0MSG126'),
	('5692102', '0MSG121'),
	('5692102', '0MSG122'),
	('5692101', '0MSG123');

INSERT INTO Saved_Message
VALUES
	('#C00001', '5692101'),
	('#C00002', '5692102'),
	('#C00003', '5692103'),
	('#C00004', '5692104'),
	('#C00005', '5692105'),
	('#C00006', '5692106');

Alter Table Session
Drop Column timeStamps
Alter Table Session
Add timeStamps Datetime



--Delete From Setting





