-- Pro-Kopf-BIP
WITH
-- Ich speichere die Jahreszahlen als CTEs, um diese nur an einer Stelle anzupassen
-- Diese sind in allen anderen Abfragen wiederverwendbar und reduzieren Anpassungsaufwand
-- Erf�llt �hnliche Funktion wie Variable
first_year AS (SELECT 1995),
last_year AS (SELECT 2015)
-- Grundgesamtheit/Basisdatensatz
-- Beinhaltet alle m�glichen Einzeldaten f�r verschiedene Anwendungsf�lle
-- Auf Basis dieser CTE werden verschiedene andere Berechnungen und Aggregationen durchgef�hrt
,basic_data AS (
	SELECT c.name AS country_name, r.name AS region_name, con.name  AS continent_name,
	cs."year" , cs.population , cs.gdp, (cs.gdp / cs.population) AS gdp_per_capita
	FROM nation.country_stats cs 
	JOIN nation.countries c ON cs.country_id = c.country_id 
	JOIN nation.regions r ON r.region_id = c.region_id 
	JOIN nation.continents con ON con.continent_id  = r.continent_id
	WHERE year IN (SELECT * FROM first_year UNION SELECT * FROM last_year)
) 
-- SELECT * FROM basic_data
,
-- Weltwirtschaftsleistung aus dem ersten Vergleichsjahr
world_gdp_first AS 
(
	SELECT SUM(gdp) AS sum_gdp, YEAR FROM basic_data WHERE year IN (SELECT * FROM first_year) group by year
)
,
-- Weltwirtschaftsleistung aus dem letzten Vergleichsjahr
world_gdp_last AS 
(
	SELECT SUM(gdp) AS sum_gdp, YEAR FROM basic_data WHERE year IN (SELECT * FROM last_year) group by year
)
,
-- Weltbev�lkerung aus dem ersten Vergleichsjahr
world_population_first AS 
(
	SELECT SUM(population) AS sum_population, YEAR FROM basic_data WHERE year IN (SELECT * FROM first_year)
)
,
-- Weltbev�lkerung aus dem letzen Vergleichsjahr
world_population_last AS 
(
	SELECT SUM(population) AS sum_population, YEAR FROM basic_data WHERE year IN (SELECT * FROM last_year)
)
,
-- Durchschnittliches Pro-Kopf-BIP der Welt aus dem ersten Vergleichsjahr
world_gdp_per_capita_first AS 
(
	SELECT (SELECT sum_gdp FROM world_gdp_first) / (SELECT sum_population FROM world_population_first)
)
-- SELECT * FROM world_gdp_per_capita_first
,
-- Durchschnittliches Pro-Kopf-BIP der Welt aus dem ersten Vergleichsjahr
world_gdp_per_capita_last AS 
(
	SELECT (SELECT sum_gdp FROM world_gdp_last) / (SELECT sum_population FROM world_population_last)
)
-- SELECT * FROM world_gdp_per_capita_last
,

-- --------------------
-- 3.	Pro-Kopf-BIP der Welt aus 1995 und 2015: absolute und prozentuale Ver�nderung
-- --------------------

-- Differenz des durchschnittlichen Pro-Kopf-BIPs der Welt (absolut)
world_gdp_per_capita_diff AS 
(
	SELECT (SELECT * FROM world_gdp_per_capita_last)-(SELECT * FROM world_gdp_per_capita_first)
)
,
-- Differenz des durchschnittlichen Pro-Kopf-BIPs der Welt (relativ)
world_gdp_per_capita_diff_rate AS 
(
	SELECT (SELECT * FROM world_gdp_per_capita_diff)/(SELECT * FROM world_gdp_per_capita_first)
)
-- SELECT * FROM world_gdp_per_capita_diff_rate
-- SELECT * FROM world_population_diff
,



-- --------------------
-- 5.	Pro-Kopf-BIP der L�nder aus den Jahren 1995 und 2015, absolute und relative Differenz
-- --------------------

-- Pro-Kopf-BIP der L�nder aus dem ersten Vergleichsjahr 
gdp_per_capita_per_country_first AS (
	SELECT country_name, gdp_per_capita FROM basic_data bd WHERE year = (SELECT * FROM first_year)
)
-- SELECT * FROM gdp_per_capita_per_country_first
,
-- Pro-Kopf-BIP der L�nder aus dem letzen Vergleichsjahr
gdp_per_capita_per_country_last AS (
	SELECT country_name, gdp_per_capita FROM basic_data bd WHERE year = (SELECT * FROM last_year)
)
,
-- Pro-Kopf-BIP der L�nder aus beiden Vergleichsjahren zusammengefasst
gdp_per_capita_per_country AS (
	SELECT gdpfirst.country_name,
	gdpfirst.gdp_per_capita as first_gdp_per_capita,
	gdplast.gdp_per_capita as last_gdp_per_capita
	FROM gdp_per_capita_per_country_first gdpfirst
	JOIN gdp_per_capita_per_country_last gdplast ON gdpfirst.country_name = gdplast.country_name
)
-- SELECT * FROM gdp_per_capita_per_country
,
-- Pro-Kopf-BIP-Differenzen (absolut und relativ) der L�nder aus beiden Vergleichsjahren zusammengefasst
-- 5.	Pro-Kopf-BIP der L�nder aus den Jahren 1995 und 2015, absolute und relative Differenz
gdp_per_capita_diff_per_country AS (
	SELECT 
	gdppc.country_name,
	first_gdp_per_capita,
	last_gdp_per_capita,
	gdppc.last_gdp_per_capita - gdppc.first_gdp_per_capita AS gdp_per_capita_diff,
	(gdppc.last_gdp_per_capita - gdppc.first_gdp_per_capita)/gdppc.first_gdp_per_capita AS gdp_per_capita_diff_rate
	FROM gdp_per_capita_per_country gdppc
)
-- SELECT * FROM gdp_per_capita_diff_per_country
-- 5 a.	Ausgabe: 10 L�nder mit den gr��ten/niedrigsten relativen Zuw�chsen
,
highest_gpd_per_capita_diff AS (
	SELECT * FROM gdp_per_capita_diff_per_country ORDER BY gdp_per_capita_diff_rate DESC LIMIT 10
)
,
lowest_gdp_per_capita_diff AS (
	SELECT * FROM gdp_per_capita_diff_per_country ORDER BY gdp_per_capita_diff_rate ASC LIMIT 10
)
-- SELECT * FROM highest_gpd_per_capita_diff
--  SELECT * FROM lowest_gdp_per_capita_diff
,
-- b.	Ausgabe: Alle L�nder mit unter/�berdurchschnittlichen Zuw�chsen, gemessen an durchschnittlichem Pro-Kopf-BIP-Wachstum
-- Vergleich bezieht sich f�r die Vergleichbarkeit jeweils auf die relative Differenz 
higher_than_avg_gdp_diff AS (
	SELECT * FROM gdp_per_capita_diff_per_country WHERE gdp_per_capita_diff_rate > (
		SELECT * FROM world_gdp_per_capita_diff_rate
	)
)
,
lower_than_avg_gdp_diff AS (
	SELECT * FROM gdp_per_capita_diff_per_country WHERE gdp_per_capita_diff_rate < (
		SELECT * FROM world_gdp_per_capita_diff_rate
	)
)
-- SELECT * FROM higher_than_avg_gdp_diff 
SELECT * FROM lower_than_avg_gdp_diff 

