-- Wirtschaftsstatistik / Population
WITH
-- Speichere erstes und letztes Vergleichsjahr als CTE, wie Variable
first_year AS (SELECT 1995),
last_year AS (SELECT 2005)
-- Grundgesamtheit an Daten, Ausgangsbasis f�r weitere Berechnungen/Aggregationen
,basic_data AS (
	SELECT c.name AS country_name, r.name AS region_name, con.name  AS continent_name,
	cs."year" , cs.population , cs.gdp 
	FROM nation.country_stats cs 
	JOIN nation.countries c ON cs.country_id = c.country_id 
	JOIN nation.regions r ON r.region_id = c.region_id 
	JOIN nation.continents con ON con.continent_id  = r.continent_id
	WHERE year IN (SELECT * FROM first_year UNION SELECT * FROM last_year)
) 
-- SELECT * FROM basic_data
,
-- Weltbev�lkerung je Jahr
world_population AS 
(
	SELECT SUM(population) AS sum_population, YEAR FROM basic_data GROUP BY YEAR
)
-- SELECT * FROM world_population
,
-- Weltbev�lkerung des ersten Vergleichsjahres
world_population_first AS 
(
	SELECT SUM(population) AS sum_population, YEAR FROM basic_data WHERE year IN (SELECT * FROM first_year) group by year
)
,
-- Weltbev�lkerung des zweiten Vergleichsjahres
world_population_last AS 
(
	SELECT SUM(population) AS sum_population, YEAR FROM basic_data WHERE year IN (SELECT * FROM last_year) group by year
)
,
-- Optional: Zusammenfasung
world_population2 AS 
(
	SELECT * FROM world_population_first 
	UNION
	SELECT * FROM world_population_last
)
-- SELECT * FROM world_population2
,
-- 2. Weltbev�lkerung (Population) aus 1995 und 2015: absolute Ver�nderung
world_population_diff AS 
(
	SELECT (SELECT sum_population FROM world_population_last)-(SELECT sum_population FROM world_population_first) as value
)
,
-- 2. Weltbev�lkerung (Population) aus 1995 und 2015: relative Ver�nderung
world_population_diff_rate AS 
(
	SELECT (SELECT value::float FROM world_population_diff)/(SELECT sum_population::float FROM world_population_first) as value
)
--  SELECT * FROM world_population_diff_rate
 -- SELECT * FROM world_population_diff
,
-- Bev�lkerung der L�nder aus dem ersten Vergleichsjahr
population_per_country_first AS (
	SELECT country_name, population FROM basic_data bd WHERE year = (SELECT * FROM first_year)
)
,
-- Bev�lkerung der L�nder aus dem letzten Vergleichsjahr
population_per_country_last AS (
	SELECT country_name, population FROM basic_data bd WHERE year = (SELECT * FROM last_year)
)


-- Zusammenfassung: 2.	Weltbev�lkerung (Population) aus 1995 und 2015: absolute und prozentuale Ver�nderung + absolute Werte
SELECT CONCAT('Bev�lkerung von ',(SELECT * FROM first_year)) AS Angabe, (SELECT sum_population FROM world_population_first) AS Wert
UNION
SELECT CONCAT('Bev�lkerung von ',(SELECT * FROM last_year)) AS Angabe, (SELECT sum_population FROM world_population_last) AS Wert
UNION
SELECT 'Absolute Ver�nderung' AS Angabe, (SELECT * FROM world_population_diff) AS Wert
UNION
SELECT 'Prozentuale Ver�nderung' AS Angabe, (SELECT * FROM world_population_diff_rate) AS Wert
