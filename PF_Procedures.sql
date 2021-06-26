


/*Search some words in Messages*/
CREATE FUNCTION Search_in_Messages
(
@pharase nvarchar(10),
@id nvarchar(7)
)
RETURNS nvarchar(max) AS
BEGIN
return
(SELECT m.txt
FROM MSG as m, Receives as r, Contact as c
WHERE m.txt LIKE '%@pharase%' AND c.ID = @id AND (m.Sender_ID = c.ID OR (r.MSG_ID = m.MSG_ID AND r.Receiver_ID =c.id)))
END;

ALTER FUNCTION Search_in_Messages
(
@pharase nvarchar(10),
@id nvarchar(7)
)
RETURNS nvarchar(max) AS
BEGIN
return
(SELECT m.txt
FROM MSG as m
WHERE m.Chat_ID = @id AND m.txt LIKE '%' + @pharase + '%')
END;

SELECT dbo.Search_in_Messages('salam', '5648521') Searrch_Results;
SELECT dbo.Search_in_Messages('Nokaram dadash', '1000000') Searrch_Results;
----------------------------------------------------------------
CREATE OR ALTER FUNCTION BlockList
(
@user_id nvarchar(7)
)
RETURNS BIT AS
BEGIN
RETURN
(SELECT cu.IsBlock
 FROM Contact_Of_User as cu, Users as u
 WHERE u.Contact_ID = @user_id AND cu.Use_ID = u.Contact_ID AND cu.IsBlock = 1
 GROUP BY cu.Use_ID, cu.IsBlock)
END;

CREATE OR ALTER VIEW Setting_view AS

SELECT s.sound,
   s.usage,
   s.storage_Path, 
   s.UnlockDou,
   se.device,
   se.Use_ID,
   se.timeStamps,
   se.Country,
   se.IPs
   
FROM Setting as s JOIN Session as se ON se.Set_ID = s.Set_ID

CREATE OR ALTER PROCEDURE Setting_proc
(@id nvarchar(7))
AS
BEGIN
( SELECT dbo.BlockList(@id) Block_List );
( SELECT * 
  FROM Setting_view Informations
  WHERE Informations.Use_ID = @id);
END;

EXEC dbo.Setting_proc @id = '5692106'

----------------------------------------------
CREATE TRIGGER dbo.Sound_Alert
ON dbo.Setting
AFTER INSERT
AS
BEGIN
(SELECT *
 FROM Setting as s
 WHERE s.sound > 60)
 PRINT 'Loud noises can damage your hearing'
END;
------------------------------------------
CREATE TRIGGER dbo.Pass
ON dbo.Setting
AFTER INSERT, UPDATE
AS
BEGIN
(SELECT s.passcode
 FROM Setting as s
  WHERE s.passcode LIKE'%[0-9]%' AND
s.passcode LIKE'%[A-Z]%')
END;
-------------------------------------------
CREATE OR ALTER FUNCTION Compatriots
(@c nvarchar(30))
RETURNS Table
AS
RETURN
(SELECT TOP(3) c.F_Name + ' ' + c.L_Name as FULL_NAME
 FROM Contact as c JOIN Session as s ON c.ID = s.Use_ID,
  Contact_Of_User as cu
 WHERE s.Country = @c AND cu.Contact_ID = c.ID AND cu.IsBlock = 0
 GROUP BY c.F_Name, c.L_Name
 ORDER BY COUNT(cu.IsBlock) DESC);


CREATE OR ALTER VIEW Country_View AS
SELECT DISTINCT  c.F_Name,
 c.L_Name, c.ID,
 c.profile_pic,
 c.bio, s.Country,
 COUNT(cu.IsBlock) Stars
FROM Contact as c JOIN Session as s ON c.ID = s.Use_ID
 JOIN Contact_Of_User as cu ON cu.Contact_ID = c.ID 
WHERE cu.IsBlock = 0
GROUP BY c.F_Name, c.L_Name, c.ID, c.profile_pic, c.bio, s.Country


CREATE OR ALTER PROCEDURE Find_Compatriots
(@Country nvarchar(30))
AS
BEGIN
 (
/*(SELECT dbo.best(@Country) The_Best_Compatriot);*/
 SELECT *
 FROM Country_View v
 WHERE v.Country = @Country
 ORDER BY v.Stars DESC
END;


EXEC dbo.Find_Compatriots @Country = 'IR.Iran'



--------------------------------------------------------

CREATE OR ALTER PROCEDURE Commen_Groups
(@id1 nvarchar(7), 
@id2 nvarchar(7))
AS
BEGIN
SELECT g.G_name AS Commen_Grops
FROM Groups g JOIN Members m ON m.chat_id = g.Chat_ID
WHERE m.member_id = @id1 

INTERSECT 

SELECT g.G_name
FROM Groups g JOIN Members m ON m.chat_id = g.Chat_ID
WHERE m.member_id = @id2

END;

EXEC dbo.Commen_Groups @id1 = '5692101', @id2 = '5692102'
