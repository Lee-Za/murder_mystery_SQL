-- Solving the murder mystery challenge from: https://mystery.knightlab.com/ with SQL

-- Asking for crime scene report (date, type of crime and city were given: Jan. 15th 2018, murder in SQL City)
SELECT * FROM crime_scene_report WHERE date = 20180115 AND type = 'murder' AND city = 'SQL City';

/* Security footage shows that there were 2 witnesses. 
The first witness lives at the last house on "Northwestern Dr". 
The second witness, named Annabel, lives somewhere on "Franklin Ave". */

-- Identifying the first witness
SELECT *, MAX(address_number) FROM person WHERE address_street_name = 'Northwestern Dr';
/* 
Morty Schapiro
Northwestern Dr 4919
ID: 14887
licence ID: 118009 
ssn: 111564949 */

-- Identifying the second witness
SELECT * FROM person WHERE address_street_name = 'Franklin Ave' AND name LIKE 'Annabel %';
/* 
Annabel Miller
Franklin Ave 103
ID: 16371
licence ID: 490173 
ssn: 318771143 */

-- Interviewing the witnesses
SELECT * FROM interview WHERE person_id IN (14887, 16371);
/*
Morty: "I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. 
The membership number on the bag started with "48Z". Only gold members have those bags. 
The man got into a car with a plate that included "H42W". "
Annabel: "I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th."
*/

-- Identifying suspects based on membership-id, gold-membership, checkin-date
SELECT name FROM get_fit_now_check_in AS checkins JOIN get_fit_now_member AS members ON checkins.membership_id = members.id WHERE checkins.check_in_date = 20180109 AND checkins.membership_id LIKE '48Z%' AND members.membership_status = 'gold'
/* 2 suspects identified: 
Joe Garmuska
Jeremy Bowers
*/

-- Looking for the suspect car and their owner
SELECT name FROM drivers_license JOIN person ON drivers_license.id = person.license_id WHERE drivers_license.plate_number like "%H42W%" AND  drivers_license.gender = 'male' AND person.name LIKE 'J%'       
--> Jeremy Bowers
--> Congrats, you found the murderer! But wait, there's more...