USE Elmos_Messanger


--find number of any type of message in a chat id 


CREATE VIEW MESSAGE_TYPES_COUNT
AS
SELECT M.Chat_ID, COUNT(M.files) AS [FILES],COUNT(M.music) AS [MUSIC],COUNT(M.video) AS [VIDEO],COUNT(M.Picture) AS [IMAGES]
FROM MSG M 
GROUP BY M.Chat_ID





CREATE FUNCTION MESSAGE_TYPES_COUNT_FRO_CHAT_ID(@CHAT_ID CHAR(7))
RETURNS TABLE 
AS
RETURN
	SELECT * FROM MESSAGE_TYPES_COUNT
	WHERE Chat_ID=@CHAT_ID;


	SELECT * FROM MSG

SELECT * FROM MESSAGE_TYPES_COUNT_FRO_CHAT_ID('1000000')
--============================================================================================================================

--add a contact for a user

CREATE PROCEDURE dbo.ADD_CONTACT_FOR_USER @CONTACT_ID char(7) =null ,@USER_ID char(7) = null
AS
SELECT C.Contact_ID
FROM Contact_Of_User C
WHERE C.Use_ID=@USER_ID


INSERT INTO Contact_Of_User
VALUES(@CONTACT_ID,@USER_ID,0);

SELECT C.Contact_ID
FROM Contact_Of_User C
WHERE C.Use_ID=@USER_ID




EXEC ADD_CONTACT_FOR_USER @CONTACT_ID = '8512452',@USER_ID='1364758'



--============================================================================================================================

--trigger for not allow for delete or update after 2 days for messages.


CREATE OR ALTER TRIGGER FORBID_DELETE_MESSAGE
ON dbo.MSG
FOR DELETE,UPDATE
AS
IF EXISTS (SELECT * FROM DELETED D WHERE DATEDIFF(day,d.dates, cast(GETDATE() as date))>2)
BEGIN
    RAISERROR('You can''t delete or edit your message after 2 days!!', 16, 1);
	ROLLBACK
END;

--TEST

select * from MSG m where m.MSG_ID='3336699'


DELETE FROM MSG WHERE MSG_ID='3336699'


UPDATE MSG
SET txt='ASD'
WHERE MSG_ID='3336699'

INSERT INTO MSG
VALUES
('9541387','5648521','1364758','salam khobi?','14:06:10','2021-06-23',NULL,NULL,NULL,NULL,NULL);
--9541387
--3336699

--============================================================================================================================