-- Find all Pokemon information
SELECT *
FROM pokemon;

-- Find all electric, water, or fire type Pokemon
SELECT *
FROM pokemon
WHERE Type_1 IN ('Electric', 'Water', 'Fire')
	OR Type_2 IN ('Electric', 'Water', 'Fire');
    
-- Find all legendary flying type Pokemon
SELECT *
FROM pokemon
WHERE (Type_1 = 'Flying'
	OR Type_2 = 'Flying')
		AND Legendary = 'True';
        
-- Find the name and total power of each Pokemon
-- of the Pokemons with less than 350 total power
-- with the stronger Pokemons first
SELECT Name, Total
FROM pokemon
WHERE Total < 350
ORDER BY Total DESC;

-- Find the name of the Pokemon with the highest total power
SELECT pk.Name, pk.Total
FROM pokemon AS pk
WHERE pk.Total = (SELECT MAX(pk2.Total)
					FROM pokemon AS pk2);

-- Find the Pokemon with total power greater than or equal to the average power of all Pokemon
SELECT pk.Name, pk.Total
FROM pokemon AS pk
WHERE pk.Total >= (SELECT AVG(pk2.Total)
					FROM pokemon AS pk2)
ORDER BY pk.Total ASC;

-- Find the Pokemon info per Strength_Power category
SELECT *, 
	CASE
		WHEN Total > 630 THEN "Strong"
		WHEN Total > 435 THEN "Average"
		ELSE "Weak"
	END AS Strength_Power
FROM pokemon
ORDER BY Strength_Power;

-- Count the number of Pokemon per Strength_Power category
SELECT COUNT(*),
    CASE
        WHEN Total > 630 THEN "Strong"
        WHEN Total > 435 THEN "Average"
        ELSE "Weak"
    END AS Strength_Power
FROM pokemon
GROUP BY Strength_Power;

-- Count the number of Pokemon without a 2nd type
SELECT COUNT(Name) -- Can SELECT the PRIMARY KEY to ensure all rows have non-NULL values
FROM pokemon
WHERE Type_2 IS NULL;

-- OR

SELECT COUNT(*) -- Best practice bc not all columns will have an entry and COUNT only counts the non-NULL rows
FROM pokemon
WHERE Type_2 IS NULL;

-- Count the # of Pokemon per type flag
SELECT pk2.Type_Flag, COUNT(pk2.Type_Flag)
FROM (SELECT CASE
				WHEN Type_2 IS NULL THEN 'Single'
                WHEN Type_2 IS NOT NULL THEN 'Double'
				ELSE 'Error'
			END AS 'Type_Flag'
		FROM pokemon) AS pk2
GROUP BY pk2.Type_Flag;