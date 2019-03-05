USE healthConnect;

#Q1#
SELECT CONCAT ( firstname, ' ' , surname ), nickname, job FROM users WHERE suburb = 'stafford';

#Q2#
SELECT nickname, mentorNickname FROM users WHERE mentorNickname IS NOT NULL ORDER BY surname ASC;

#Q3#
SELECT healthPracID, firstName, surname, COUNT ( nickname ) as numberOfUsers FROM (
		SELECT hp.healthPracID, hp.firstName, hp.surname, us.nickname FROM healthpractitioners hp
        LEFT JOIN treatmentrecords tr ON hp.healthPracID = tr.healthPracID
        LEFT JOIN users us ON us.nickname = tr.nickname
    ) as a GROUP BY ( healthPracID );
    
#Q4#
SELECT us.nickname, firstName, city, poa.postID FROM users us
	LEFT JOIN postauthors poa ON poa.nickname = us.nickname
	LEFT JOIN postcomments poc ON poc.nickname = us.nickname
	WHERE poa.postID IS NULL AND poc.postID IS NULL;
    
#Q5#
SELECT ill.illnessID, name, COUNT ( datestarted ) numOfUsers, MIN ( datestarted ) firstDate, MAX ( datestarted ) lastDate, AVG ( degree ) FROM illness ill
	JOIN treatmentrecords tr WHERE ill.illnessID = tr.illnessID GROUP BY illnessID;


#Q6#
SELECT users.nickname, ( COUNT ( postauthors.nickname ) + COUNT ( postcomments.nickname ) ) AS PostAndComments FROM users
    LEFT JOIN postauthors ON users.nickname = postauthors.nickname
	LEFT JOIN postcomments ON users.nickname = postcomments.nickname
	WHERE ( SELECT ( COUNT ( postauthors.nickname ) + COUNT ( postcomments.nickname ) ) >= 1 )
GROUP BY users.nickname;

#Task 3#
INSERT INTO users ( nickname, firstName, surname, birthyear ) VALUES ( 'stormy', 'Sam', 'Rodgers', '1982' );

DELETE FROM phonenumber WHERE phonenumber LIKE '07%';

UPDATE HealthPractitioners SET StreetNumber = '72', Street = 'Evergreen Terrace', Suburb = 'Springfield'
	WHERE StreetNumber = '180' AND Street = 'Zelda Street' AND Suburb = 'Linkburb' AND surname = 'Smith';

#Task 4#
CREATE INDEX index_postID ON Posts ( postID );

#Task 5#
GRANT INSERT ON healthConnect.users TO wayne@localhost;
GRANT DELETE ON healthConnect.users TO wayne@localhost;
REVOKE INSERT ON healthConnect.users FROM jake@localhost;
REVOKE DELETE ON healthConnect.users FROM jake@localhost;