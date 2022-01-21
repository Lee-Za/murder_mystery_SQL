-- Solving the murder mystery challenge from: https://mystery.knightlab.com/

-- Asking for crime scene report (date, type of crime and city were given: Jan. 15th 2018, murder in SQL City)
SELECT * FROM crime_scene_report WHERE date = 20180115 AND type = 'murder' AND city = 'SQL City';

/* Security footage shows that there were 2 witnesses. 
The first witness lives at the last house on "Northwestern Dr". 
The second witness, named Annabel, lives somewhere on "Franklin Ave". */

-- Identifying the first witness
SELECT *, MAX(address_number) FROM person WHERE address_street_name = 'Northwestern Dr' 
/* 
Morty Schapiro
Northwestern Dr 4919
ID: 14887
licence ID: 118009 
ssn: 111564949 */

-- Identifying the second witness
SELECT * FROM person WHERE address_street_name = 'Franklin Ave' AND name LIKE 'Annabel %'
/* 
Annabel Miller
Franklin Ave 103
ID: 16371
licence ID: 490173 
ssn: 318771143 */
