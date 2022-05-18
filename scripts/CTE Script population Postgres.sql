-- Wirtschaftsstatistik / Population
WITH
-- Speichere erstes und letztes Vergleichsjahr als CTE, wie Variable
first_year AS (SELECT 1995),
last_year AS (SELECT 2005)
-- Grundgesamtheit an Daten, Ausgangsbasis für weitere Berechnungen/Aggregationen
,basic_data AS (
	SELECT c.name AS country_name, r.name AS region_name, con.name  AS continent_name,
	cs.year , cs.population , cs.gdp 
	FROM nation.country_stats cs 
	JOIN nation.countries c ON cs.country_id = c.country_id 
	JOIN nation.regions r ON r.region_id = c.region_id 
	JOIN nation.continents con ON con.continent_id  = r.continent_id
	WHERE year IN (SELECT * FROM first_year UNION SELECT * FROM last_year)
) 
-- SELECT * FROM basic_data
,
-- Weltbevölkerung je Jahr
world_population AS 
(
	SELECT SUM(population) AS sum_population, YEAR FROM basic_data GROUP BY YEAR
)
-- SELECT * FROM world_population
,
-- Weltbevölkerung des ersten Vergleichsjahres
world_population_first AS 
(
	SELECT SUM(population) AS sum_population, YEAR FROM basic_data WHERE year IN (SELECT * FROM first_year) GROUP BY YEAR
)
,
-- Weltbevölkerung des zweiten Vergleichsjahres
world_population_last AS 
(
	SELECT SUM(population) AS sum_population, YEAR FROM basic_data WHERE year IN (SELECT * FROM last_year) GROUP BY YEAR
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
-- 2. Weltbevölkerung (Population) aus 1995 und 2015: absolute Veränderung
world_population_diff AS 
(
	SELECT (SELECT sum_population FROM world_population_last)-(SELECT sum_population FROM world_population_first) as value
)
,
-- 2. Weltbevölkerung (Population) aus 1995 und 2015: relative Veränderung
world_population_diff_rate AS 
(
	SELECT (SELECT value::float FROM world_population_diff)/(SELECT sum_population FROM world_population_first)
)
-- SELECT * FROM world_population_diff_rate
-- SELECT * FROM world_population_diff
,
-- Bevölkerung der Länder aus dem ersten Vergleichsjahr
population_per_country_first AS (
	SELECT country_name, population FROM basic_data bd WHERE year = (SELECT * FROM first_year)
)
,
-- Bevölkerung der Länder aus dem letzten Vergleichsjahr
population_per_country_last AS (
	SELECT country_name, population FROM basic_data bd WHERE year = (SELECT * FROM last_year)
)
,
-- Zusammengefasste Bevölkerungsdaten der Länder aus beiden Vergleichsjahren
populations_per_country AS (
	SELECT popfirst.country_name,
	popfirst.population as first_population,
	poplast.population as last_population
	FROM population_per_country_first popfirst
	JOIN population_per_country_last poplast ON popfirst.country_name = poplast.country_name
)
,
-- 4.	Die Population der Länder aus den Jahren 1995 und 2015, absolute und relative Differenz
population_diff_per_country AS (
	SELECT 
	ppc.country_name,
	first_population,
	last_population,
	ppc.last_population - ppc.first_population AS pop_diff,
	(ppc.last_population - ppc.first_population)/ppc.first_population AS pop_diff_rate
	FROM populations_per_country ppc
)
,
-- a.	Ausgabe: 10 Länder mit den größten relativen Zuwächsen
highest_pop_diff AS (
	SELECT * FROM population_diff_per_country ORDER BY pop_diff_rate DESC LIMIT 10
)
,
-- a.	Ausgabe: 10 Länder mit den niedrigsten relativen Zuwächsen
lowest_pop_diff AS ( 
	SELECT * FROM population_diff_per_country ORDER BY pop_diff_rate ASC LIMIT 10
)
,
-- b.	Ausgabe: Alle Länder mit überdurchschnittlichen Zuwächsen, gemessen an Weltbevölkerungswachstum
higher_than_avg_pop_diff AS (
	SELECT * FROM population_diff_per_country pop WHERE pop_diff_rate > (
		SELECT * FROM world_population_diff_rate
	)
)
,
-- b.	Ausgabe: Alle Länder mit unterdurchschnittlichen Zuwächsen, gemessen an Weltbevölkerungswachstum
lower_than_avg_pop_diff AS (
	SELECT * FROM population_diff_per_country pop WHERE pop_diff_rate < (
		SELECT * FROM world_population_diff_rate
	)
)
-- SELECT * FROM lower_than_avg_pop_diff 

-- Zusammenfassung: 2.	Weltbevölkerung (Population) aus 1995 und 2015: absolute und prozentuale Veränderung + absolute Werte
SELECT CONCAT('Bevölkerung von ',(SELECT * FROM first_year)) AS Angabe, (SELECT sum_population FROM world_population_first) AS Wert
UNION
SELECT CONCAT('Bevölkerung von ',(SELECT * FROM last_year)) AS Angabe, (SELECT sum_population FROM world_population_last) AS Wert
UNION
SELECT 'Absolute Veränderung' AS Angabe, (SELECT * FROM world_population_diff) AS Wert
UNION
SELECT 'Prozentuale Veränderung' AS Angabe, (SELECT * FROM world_population_diff_rate) AS Wert
