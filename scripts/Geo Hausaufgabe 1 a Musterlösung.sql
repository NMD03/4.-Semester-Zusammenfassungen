-- Musterlösung zu Aufgabe 1 a
-- Geben Sie aus und visualisieren Sie: alle Länder des Kontinents Europa

-- Variante ohne JOIN verschiedener Datenquellen
SELECT co.formal_name, co.geog
FROM countries co
WHERE co.continent = 'Europe'
;

-- Variante mit JOIN verschiedener Datenquellen
SELECT geo_cou.formal_name, geo_cou.geog
FROM countries geo_cou
JOIN nation.countries na_cou ON na_cou.country_code3 = geo_cou.country_iso3
JOIN nation.regions reg ON reg.region_id = na_cou.region_id
JOIN nation.continents cont ON cont.continent_id = reg.continent_id
WHERE cont.name = 'Europe'
