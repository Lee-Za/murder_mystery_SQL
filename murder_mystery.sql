-- Solving the murder mystery challenge from: https://mystery.knightlab.com/

-- Asking for crime scene report (date, type of crime and city were given: Jan. 15th 2018, murder in SQL City)
SELECT * FROM crime_scene_report WHERE date = 20180115 AND type = 'murder' AND city = 'SQL City';

/* Security footage shows that there were 2 witnesses. 
The first witness lives at the last house on "Northwestern Dr". 
The second witness, named Annabel, lives somewhere on "Franklin Ave". */

-- Visiting the first witness