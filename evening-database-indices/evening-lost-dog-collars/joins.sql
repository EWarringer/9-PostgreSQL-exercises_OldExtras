# YOUR SQL CODE GOES HERE


#  For which collars is there no known owner?

SELECT lost_dog_collars.dog_name
FROM dog_owners
JOIN lost_dog_collars
ON (dog_owners.dog_name = lost_dog_collars.dog_name)
WHERE name IS NOT NULL;


#  For which collars is there no known owner?

SELECT lost_dog_collars.dog_name FROM dog_owners
FULL OUTER JOIN lost_dog_collars
ON (dog_owners.dog_name = lost_dog_collars.dog_name)
WHERE name IS NULL;


# We need to see all collars with an owner, if one matches.

SELECT lost_dog_collars.dog_name, dog_owners.name
FROM lost_dog_collars
LEFT OUTER JOIN dog_owners
ON (dog_owners.dog_name = lost_dog_collars.dog_name);


# We need to see all owners, with collars in the Lost and Found, if one matches.

SELECT dog_owners.name, lost_dog_collars.dog_name
FROM dog_owners
LEFT OUTER JOIN lost_dog_collars
ON (dog_owners.dog_name = lost_dog_collars.dog_name);




-- SELECT dog_owners.name, lost_dog_collars.dog_name
-- FROM dog_owners
-- RIGHT OUTER JOIN lost_dog_collars
-- ON (dog_owners.dog_name = lost_dog_collars.dog_name);
