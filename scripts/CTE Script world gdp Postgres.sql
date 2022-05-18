
-- 1.	Absolute Weltwirtschaftsleistung (GDP) aus 1995 und 2015: absolute und prozentuale Veränderung
WITH
-- Ich speichere die Jahreszahlen als CTEs, um diese nur an einer Stelle anzupassen
-- Diese sind in allen anderen Abfragen wiederverwendbar und reduzieren Anpassungsaufwand
-- Erfüllt ähnliche Funktion wie Variable
first_year AS (SELECT 1995 as year),
last_year AS (SELECT 2015 as year),
-- Grundgesamtheit/Basisdatensatz
-- Beinhaltet alle möglichen Einzeldaten für verschiedene Anwendungsfälle
-- Auf Basis dieser CTE werden verschiedene andere Berechnungen und Aggregationen durchgeführt
basic_data AS (
	SELECT c.name AS country_name, r.name AS region_name, con.name  AS continent_name,
	cs."year" as year , cs.population , cs.gdp 
	FROM nation.country_stats cs 
	JOIN nation.countries c ON cs.country_id = c.country_id 
	JOIN nation.regions r ON r.region_id = c.region_id 
	JOIN nation.continents con ON con.continent_id  = r.continent_id
	WHERE year IN (SELECT year FROM first_year UNION SELECT year FROM last_year)
) 
-- SELECT * FROM basic_data
,
-- Weltwirtschaftsleistung pro Jahr
world_gdp AS 
(
	SELECT SUM(gdp) AS sum_gdp, YEAR FROM basic_data GROUP BY YEAR
)
-- SELECT * FROM world_gdp
,
-- Weltwirtschaftsleistung aus dem ersten Vergleichsjahr
world_gdp_first AS 
(
	SELECT SUM(gdp) AS sum_gdp, "year" FROM basic_data WHERE year IN (SELECT "year" FROM first_year) group by year
)
-- SELECT * FROM world_gdp_first
,
-- Weltwirtschaftsleistung aus dem letzten Vergleichsjahr
world_gdp_last AS 
(
	SELECT SUM(gdp) AS sum_gdp, "year" FROM basic_data WHERE year IN (SELECT "year" FROM last_year) group by year
)
,
-- Optional: Weltwirtschaftsleistung aus den Vergleichsjahren
world_gdp2 AS 
(
	SELECT * FROM world_gdp_first 
	UNION
	SELECT * FROM world_gdp_last
)
-- SELECT * FROM world_gdp2
,
-- Veränderung der Weltwirtschaftsleistung (absolut)
world_gdp_diff AS 
(
	SELECT (SELECT sum_gdp FROM world_gdp_last)-(SELECT sum_gdp FROM world_gdp_first)
)
-- SELECT * FROM world_gdp_diff
,
-- Veränderung der Weltwirtschaftsleistung (relativ in Prozent)
world_gdp_rate AS 
(
	SELECT (SELECT * FROM world_gdp_diff)/(SELECT sum_gdp FROM world_gdp_first)*100
)
-- Zusammenfassende Statistik
SELECT CONCAT('BIP von ',(SELECT * FROM first_year)) AS Angabe, (SELECT sum_gdp FROM world_gdp_first) AS Wert
UNION
SELECT CONCAT('BIP von ',(SELECT * FROM last_year)) AS Angabe, (SELECT sum_gdp FROM world_gdp_last) AS Wert
UNION
SELECT 'Absolute Veränderung' AS Angabe, (SELECT * FROM world_gdp_diff) AS Wert
UNION
SELECT 'Prozentuale Veränderung' AS Angabe, (SELECT * FROM world_gdp_rate) AS Wert

