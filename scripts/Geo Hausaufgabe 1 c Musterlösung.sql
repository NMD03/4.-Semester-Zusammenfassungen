-- Musterlösung zu Aufgabe 1 c
-- Visualisieren Sie alle Städte, in denen Spanisch offizielle Amtssprache ist
WITH
-- Liste aller Länder und deren offizielle Sprachen auf
official_languages AS (
	SELECT c.name AS country_name,
	r.name AS region_name, con.name  AS continent_name,
	l.language , official, country_code3, l.language_id
	FROM nation.country_languages cl
	JOIN nation.countries c ON cl.country_id = c.country_id
	JOIN nation.regions r ON r.region_id = c.region_id
	JOIN nation.continents con ON con.continent_id  = r.continent_id
	JOIN nation.languages l ON cl.language_id = l.language_id
	WHERE cl.official = 1
)
-- SELECT * FROM official_languages
,
-- Schränke ein auf Spanisch
spanish_spoken_countries
AS
(
    SELECT DISTINCT c.country_code3 FROM nation.countries c
    JOIN nation.country_languages cl ON cl.country_id = c.country_id
    JOIN official_languages ol ON cl.language_id = ol.language_id
    WHERE ol.language = 'Spanish'
)
-- Wähle Städte der Länder aus
SELECT ci.geog, ci.city_name
FROM spanish_spoken_countries ssc
JOIN cities ci ON ci.country_iso3_code = ssc.country_code3
