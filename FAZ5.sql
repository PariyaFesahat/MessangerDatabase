USE Elmos_Messanger


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