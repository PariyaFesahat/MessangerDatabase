USE Elmos_Messanger
/*************************************** SELECT COMMANDS ******************************************/

										--Iliya MIrzaei--

-- (BAD USER) Select All The Users Who Attempted To Login From Diffrent Countries in Last 24H.
Select c.F_Name, c.L_Name, s.Use_ID, s.Country as Login_Country
From Session as s, Users as u Join Contact as c On u.Contact_ID = c.ID
Where s.Use_ID = u.Contact_ID And
	s.Use_ID In ( Select s1.Use_ID
					From Session s1, Session s2
					Where 
						s1.timeStamps >= DATEADD(day, -1, GETDATE())
						And s1.Country != s2.Country
					Group By s1.Use_ID
					Having Count(s1.Use_ID) > 1);

--Contact List of Each User
Select cu.Use_ID, cu.Contact_ID
From Contact_Of_User as cu
where cu.Use_ID = '5692106';


--Mutual Contatc of Users
Select cu1.Use_ID
From Contact_Of_User as cu1, Contact_Of_User as cu2
Where 
	cu1.Contact_ID = cu2.Use_ID And 
	cu2.Contact_ID = cu1.Use_ID
Order By cu1.Use_ID;


--Common Groups and Channels Between Mutual Contacts
Select Distinct m1.chat_id, cu1.Use_ID as Member_1, cu2.Use_ID as Member_2
From 
	Contact_Of_User as cu1, Contact_Of_User as cu2,
	Members as m1, PV as pv
Where 
	cu1.Contact_ID = cu2.Use_ID And 
	cu2.Contact_ID = cu1.Use_ID And
	m1.chat_id Not In (	Select pv.Chat_ID)
	And
	cu1.Use_ID in (	Select m.member_id
						From Members as m
						Where m.chat_id = m1.chat_id)
	And
	cu2.Use_ID in (	Select m.member_id
						From Members as m
						Where m.chat_id = m1.chat_id)
Order By Member_1, Member_2 Asc;


--Mutual Users Between Diffrenet Groups
Select Distinct m1.chat_id, m2.chat_id, m1.member_id as Member_1, m2.member_id as Member_2
From 
	Members as m1, Members as m2, PV as pv
Where 
	m1.chat_id != m2.chat_id And
	m1.chat_id Not In (	Select pv.Chat_ID)
	And
	m2.chat_id Not In (	Select pv.Chat_ID)
	And
	m1.member_id in (	Select m.member_id
						From Members as m
						Where m.chat_id = m2.chat_id)
	And
	m2.member_id in (	Select m.member_id
						From Members as m
						Where m.chat_id = m1.chat_id);

-- (BAD USER) Users Who Have Been Blocked More Than The Average Blocks Between All Users.
Select *
From Contact As c
Where c.ID In (	Select Distinct cu.Contact_ID
				From Contact_Of_User cu
				Where  
						(Select Count(*)
						From Contact_Of_User As cu2
						Where cu2.IsBlock = 1)
						/
						(Select Count(*)
						From Contact_Of_User As cu1)
						<
						(	Select Top 1 Count(cu1.IsBlock) As NumberOfBlocks
							From Contact_Of_User cu1
							Where cu1.Contact_ID = cu.Contact_ID
							Group By cu1.Contact_ID, cu1.IsBlock Having cu1.IsBlock = 1
							Order By NumberOfBlocks Desc))


--The Country With The Most Percentage of Muting -> Country With No Asab!
Select 
	Ses.Country, (Count(Ses.Country) * 100 / (Select Count(*) From Setting As s1)) As Percentage
From 
	Setting As S Inner Join Session As Ses 
	On S.Set_ID = Ses.Set_ID
Group By  S.sound, Ses.Country
Having S.sound = 0;


--Countries With The Most Chatting
Select Country
From Contact as c, Session As  ses
Where ses.Use_ID in (	Select m1.Sender_ID
						From 
							Session As s Join Users As u
							On s.Use_ID = u.Contact_ID,
							MSG As m1
						Where 
							u.Contact_ID = m1.Sender_ID
						Group By m1.Sender_ID
						Having Count(m1.Sender_ID) = (	Select Top 1 Count(Sender_ID) As MostNum
										From 
											Session As s Join Users As u
											On s.Use_ID = u.Contact_ID,
											MSG As m
										Where 
											u.Contact_ID = m.Sender_ID
										Group By Sender_ID
										Order By MostNum Desc))
	And c.ID = ses.Use_ID;



									--Pariya Fesahat--
									
(SELECT (COUNT(set_ID) * 100/ (SELECT COUNt(*) FROM Setting)) as Wifi_Users
FROM setting
WHERE usage = 'Wifi');

SELECT DISTINCT s.sound, cu.Contact_ID
FROM Members as m, Contact_Of_User as cu, Users as u, Session as se, setting as s
WHERE m.chat_id = '2000000' AND cu.Contact_ID = m.member_id AND u.Contact_ID = cu.Use_ID AND 
se.Use_ID = u.Contact_ID AND s.Set_ID = se.Set_ID;

SELECT Set_Id, s.twoStep
FROM Setting as s
WHERE 13 < LEN(s.passcode);

SELECT top(3) c.Ch_name, a.inv_link, COUNT(m.member_id) as members
FROM Members as m , Channel as c, Accessibility as a
WHERE c.Chat_ID = m.chat_id AND a.A_ID = c.A_ID
GROUP BY c.Ch_name,a.inv_link,m.chat_id
ORDER BY COUNT(m.member_id) desc;

SELECT a.Descriptions, c.bio, c.F_Name, c.L_Name
FROM Contact as c, Accessibility as a, HAS_AA as h , admin as ad
WHERE h.A_ID = a.A_ID AND ad.Contact_ID = h.Admin_ID AND c.ID = ad.Contact_ID;



										--AmirMahdi Shadman--
--query1
SELECT C2.*
FROM Contact C2 ,MSG M2
WHERE C2.ID=M2.Sender_ID AND 3 > (	SELECT COUNT(M.Chat_ID)
							  		FROM Contact C,Admin A,Has_AA HA,Channel CH,MSG M
							  		WHERE 
										C.ID=A.Contact_ID AND 
										HA.Admin_ID=Contact_ID AND 
										CH.A_ID=HA.A_ID AND 
										M.Sender_ID=C.ID AND 
										HA.privilege='Owner' AND 
										C.ID=C2.ID AND 
										M.Chat_ID=CH.Chat_ID And
							  			M.dates 
										>= 
										DATEADD(MONTH,DATEDIFF(MONTH,0,GETDATE())-1,0) AND 
										M.dates <= DATEADD(MONTH,DATEDIFF(MONTH,0,GETDATE()),0)
							 		GROUP BY C.ID);


--query2
SELECT TOP 1 C.*
FROM Admin A,Contact C
WHERE A.Contact_ID IN (SELECT TOP 1 R2.Receiver_ID
						FROM Receives R2,MSG M2,Admin A
						WHERE R2.MSG_ID=M2.MSG_ID AND R2.Receiver_ID=A.Contact_ID
						GROUP BY (R2.Receiver_ID)
						ORDER BY (COUNT(M2.MSG_ID)) DESC)
AND C.ID=A.Contact_ID;





--query3
SELECT C.*,ST.usage
FROM Contact C,Session S,Setting ST
WHERE C.ID = (SELECT TOP 1  CA2.Use_ID
				FROM Contact C,Call CA2
				WHERE CA2.Use_ID=C.ID
				GROUP BY CA2.Use_ID
				ORDER BY COUNT(CA2.Use_ID) DESC)
AND C.ID=S.Use_ID AND ST.Set_ID=S.Set_ID;




--query4
SELECT cast(A.video as float)/cast(A.voice as float) AS [Ratio]
FROM
(
SELECT 
(SELECT (COUNT(c.Contact_ID))
FROM Call C
WHERE c.call_type='Voice'
GROUP by c.call_type) AS voice,

(SELECT (COUNT(c.Contact_ID))
FROM Call C
WHERE c.call_type='Video'
GROUP by c.call_type) AS video
)A;

--query5


SELECT C.*
FROM Contact C
WHERE C.ID NOT IN(SELECT M.member_id
					  FROM Members M);



--query6

SELECT C.*
FROM Channel C ,MSG M 
WHERE C.Chat_ID=M.Chat_ID AND NOT EXISTS (SELECT M2.MSG_ID
											FROM MSG M2 
											WHERE M2.Chat_ID = C.Chat_ID  AND
											M2.dates
											>=
											DATEADD(MONTH,DATEDIFF(MONTH,0,GETDATE())-1,0) AND 
											M2.dates <=DATEADD(MONTH,DATEDIFF(MONTH,0,GETDATE()),0));
											


--query7

SELECT C.ID , C.F_Name ,C.L_Name ,M.*
FROM Contact C,Saved_Message SM,MSG M,Has_SM HS
WHERE C.ID=SM.Use_ID AND SM.Saved_ID=HS.Saved_ID AND HS.MSG_ID = M.MSG_ID;



--query8

SELECT C2.ID,C2.F_Name,C2.L_Name,S.IPs,ST3.twoStep
FROM Contact C2 ,Session S,Setting ST3
WHERE S.Session_ID IN (	SELECT S1.Session_ID
						FROM Session S1,Session S2,Setting ST,Setting ST2,CONTACT C
						WHERE 
							S1.IPs=S2.IPs AND 
							S1.Set_ID=ST.Set_ID AND 
							S2.Set_ID=ST2.Set_ID AND 
							ST.twoStep=ST2.twoStep AND 
							S1.Session_ID!=S2.Session_ID AND 
							C.ID= S1.Use_ID) AND 
							C2.ID=S.Use_ID AND 
							S.Set_ID=ST3.Set_ID;


--____________________________________________________________________________________________--

SELECT C.ID , C.F_Name,C.L_Name ,S1.IPs,ST.twoStep
FROM Session S1,Session S2,Setting ST,Setting ST2,CONTACT C
WHERE 
	S1.IPs=S2.IPs AND 
	S1.Set_ID=ST.Set_ID AND 
	S2.Set_ID=ST2.Set_ID AND 
	ST.twoStep=ST2.twoStep AND 
	S1.Session_ID!=S2.Session_ID AND 
	C.ID= S1.Use_ID AND 
	S1.Use_ID =C.ID
ORDER BY ST.twoStep;











