Use Messanger

CREATE TABLE Users(
Contact_ID char(7) PRIMARY KEY
);

CREATE TABLE Accessibility(
A_ID char(7) PRIMARY KEY,
photo image,
Descriptions nvarchar(200),
inv_link nvarchar(MAX),
privilege int,
recentACC bit,
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
Archive nvarchar(MAX)
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

FOREIGN KEY(Contact_ID) REFERENCES Users(COntact_ID),
FOREIGN KEY(Use_ID) REFERENCES Contact(ID)
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
Contact_ID char(7) PRIMARY KEY,
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
timeStamps timeStamp,
IPs nvarchar(20),
device nvarchar(50),

FOREIGN KEY(Use_ID) REFERENCES Users(Contact_ID),
FOREIGN KEY(Set_ID) REFERENCES Setting(Set_ID)
ON DELETE NO ACTION   ON UPDATE CASCADE
);



CREATE TABLE Receives(
Receiver_ID char(7) PRIMARY KEY,
MSG_ID char(7),

FOREIGN KEY(Receiver_ID) REFERENCES Receiver(Contact_ID),
FOREIGN KEY(MSG_ID) REFERENCES MSG(MSG_ID)
ON DELETE NO ACTION   ON UPDATE CASCADE
);

------------HAS-------------

CREATE TABLE Has_AC(
Channel_ID char(7) PRIMARY KEY,
Admin_ID char(7),

FOREIGN KEY(Admin_ID) REFERENCES Admin(Contact_ID),
FOREIGN KEY(Channel_ID) REFERENCES Channel(Chat_ID)
ON DELETE NO ACTION   ON UPDATE CASCADE
);


CREATE TABLE Has_AG(
Group_ID char(7) PRIMARY KEY,
Admin_ID char(7),

FOREIGN KEY(Admin_ID) REFERENCES Admin(Contact_ID),
FOREIGN KEY(Group_ID) REFERENCES Groups(Chat_ID)
ON DELETE NO ACTION   ON UPDATE CASCADE
);

CREATE TABLE Has_SM(
Saved_ID char(7) PRIMARY KEY,
MSG_ID char(7)

FOREIGN KEY(Saved_ID) REFERENCES Saved_Message(Saved_ID),
FOREIGN KEY(MSG_ID) REFERENCES MSG(MSG_ID)
ON DELETE NO ACTION   ON UPDATE CASCADE
);

CREATE TABLE Has_AA(
A_ID char(7) PRIMARY KEY,
Admin_ID char(7),

FOREIGN KEY(A_ID) REFERENCES Accessibility(A_ID),
FOREIGN KEY(Admin_ID) REFERENCES Admin(Contact_ID)
ON DELETE NO ACTION   ON UPDATE CASCADE
);

ALTER TABLE Accessibility
ALTER COLUMN photo nvarchar(MAX);
ALTER TABLE Accessibility
ALTER COLUMN privilege nvarchar(30);


INSERT INTO Accessibility
VALUES
	('1111111', '#change', 'Music jadid Mikhay? -> Bemon To channel', 'https://Messanger/joinchannel/l6AOabsCylFBlMzNk', 'Owner', 1),
	('2222222', '#change', '- United State OF TehranKaraj -', 'https://Messanger/joinchannel/k2ZOgfbTCylLQlTvHo', 'Owner', 0);

INSERT INTO Admin
VALUES('5692103'), ('5692102');

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

Drop Table Contact
ALTER TABLE Contact
DROP COLUMN ID;
Delete From Contact

INSERT INTO Contact
VALUES('5692101', 'Jack', 'Sparow', '09122678423', 'https://picture.com/2692101', 'Only God Can Judge Me :D'),
	('5692102', 'Angelina', 'Joli', '09121878912', 'https://picture.com/2692102', 'No Code NO Life'),
	('5692103', 'Brad', 'Pit', '09135710018', 'https://picture.com/2692103', ''),
	('5692104', 'Dare', 'Pit', '09194571697', 'https://picture.com/2692104', ''),
	('5692105', 'Kim', 'Chon On', '09199647564', 'https://picture.com/2692105', 'Be ma Nemikhori, Heh ...'),
	('5692106', 'Amo', 'Porang', '09215544112', 'https://picture.com/2692106', '');
	--('5692105', 'Ali', 'Sadeghi', '09122112366', 'https://picture.com/2692105', ''),
	--('5692103', 'Emilia', 'Clark', '09379698521', 'https://picture.com/2692103', 'No Code NO Life');


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
VALUES('', '', '');

INSERT INTO Has_AA
VALUES();

INSERT INTO Has_AC
VALUES();

INSERT INTO Has_AG
VALUES();

INSERT INTO Has_SM
VALUES();

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

INSERT INTO Saved_Message
VALUES
	('#C00001', '5692101'),
	('#C00002', '5692102'),
	('#C00003', '5692103'),
	('#C00004', '5692104'),
	('#C00005', '5692105'),
	('#C00006', '5692106');

INSERT INTO Session
VALUES();

Delete From Setting

INSERT INTO Setting (Set_ID, storage_Path, UnlockDou, usage, twoStep, sound, passcode)
VALUES
	('5692101', 'C:\Users\5692101\Downloads\Messanger', '00:01:00', 'Data', '908070', 60, '1245789123654'),
	('5692103', 'C:\Users\5692103\Downloads\Messanger', '00:01:00', 'Wifi', '784565', 100, '14441789123654'),
	('5692104', 'C:\Users\5692104\Downloads\Messanger', '00:01:00', 'Data', '741454', 90, '578918912123654'),
	('5692105', 'C:\Users\5692105\Downloads\Messanger', '00:00:45', 'Wifi', '852565', 65, '9889789123654'),
	('5692106', 'C:\Users\5692106\Downloads\Messanger', '00:05:00', 'Wifi', '789134', 70, '78917891852369'),
	('5692102', 'C:\Users\5692102\Downloads\Messanger', '00:00:45', 'Wifi', '112233', 1, '8523691236547');


INSERT INTO Users (Contact_ID)
VALUES
	('5692101'),
	('5692102');

INSERT INTO Users (Contact_ID)
VALUES
	('5692103'),
	('5692104'),
	('5692105'),
	('5692106');


