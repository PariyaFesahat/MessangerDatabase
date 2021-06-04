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
Use_ID char(7),
F_Name nvarchar(50),
L_Name nvarchar(50),
phone char(11),
profile_pic image,
bio nvarchar(150),

fOREIGN KEY(USE_ID) REFERENCES Users(CONTACT_ID)
ON DELETE NO ACTION  ON UPDATE CASCADE
);

CREATE TABLE Contact_Of_User(
Contact_ID char(7) PRIMARY KEY,
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


