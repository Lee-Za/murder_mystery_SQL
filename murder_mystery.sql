-- Solving the murder mystery challenge from: https://mystery.knightlab.com/ with SQL

-- Asking for crime scene report (date, type of crime and city were given: Jan. 15th 2018, murder in SQL City)
SELECT * FROM crime_scene_report WHERE date = 20180115 AND type = 'murder' AND city = 'SQL City';

-- Identifying the two witnesses
SELECT *, MAX(address_number) FROM person WHERE address_street_name = 'Northwestern Dr'; 
--> Morty Schapiro, ID: 14887
SELECT * FROM person WHERE address_street_name = 'Franklin Ave' AND name LIKE 'Annabel %';
--> Annabel Miller, ID: 16371

-- Interviewing the witnesses
SELECT * FROM interview WHERE person_id IN (14887, 16371);
/*
Morty: the man had a "Get Fit Now Gym" bag. gold member, membership number "48Z", car with a plate that included "H42W". "
Annabel: recognized the killer from my gym when I was working out last week on January the 9th."
*/

-- Identifying suspects based on membership-id, gold-membership, checkin-date
SELECT name FROM get_fit_now_check_in AS checkins 
JOIN get_fit_now_member AS members ON checkins.membership_id = members.id 
WHERE checkins.check_in_date = 20180109 AND checkins.membership_id LIKE '48Z%' AND members.membership_status = 'gold' ;
--> 2 suspects identified: Joe Garmuska / Jeremy Bowers


-- Looking for the suspect car and their owner
SELECT name FROM drivers_license 
JOIN person ON drivers_license.id = person.license_id 
WHERE drivers_license.plate_number like "%H42W%" AND  drivers_license.gender = 'male' AND person.name LIKE 'J%' ;    
--> Jeremy Bowers, id: 67318
--> Congrats, you found the murderer! But wait, there's more...

-- reading the mudererers interview
SELECT * from interview WHERE person_id = 67318 ;
-- rich female, BETWEEN 65 AND 67", red hair, Tesla Model S, attended SQL Symphony Concert 3 times in December 2017

-- who hired the killer?
SELECT dl.id, p.name, p.ssn, i.annual_income FROM drivers_license AS dl 
JOIN person AS p ON dl.id = p.license_id 
LEFT JOIN income AS i ON p.ssn = i.ssn 
LEFT JOIN facebook_event_checkin AS fb ON p.id = fb.person_id
WHERE dl.gender = 'female' AND dl.height BETWEEN 65 AND 67 AND dl.hair_color = 'red' 
AND dl.car_model = 'Model S' AND dl.car_make = 'Tesla' 
AND fb.date BETWEEN 20171201 AND 20171231 AND fb.event_name like 'SQL%' ;
--> Miranda Priestly, income 310,000
--> Congrats, you found the brains behind the murder! 