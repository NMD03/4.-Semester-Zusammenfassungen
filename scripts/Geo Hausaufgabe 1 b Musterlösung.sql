-- Musterlösung zu Aufgabe 1 b
-- Visualisieren Sie alle Länder, in denen Englisch offizielle Amtssprache ist
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
-- Schränke ein auf Englisch
english_countries
AS
(
    SELECT DISTINCT c.country_code3
    FROM nation.countries c
    JOIN nation.country_languages cl ON cl.country_id = c.country_id
    JOIN official_languages ol ON cl.language_id = ol.language_id
    WHERE ol.language = 'English'
)
-- Wähle Länder aus
SELECT co.geog, co.formal_name
FROM english_countries ec
JOIN public.countries co ON co.country_iso3 = ec.country_code3