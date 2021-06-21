USE Elmos_Messanger

--Update MSG
--Set Picture = 'https://cdn.tabnak.ir/files/fa/news/1399/5/22/1224927_596.jpg'
--Where Picture Is Not Null
/*========================================================== [PROCEDURES] ===================================================*/

--A View for users whenever they get into a chat (PV/Group/Channel) - Used For |Open_Chat_Proc| Procedure
Create Or Alter View Message_Details
With Schemabinding
As
Select
	c.F_Name + ' ' + c.L_Name As Full_Name,
	c.bio, c.ID As ContactID, c.profile_pic,
	c.phone,
	m.txt, m.files, m.music, m.video, m.Picture, m.locations, m.times, m.dates
From 
	dbo.MSG As m Inner Join dbo.Contact As c 
	On c.ID = m.Sender_ID



--For Finding all the chats in a specific PV / Group / Channel
Create Or Alter Function Bring_Chat(@chatID Char(7))
Returns Table
As
Return 
	--view
	Select *
	From 
	(Select MD.*, ROW_NUMBER() OVER(PARTITION BY m.Sender_ID ORDER BY m.Sender_ID DESC) As rn
	From MSG As m, dbo.Message_Details As MD
	Where 
		m.Chat_ID = @chatID And
		MD.ContactID = m.Sender_ID) As res
	Where rn = 1;



-- For Finding a group of members with their details
Create Or Alter Function Members_Detail(@chatID Char(7))
Returns Table
As
Return 
	Select *
	From Members As m
	Where m.chat_id = @chatID;



CREATE OR ALTER PROCEDURE Open_Chat_Proc
	@ChatID CHAR(7)
AS
BEGIN
	Select *
	From Bring_Chat(@ChatID) b
	Order By b.dates, b.times Asc

	Select *
	From Members As m
	Where m.chat_id = @ChatID
END;

--Drop Procedure Group_Channel_P

EXEC Open_Chat_Proc @ChatID = '1000000';
EXEC Open_Chat_Proc @ChatID = '2000000';

