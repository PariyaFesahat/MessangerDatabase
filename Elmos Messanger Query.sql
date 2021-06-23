
/************************** USE SCHEMA MESSANGER **************************/
--CREATE DATABASE Elmos_Messanger
USE Elmos_Messanger
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

ALTER TABLE Accessibility
ADD CHECK (photo like 'https://%')

ALTER TABLE Accessibility
ADD CHECK (LEN(inv_link) != 0)

CREATE TABLE Setting(
Set_ID char(7) PRIMARY KEY,
storage_Path nvarchar(MAX),
UnlockDou TiMe,
usage char(4)
	CHECK(usage = 'Wifi' OR usage = 'Data'),
twoStep nvarchar(MAX)
	CHECK(LEN(twoStep) >= 4),
sound int,
passcode nvarchar(25)
	CHECK(LEN(passcode) >= 12),
);
ALTER TABLE setting
ADD CHECK (storage_Path Like 'C:\Users\%\Downloads\Messanger')

ALTER TABLE Setting
ADD CHECK(LEN(storage_Path) != 0)

--Alter Table Setting
--Drop Constraint CK__Setting__sound__2A4B4B5E
Alter Table Setting
Add Constraint CK__Setting__sound__SoundRange Check (sound >= 0 AND sound <= 100)
ALTER TABLE setting
ADD CHECK (storage_Path Like 'C:\Users\%\Downloads\Messanger');

ALTER TABLE Setting
ADD CHECK(LEN(storage_Path) != 0);

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
profile_pic nvarchar(150),
bio nvarchar(150),
);


ALTER TABLE Contact
ADD CHECK(phone LIKE '09%');

CREATE TABLE Contact_Of_User(
Contact_ID char(7),
Use_ID char(7),
IsBlock bit Default 0,

FOREIGN KEY(Contact_ID) REFERENCES Contact(ID),
FOREIGN KEY(Use_ID) REFERENCES Users(COntact_ID)
ON DELETE NO ACTION  ON UPDATE CASCADE
);

ALTER TABLE Contact_Of_User
ADD CHECK (Contact_ID != Use_ID)

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
locations nvarchar(50),
Picture image,
music nvarchar(200),
files nvarchar(200),
video nvarchar(200)

FOREIGN KEY(Sender_ID) REFERENCES Sender(Contact_ID),
FOREIGN KEY(Chat_ID) REFERENCES Chat(Chat_ID)
ON DELETE NO ACTION   ON UPDATE CASCADE
);

--CREATE FUNCTION GETReceiver(@MSG_ID CHAR(7))  
-- RETURNS CHAR(7)  
-- AS  
--BEGIN  
--    RETURN (SELECT Receiver_ID  FROM Receives WHERE MSG_ID=@MSG_ID)  
--END 


CREATE TABLE Channel(
Chat_ID char(7) PRIMARY KEY,
A_ID char(7),
Ch_name nvarchar(50)

FOREIGN KEY(Chat_ID) REFERENCES Chat(Chat_ID),
FOREIGN KEY(A_ID) REFERENCES Accessibility(A_ID)
ON DELETE NO ACTION   ON UPDATE CASCADE
);

ALTER TABLE Channel
ADD CHECK(LEN(ch_name) != 0)

Alter Table Channel
Add Constraint NN__Channel__Ch_name__NotNULL
Check (Channel.Ch_name Is Not Null);


CREATE TABLE Groups(
Chat_ID char(7) PRIMARY KEY,
A_ID char(7),
G_name nvarchar(50)

FOREIGN KEY(Chat_ID) REFERENCES Chat(Chat_ID),
FOREIGN KEY(A_ID) REFERENCES Accessibility(A_ID)
ON DELETE NO ACTION   ON UPDATE CASCADE
);
ALTER TABLE Groups
ADD CHECK(LEN(G_Name) != 0)

Alter Table Groups
Add Constraint NN__Groups__G_name__NotNULL
Check (Groups.G_name Is Not Null);

CREATE TABLE Call(
Contact_ID char(7),
Use_ID char(7),
call_time DateTime,
call_type nvarchar(20),

fOREIGN KEY(USE_ID) REFERENCES Users(CONTACT_ID),
fOREIGN KEY(Contact_ID) REFERENCES Contact(ID)
ON DELETE NO ACTION   ON UPDATE CASCADE
);


ALTER TABLE Call
ADD CHECK(call_type = 'Video' OR call_Type = 'Voice')

Alter Table Call
Add Constraint NN__Call__Contact_ID__NotNULL
Check (Call.Contact_ID Is Not Null);

Alter Table Call
Add Constraint NN__Call__Use_ID__NotNULL
Check (Call.Use_ID Is Not Null);

Alter Table Call
Add Constraint NN__Call__call_type__NotNULL
Check (Call.call_type Is Not Null);

Alter Table Call
Add Constraint NN__Call__call_type__Choices
Check (Call.call_type = 'Video' Or Call.call_type = 'Voice');

ALTER TABLE Call
ADD CHECK(Contact_ID!=Use_ID)


CREATE TABLE Session(
Session_ID char(7) PRIMARY KEY,
Use_ID char(7),
Set_ID char(7),
timeStamps datetime,
IPs nvarchar(20),
device nvarchar(50),
Country nvarchar(30),

FOREIGN KEY(Use_ID) REFERENCES Users(Contact_ID),
FOREIGN KEY(Set_ID) REFERENCES Setting(Set_ID)
ON DELETE NO ACTION   ON UPDATE CASCADE
);

ALTER TABLE Session
ADD CHECK(Country != 'USA' AND Country!='Israeil')

ALTER TABLE Session
ADD CHECK(IPs LIKE '%.%.%.%')


CREATE TABLE Receives(
Receiver_ID char(7),
MSG_ID char(7),

FOREIGN KEY(Receiver_ID) REFERENCES Receiver(Contact_ID),
FOREIGN KEY(MSG_ID) REFERENCES MSG(MSG_ID)
ON DELETE NO ACTION   ON UPDATE CASCADE
);



CREATE TABLE Members(
chat_id char(7),
member_id char(7),


FOREIGN KEY(chat_id) REFERENCES Chat(Chat_id),
FOREIGN KEY(member_id) REFERENCES Contact(ID)
ON DELETE NO ACTION   ON UPDATE CASCADE
);

--ALTER TABLE MSG
--ADD CHECK(Sender_ID!= [dbo].GETReceiver(MSG_ID))

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

/************************** ALTER|DROP|ADD|DELETE COMMANDS **************************/
/*** 
+ Delete Rows
+ Drop Columns
+ Alter Data Types
+ Add New Columns
+ Remove PK Constraints***/

--ALTER TABLE Accessibility
--ALTER COLUMN photo nvarchar(MAX);
--ALTER TABLE Accessibility
--ALTER COLUMN privilege nvarchar(15);
--Alter Table Accessibility
--Drop Column privilege;
--Alter Table Accessibility
--Drop Column recentAcc;
--Alter Table Has_AA
--Add privilege nvarchar(15)
--Alter Table Has_AA
--Add recentAcc bit
--ALTER TABLE Chat
--ALTER COLUMN Archive bit;
--Delete From Contact
--Drop Table Contact
--ALTER TABLE Contact
--DROP COLUMN ID;
--Drop Table Has_AC
--Drop Table Has_AG
--INSERT INTO Has_AC
--VALUES();
--INSERT INTO Has_AG
--VALUES();
--ALTER TABLE Has_SM
--DROP CONSTRAINT PK_Has_SM;
--Alter Table Session
--Drop Column timeStamps
--Alter Table Session
--Add timeStamps Datetime
--Delete From Setting

/************************** INSERT COMMANDS **************************/
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
INSERT INTO Contact VALUES
('0193003','Tarane','Hemmati','09199125808','@taranePic','بی تو مهتاب شبی باز از آن کوچه گذشتم...'),
('0167256','Sohraab','KHP','09352619104','@sohraabPic','Mashtiye, Mese Khoete'),
('3810238','Bardiya','Poorsina','09109041672','@ProfilePic','Master of my sea'),
('0138492','Amin','Sabour','09122381902','@aminPic','dr.Sabour'),
('0187236','Omman','Sajjadi','09121829201','@flowerPic','Civil Engineer');

Update Contact
Set profile_pic = 'https://picture.com/' + Contact.ID
Where profile_pic Like '@%' or profile_pic Like 'C%';


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
INSERT INTO Users VALUES
('9080331'),
('9021546'),
('6575231'),
('0923671'),
('0961247');

INSERT INTO Contact_Of_User (Contact_ID, Use_ID)
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
INSERT INTO Contact_Of_User (Contact_ID, Use_ID)
VALUES
	('5692102', '5692103'),
	('5692101', '5692103'),
	('5692101', '5692106'),
	('5692102', '5692106'),
	('5692103', '5692106'),
	('5692104', '5692106'),
	('5692105', '5692106'),
	('5692104', '5692105'),
	('5692105', '5692104');
INSERT INTO Contact_Of_User (Contact_ID, Use_ID)
Values
	('0193003','9080331'),
	('0167256','6575231'),
	('3810238','9021546'),
	('0138492','0923671'),
	('0187236','0961247');
Delete From Contact_Of_User
Where Contact_Of_User.Contact_ID = Contact_Of_User.Use_ID

--ALTER TABLE Contact_Of_User
--ADD IsBlock bit Not Null 
--CONSTRAINT IsBlockDefault DEFAULT 0

Update Contact_Of_User
Set IsBlock = 1
Where Contact_Of_User.Contact_ID = '5692104'

Update Contact_Of_User
Set IsBlock = 0
Where Contact_Of_User.Contact_ID = '5692104'

Update Contact_Of_User
Set IsBlock = 1
Where Contact_Of_User.Contact_ID = '5692105'

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
INSERT INTO Setting VALUES 
('0001116','C:\Users\0001116\Downloads\Messanger','00:01:00','Wifi','902134',90,'09po8123rt34'),
('0912309','C:\Users\09123091\Downloads\Messanger','00:30:00','Data','3390122',50,'pass90812064131');

Update Setting
Set Setting.sound = 0
Where Setting.sound = 1

INSERT INTO Session (Session_ID, Use_ID, Set_ID, timeStamps, IPs, device)
VALUES
	('1111111','1569547','6692103','2020-08-25 13:10:02','6.45.24.1','SM-K2453'),
	('1111112','1364758','6692105','2020-03-01 13:10:02','6.45.24.1','SM-J1485'),
	('1111113','5896547','6692106','2020-02-23 13:10:02','6.45.24.1','SM-A3697'),
	('1111114','3654852','6692107','2020-11-12 13:10:02','6.45.24.1','SM-D2236'),
	('1111115','9814523','6692104','2020-01-14 13:10:02','6.45.24.1','SM-F8978'),
	('1111116','3652148','6692101','2020-05-07 13:10:02','6.45.24.1','SM-S1254'),
	('1111117','8512452','6692102','2020-06-09 13:10:02','6.45.24.1','SM-T3333');
INSERT INTO Session (Session_ID, Use_ID, Set_ID, timeStamps, IPs, device)
VALUES
	('#Ses001', '5692101', '#Set120', GETDATE(), '192.168.43.1', 'Sony Z1'),
	('#Ses002', '5692102', '#Set121', GETDATE(), '192.168.12.1', 'LG G3 d855'),
	('#Ses003', '5692103', '#Set122', GETDATE(), '192.168.03.1', 'Xiaomi M9t'),
	('#Ses004', '5692104', '#Set123', GETDATE(), '192.168.13.1', 'Xiaomi Mi10 Pro'),
	('#Ses005', '5692105', '#Set124', GETDATE(), '192.168.22.1', 'Huawei Mate 10'),
	('#Ses006', '5692106', '#Set125', GETDATE(), '192.168.91.1', 'Xiaomi redmi note 8');

INSERT INTO Session (Session_ID, Use_ID, Set_ID, timeStamps, IPs, device)
VAlUES
	('1629016','9021546','0001116','2014-09-11 02:30:51','253.245.183.167','Iphon5,iOS,14.4'),
	('7190638','9080331','0912309','2017-08-21 05:41:33','210.133.240.125','Samsung,A12,10.2');
--Alter Table Session
--Add Country nvarchar(20);

Update Session
Set Country = 'IR.Iran';

INSERT INTO Session
VALUES
	('#Ses007', '5692101', '#Set120', GETDATE(), '1.44.255.255', 'Desktop Windows 10', 'Australi');

INSERT INTO Admin
VALUES('1569547'),('5896547'),('9814523'),('8512452');
INSERT INTO Admin
VALUES('5692103'), ('5692102'), ('5692104');
INSERT INTO Admin VALUES
('0193003'),
('0167256'),
('0138492'),
('3810238'),
('0187236');

INSERT INTO Accessibility
VALUES
('9885412','https://picture.com/Dota2BestPlayers','Best Iran Dota2 Players Replays','https://Messanger/joinchannel/l6AOabsCylFBlMKFSA'),
('3256489','https://picture.com/ICSBestPlayers','Best Iran CS Players Replays','https://Messanger/joinchannel/S5D8G4G5DGH2H5D5G'),
('1145699','https://picture.com/GP_MathIkani','Group Riyazi 98 Ostad Ikani','https://Messanger/joinchannel/SG8H4DN2V5H6FF'),
('2848569','https://picture.com/FreelancersHangout','Freelancers Hangout','https://Messanger/joinchannel/AA7S8DGGGD8FAS6D');
INSERT INTO Accessibility
VALUES
	('1111111', 'https://picture.com/gpMusic', 'Music jadid Mikhay? -> Bemon To channel', 'https://Messanger/joinchannel/l6AOabsCylFBlMzNk'),
	('2222222', 'https://picture.com/USTK', '- United State OF TehranKaraj -', 'https://Messanger/joinchannel/k2ZOgfbTCylLQlTvHo');
INSERT INTO Accessibility VALUES 
('9230152',null,'dorehami khoban','https://messanger.join/omjdrt'),
('7316092','https://picture.com/LatinMusic','موزیکای لاتین خفن داریم','https://messanger.join/opvty7S8DGGG'),
('9120561','https://picture.com/UniqueFathers','کانال پدران نمونه','https://messanger.join/kjblyggfbTCy'),
('4123893',null,'مقاومت مصالح استاد سجادی','https://messanger.join/gfbTCykjmdrdf');

INSERT INTO Chat
VALUES
('5648521',1),
('1243658',0),
('7841256',0),
('9856147',1),
('2549653',1),
('5556987',0),
('2245887',1);
INSERT INTO Chat
VALUES
	('1000000', 0),
	('2000000', 1),
	('3000000', 0);
INSERT INTO Chat VALUES
('8821547', 1),
('9021376', 0),
('1208195', 1),
('9931673', 1),
('6429810', 0),
('9023156', 0);

INSERT INTO Channel
VALUES
('9856147','9885412','Iran Dota'),
('2549653','3256489','CS baz');
INSERT INTO Channel
VALUES('2000000', '1111111', '-_MUSIC_-');
INSERT INTO Channel VALUES
('1208195','7316092','Latinooo'),
('9931673','9120561','Tarbiyate farzand');


INSERT INTO Groups
VALUES
('5556987','1145699','Math-98'),
('2245887','2848569','FreeLancer Guys');
INSERT INTO Groups
VALUES('3000000', '2222222', '|-TEHKAJ-|');
INSERT INTO Groups VALUES
('6429810','9230152','3 dadash'),
('9023156','4123893','درس مقاومت مصالح');


INSERT INTO PV
VALUES
('5648521'),
('1243658'),
('7841256');
INSERT INTO PV
VALUES
	('1000000');
INSERT INTO PV VALUES 
('8821547'),
('9021376');

INSERT INTO Saved_Message
VALUES
('1111222','1569547'),('2222111','3652148');
INSERT INTO Saved_Message
VALUES
	('#C00001', '5692101'),
	('#C00002', '5692102'),
	('#C00003', '5692103'),
	('#C00004', '5692104'),
	('#C00005', '5692105'),
	('#C00006', '5692106');
INSERT INTO Saved_Message VALUES
('4231768','9080331'),
('3467110','6575231');

INSERT INTO Call
VALUES
('1569547','5896547','2021-11-05 16:10:02','Voice'),
('9814523','3652148','2020-05-15 00:23:15','Video');
INSERT INTO Call
VALUES
	('5692106', '5692104', GetDate(), 'Video'),
	('5692105', '5692104', GetDate(), 'Video'),
	('5692101', '5692102', GetDate(), 'Voice');
	INSERT INTO Call VALUES
('3810238','9021546','2019-04-11 10:17:43','video'),
('0193003','9080331','2019-04-11 10:17:43','video');


INSERT INTO Has_AA
VALUES('9885412','1569547','Owner',1),('3256489','5896547','Owner',1),('1145699','9814523','Owner',1),('2848569','8512452','Owner',0);
INSERT INTO Has_AA
VALUES
	('1111111', '5692103', 'Owner', 1),
	('2222222', '5692104', 'Admin', 0),
	('2222222', '5692102', 'Owner', 1);
INSERT INTO Has_AA VALUES
('9230152','3810238','admin',1),
('7316092','0167256','Owner',0),
('9120561','0138492','Owner',1),
('4123893','0187236','Owner',0);

INSERT INTO Sender
VALUES
('1364758'),('1569547'),('5896547'),('9814523'),('8512452');
INSERT INTO Sender
VALUES
	('5692101'),
	('5692102'),
	('5692103'),
	('5692104'),
	('5692106');
INSERT INTO Sender VALUES
('0193003'),
('0167256'),
('0187236');

INSERT INTO MSG
VALUES
('1145765','5648521','1364758','salam khobi?','14:06:10','2021-04-06',NULL,NULL,NULL,NULL,NULL),
('9986765','9856147','1569547','best Axe player OMG!','15:26:30','2021-05-20',NULL,NULL,NULL,NULL,'C:\video\<9856147>\9986765.mp4'),
('3336699','2549653','5896547','Head shot From BASE!','12:56:20','2021-05-18',NULL,NULL,NULL,NULL,'C:\video\<2549653>\3336699.mp4'),
('1454741','5556987','9814523','AGHA IN SOALI KASI BALADE ?','01:22:00','2021-05-15',NULL,'C:\IMAGE\<5556987>\1454741.png',NULL,NULL,NULL),
('5215215','2245887','8512452','source code of reddot project.','19:22:30','2021-05-12',NULL,NULL,NULL,'C:\FILES\<2245887>\5215215.png',NULL);
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
INSERT INTO MSG VALUES
('9080123','8821547','0193003','Bardiya jan tavalodet mobarak','09:11:31','2020-11-23',null,null,null,null,'@hbdvideo'),
('9080321','9021376','0167256','haji dmt grm','11:50:56','2020-10-20',null,null,null,'@gifFile',null),
('9080451','9023156','0187236','امتحان شنبه ساعت 8 صبح برگزار میشود','03:40:13','2021-11-24',null,null,null,null,null);


INSERT INTO Receiver
VALUES('1569547');
INSERT INTO Receiver
VALUES
	('5692106'),
	('5692105'),
	('5692104'),
	('5692102'),
	('5692101');
INSERT INTO Receiver VALUES
('0193003'),
('0167256'),
('3810238');


INSERT INTO Receives
VALUES('1569547','1145765');
Insert INTO Receives
Values
	('5692104', '0MSG125'),
	('5692106', '0MSG126'),
	('5692102', '0MSG121'),
	('5692102', '0MSG122'),
	('5692101', '0MSG123');
INSERT INTO Receives VALUES
('3810238', '9080321'),
('3810238','9080123');

INSERT INTO Has_SM
VALUES
('1111222','1145765'),('2222111','9986765');
INSERT INTO Has_SM
VALUES
	('#C00003', '0MSG121'),
	('#C00003', '0MSG122');
INSERT INTO Has_SM VALUES
('4231768','9080123'),
('3467110','9080321');


INSERT INTO Members
VALUES
('5556987','5692101'),
('5556987','5692102'),
('5556987','5692104'),
('5556987','0193003'),
('5556987','3810238'),
('5556987','0187236'),
('5556987','5692105'),
('2245887','5692101'),
('2245887','5692102'),
('2245887','5692104'),
('2245887','3810238'),
('2245887','0187236'),
('2245887','3652148'),
('2245887','5692106'),
('3000000','5692101'),
('3000000','5692102'),
('3000000','3652148'),
('3000000','1569547'),
('3000000','5692105'),
('3000000','0167256'),
('6429810','5692101'),
('6429810','3652148'),
('6429810','0167256'),
('6429810','5692106'),
('6429810','0187236'),
('6429810','5692103'),
('6429810','1569547'),
('9023156','3652148'),
('9023156','0167256'),
('9023156','0167256'),
('9023156','5692101'),
('9023156','1569547'),
('9856147','0193003'),
('9856147','0187236'),
('9856147','5692102'),
('9856147','5692103'),
('9856147','5692101'),
('9856147','3652148'),
('9856147','5692106'),
('2549653','0193003'),
('2549653','5692102'),
('2549653','5692101'),
('2549653','0187236'),
('2000000','5692101'),
('2000000','3810238'),
('2000000','3652148'),
('2000000','5692103'),
('2000000','0187236'),
('1208195','1569547'),
('1208195','5692102'),
('1208195','5692106'),
('1208195','3652148'),
('1208195','5692101'),
('9931673','5692105'),
('9931673','3652148'),
('9931673','0167256'),
('9931673','5692101'),
('9931673','1569547'),
('9931673','0187236'),
('9931673','5692102');

SET ROWCOUNT 1
DELETE FROM Members 
WHERE chat_id =(SELECT M.chat_id
				FROM Members M
				GROUP BY M.chat_id,M.member_id
				HAVING COUNT(*)>=2
			  )
			  AND 
			  member_id=(SELECT M.member_id
				FROM Members M
				GROUP BY M.chat_id,M.member_id
				HAVING COUNT(*)>=2)
SET ROWCOUNT 0

INSERT INTO Contact(ID , F_Name, L_Name, phone, profile_pic, bio)
VALUES
('6565656','HOMAYOON','SHAJARIAN','09352148569','https://picture.com/6565656','HOMAYOON SHAJARIAN az tehran 20 sale '),
('5656565','REZA','Lotfinejad','09125421368','https://picture.com/5656565','REZA az shiraz 12 sale '),
('8585858','KARIM','Hosseini','09012547852','https://picture.com/858585','KARIM az ghazvin 56 sale ');


INSERT INTO Users VALUES
('6565656'),
('5656565'),
('8585858');

INSERT INTO Setting
VALUES
  ('1212545', 'C:\Users\5692101\Downloads\Messanger', '00:02:00', 'Data', '658956', 60, '3636521478956'),
  ('1365858', 'C:\Users\5692101\Downloads\Messanger', '00:03:00', 'Wifi', '658956', 60, '7847458745213'),
  ('1659856', 'C:\Users\5692101\Downloads\Messanger', '00:02:00', 'Data', '963258', 20, '9874847558945');




INSERT INTO Session (Session_ID, Use_ID, Set_ID, timeStamps, IPs, device)
VALUES
  ('4854784','6565656','1212545','2020-08-25 13:10:02','7.45.24.1','SM-K2453'),
  ('4236989','5656565','1365858','2020-03-01 13:10:02','7.45.24.1','SM-J1485'),
  ('2547913','8585858','1659856','2020-02-23 13:10:02','6.45.24.1','SM-A3697');
