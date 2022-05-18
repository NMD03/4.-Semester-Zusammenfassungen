WITH
official_languages AS (
	SELECT c.name AS country_name,
	r.name AS region_name, con.name  AS continent_name,
	l.language , official
	FROM nation.country_languages cl
	JOIN nation.countries c ON cl.country_id = c.country_id 
	JOIN nation.regions r ON r.region_id = c.region_id 
	JOIN nation.continents con ON con.continent_id  = r.continent_id 
	JOIN nation.languages l ON cl.language_id = l.language_id
	WHERE cl.official = 1
)
-- SELECT * FROM official_languages
-- 1.	Liste aller Länder und deren offizielle Sprachen auf
,
languages_per_country AS (
	SELECT country_name, language
	FROM official_languages ol
)
-- SELECT * FROM languages_per_country
,
languages_grouped_by_country AS (
	SELECT country_name,
	GROUP_CONCAT(DISTINCT language) AS all_languages,
	COUNT(DISTINCT language) AS language_count
	FROM languages_per_country
	GROUP BY country_name
)
-- SELECT * FROM languages_grouped_by_country
,
-- 2  b.	Liste aller Regionen, dazu die Anzahl und Namen der offiziellen Sprachen je Region
languages_per_region AS (
	SELECT region_name, 
	-- GROUP_CONCAT(DISTINCT country_name) AS countries,
	-- count(DISTINCT country_name) AS country_count,
	GROUP_CONCAT(DISTINCT language) AS languages,
	count(DISTINCT language) AS language_count 
	,continent_name
	FROM official_languages ol
	GROUP BY region_name
)
-- SELECT * FROM languages_per_region
,
-- 2 c.	Liste aller Kontinente, dazu die Anzahl und Namen der offiziellen Sprachen je Kontinent
languages_per_continent1 AS (
	SELECT continent_name,  GROUP_CONCAT(DISTINCT language),
	count(DISTINCT language)
	FROM official_languages ol
	GROUP BY continent_name
)
-- SELECT * FROM languages_per_continent1
,
languages_per_continent2 AS (
	SELECT continent_name, GROUP_CONCAT(DISTINCT languages),
	sum(DISTINCT language_count) AS language_count
	FROM languages_per_region
	GROUP BY continent_name
)
-- SELECT * FROM languages_per_continent2
,
-- 3.	Auflistung der Sprachen: Liste aller Sprachen 
-- (pro Sprache nur 1 Zeile!), dazu die Anzahl und Namen
--  der Länder, Regionen und Kontinente, in denen die
-- Sprache offiziell gesprochen wird
country_grouped_by_language AS (
	SELECT language,
	GROUP_CONCAT(DISTINCT country_name) as countries,
	COUNT(DISTINCT country_name) as country_count
	FROM official_languages ol
	GROUP BY language
)
--  SELECT * FROM country_grouped_by_language
,
region_grouped_by_language AS (
	SELECT language,
	GROUP_CONCAT(DISTINCT region_name), COUNT(DISTINCT region_name)
	-- GROUP_CONCAT(DISTINCT country_name), COUNT(DISTINCT country_name)
	FROM official_languages ol
	GROUP BY language
),
-- SELECT * FROM region_grouped_by_language
continents_grouped_by_language AS (
	SELECT language,
	GROUP_CONCAT(DISTINCT continent_name), COUNT(DISTINCT continent_name),
	GROUP_CONCAT(DISTINCT region_name), COUNT(DISTINCT region_name),
	GROUP_CONCAT(DISTINCT country_name), COUNT(DISTINCT country_name)
	FROM official_languages ol
	GROUP BY language
)
-- SELECT * FROM continents_grouped_by_language

,
-- 4.	Die 5 Länder mit den meisten offiziellen Landessprachen
countries_with_most_languages AS (
	SELECT *
	FROM languages_grouped_by_country
	ORDER BY language_count
	DESC LIMIT 15
)
-- SELECT * FROM countries_with_most_languages

-- 5.	Die 5 Sprachen, die in den meisten Ländern offizielle Landessprache sind 
,
languages_in_most_countries AS (
	SELECT *
	FROM country_grouped_by_language
	ORDER BY country_count
	DESC LIMIT 5
)
-- SELECT * FROM languages_in_most_countries

-- 6.	Die 5 Sprachen, die 2015 von den meisten Menschen
-- der Erde offiziell gesprochen wurden und die Anzahl der Muttersprachler (Annäherung)
,
population_per_country AS (
	SELECT c.name, cs.population
	FROM nation.countries c
	JOIN nation.country_stats cs ON cs.country_id = c.country_id 
	WHERE cs.year = 2015
)
-- SELECT * FROM population_per_country
,
languages_and_population_per_country AS (
	SELECT *
	FROM population_per_country cpc
	JOIN languages_per_country lpc
	ON cpc.name=lpc.country_name
)
--  SELECT * FROM languages_and_population_per_country
,
languages_per_total_population AS (
	SELECT SUM(population),	language
	FROM languages_and_population_per_country
	GROUP BY language
	ORDER BY SUM(population) DESC LIMIT 15
)
SELECT * FROM languages_per_total_population
-- SELECT * FROM languages_in_most_countries
-- SELECT * FROM continents_grouped_by_language

-- SELECT * FROM languages_per_continent1
-- SELECT * FROM languages_per_region

-- languages_per_continent 
-- SELECT * FROM nation.continents c 
-- SELECT * FROM nation.regions
-- SELECT * FROM nation.countries
