# Datenbanken <!-- omit in toc -->
Dieses File beinhaltete eine kleine Zusammenfassung der Vorlesung Datenbanken.
# Inhaltsverzeichnis <!-- omit in toc -->
- [SQL-Befehle](#sql-befehle)
  - [SELECT](#select)
    - [Aufbau](#aufbau)
    - [Berechnungen](#berechnungen)
    - [Datum](#datum)
    - [Stringfunktionen](#stringfunktionen)
    - [Aggregatsfunktionen](#aggregatsfunktionen)
    - [LIMIT](#limit)
    - [Distinct](#distinct)
  - [CASE (SELECT ohne Tabelle)](#case-select-ohne-tabelle)
    - [Aufbau](#aufbau-1)
    - [Beispiele](#beispiele)
  - [ORDER BY (SELECT mit Tabelle)](#order-by-select-mit-tabelle)
    - [Aufbau](#aufbau-2)
    - [Beispiel](#beispiel)
    - [ASC](#asc)
    - [DESC](#desc)
  - [GROUP BY](#group-by)
    - [Aufbau](#aufbau-3)
    - [Beispiel](#beispiel-1)
  - [HAVING](#having)
    - [Aufbau](#aufbau-4)
    - [Beispiel](#beispiel-2)
  - [JOIN](#join)
    - [Aufbau](#aufbau-5)
    - [INNER JOIN](#inner-join)
    - [RIGTH/LEFT JOIN](#rigthleft-join)
    - [FULL OUTER JOIN](#full-outer-join)
  - [INSERT](#insert)
  - [UPDATE](#update)
  - [DELETE](#delete)
  - [CREATE TABLE](#create-table)
  - [ALTER](#alter)
  - [IF-Bedingungen](#if-bedingungen)
    - [Aufbau](#aufbau-6)
    - [Beispiel](#beispiel-3)
  - [CASE WHEN](#case-when)
    - [Aufbau](#aufbau-7)
    - [Beispiel](#beispiel-4)
  - [Views](#views)
    - [Aufbau](#aufbau-8)
    - [Beispiel](#beispiel-5)
  - [Unterabfragen](#unterabfragen)
    - [Unterabfragen in SELECT](#unterabfragen-in-select)
    - [Unterabfragen in FROM](#unterabfragen-in-from)
    - [Unterabfragen in WHERE](#unterabfragen-in-where)
    - [Listen-Unterabfragen in WHERE](#listen-unterabfragen-in-where)
    - [EXISTS-Unterabfragen in WHERE](#exists-unterabfragen-in-where)
  - [Ergebnismengenoperationen](#ergebnismengenoperationen)
    - [Aufbau](#aufbau-9)
  - [Common Table Expression (CTE)](#common-table-expression-cte)
    - [Aufbau](#aufbau-10)
- [ERM Diagramme](#erm-diagramme)
  - [Chen-Notation](#chen-notation)
  - [UML-Notation](#uml-notation)
  - [Crow's Foot-Notation](#crows-foot-notation)
- [Tools](#tools)
  - [Data Grip](#data-grip)
  - [Q-Gis](#q-gis)
  - [DBeaver](#dbeaver)
- [Aufgaben](#aufgaben)
  - [MariaDB](#mariadb)
    - [Languages](#languages)
    - [World GDP](#world-gdp)
    - [World Population](#world-population)
  - [Postgres/Postgis](#postgrespostgis)
  - [Hausaufgabe](#hausaufgabe)


# SQL-Befehle
Eine kleine Zusammenfassung der wichtigsten Befehle und Funktionen in SQL (Structured Query Language).

## SELECT
### Aufbau
1. **SELECT**
2. FROM
3. WHERE
4. ORDER BY
### Berechnungen
- Addition: ``SELECT a + b`` 
- Subtraktion: ``SELECT a - b``
- Multiplikation: ``SELECT a * b``
- Division: ``SELECT a / b``
- Modulo: ``SELECT a % b``
- Wurzel: ``SELECT SQRT(9), SQRT(25)``
- Quadrat: ``SELECT SQUARE(3), SQUARE(5)``
- Absolutbetrag: ``SELECT ABS(-20), ABS(20)``
- Vorzeichen: ``SELECT SIGN(-42), SIGN(42)``
- Runden: ``SELECT ROUND(0.25,1)`` 
### Datum
- Aktuelle Zeit: ``SELECT GETDATE()``
- Aktuelle Uhrzeit: ``SELECT CAST(GETDATE() AS TIME)``
- Aktuelles Datum: ``SELECT CAST(GETDATE() AS DATE)``
- Differenz: ``SELECT DATEDIFF(DAY, '2021-10-07', '2021-10-14')``
- Addition: ``SELECT DATEADD(WEEK, 3, '2021-10-01')``
### Stringfunktionen
- Verkn??pfen: ``SELECT CONCAT('Hier', 'steht', 'Text')``
- Ausschneiden: 
  - ``SELECT LEFT('Hier steht Text', 7)`` 
  - ``SELECT RIGHT('Hier steht Text', 7)``
  - ``SELECT SUBSTRlNG('Hier steht Text', 1, 4)``
- Finden: ``SELECT PATINDEX('%steht%', 'Hier steht Text')``
- Ersetzen: ``SELECT REPLACE('Hier steht Text', 'steht', 'stand')`` 
- Trimmen: ``SELECT TRIM(' Leerzeichen vorne und hinten ')``
- L??nge ermitteln: ``SELECT LEN('Beispieltext')``
### Aggregatsfunktionen
- Anzahl: ``SELECT COUNT()``
- Minimalwert: ``SELECT MIN()``
- Maximalwert: ``SELECT MAX()``
- Durschnitt: ``SELECT AVG()``
### LIMIT
``` sql
SELECT Name, Partei
FROM Politiker LIMIT 4
```
--> Die ersten 4 Namen der Poltiker mit der entsprechenden Partei werden ausgegeben
### Distinct
``` sql
SELECT DISTINCT Partei
FROM Politiker
```
--> Alle Parteien werden Ausgegeben allerding nur 1 mal pro Partei (keine Wiederholung)

## CASE (SELECT ohne Tabelle)
### Aufbau
``` sql
CASE 
WHEN <Bedingung> THEN <Wahr_Ausgabe> ELSE <Falsch_Ausgabe>
END
```
### Beispiele 
``` sql
SELECT CASE WHEN 1<2 THEN 'Gr????er' ELSE 'Kleiner' END
```
``` sql
SELECT CASE WHEN 3<2 THEN 'Gr????er' ELSE 'Kleiner' END 
```

## ORDER BY (SELECT mit Tabelle)
### Aufbau
1. SELECT
2. FROM
3. WHERE
4. **ORDER BY**
### Beispiel
``` sql
SELECT Name, Partei
FROM Politiker
ORDER BY Name
```
### ASC
Die Ordnung erfolgt aufsteigend -> zuerst kleine Zahlen bzw. Buchstaben am Anfang des Alphabets
``` sql
SELECT Name, Partei
FROM Politiker
ORDER BY Name ASC
```
### DESC
Die Ordnung erfolgt absteigend -> zuerst gro??e Zahlen bzw. Buchstaben am Ende des Alphabets
``` sql
SELECT Name, Partei
FROM Politiker
ORDER BY Name DESC
```

## GROUP BY
### Aufbau
1. SELECT
2. FROM
3. WHERE
4. **GROUP BY**
5. ORDER BY
### Beispiel
```sql
SELECT COUNT(Politiker.ID), Partei.Name
FROM Partei
JOIN Politiker ON Politiker.ID = Politiker.Partei
GROUP BY Partei.Name
```
![](./img/group%20by.png)
## HAVING
### Aufbau
1. SELECT
2. FROM
3. WHERE
4. GROUP BY
5. **HAVING**
6. ORDER BY
### Beispiel
```sql
SELECT COUNT(Politiker.ID), Partei.Name
FROM Partei
JOIN Politiker ON Politiker.ID = Politiker.Partei
GROUP BY Partei.Name
HAVING COUNT(Politiker.ID) > 1
```
![](./img/Having.png)

## JOIN
Dient zur Verkn??pfung meherer Tabellen miteinander anahnd einer Bedingung (oft Gleichheit von Prim??r- und Fremdschl??sseln)
### Aufbau 
1. SELECT
2. FROM **inkl. JOINs**
3. WHERE
4. ORDER BY
### INNER JOIN
> Datens??tze beider Tabellen werden anhand der Bedingung 
verbunden, d.h. die Datens??tze beider Tabellen m??ssen diese erf??llen 
``` sql
SELECT * 
FROM Politiker 
JOIN Partei ON Politiker.Partei = Partei.ID
```
![inner JOIN](./img/inner%20join.png)
### RIGTH/LEFT JOIN
>  Datens??tze beider Tabellen werden anhand der 
Bedingung verbunden und zus??tzlich alle Datens??tze der rechten/linken 
Tabelle, auch wenn diese nicht die Bedingung erf??llen

**LEFT JOIN:**
``` sql
SELECT * 
FROM Politiker 
LEFT JOIN Partei ON Politiker.Partei = Partei.ID
```
![left JOIN](./img/left%20join.png)
**RIGHT JOIN:**
``` sql
SELECT * 
FROM Politiker 
RIGHT JOIN Partei ON Politiker.Partei = Partei.ID
```
![right JOIN](./img/right%20join.png)
### FULL OUTER JOIN
> Datens??tze beider Tabellen werden anhand der 
Bedingung verbunden und zus??tzlich alle Datens??tze der rechten und 
linken Tabelle, auch wenn diese nicht die Bedingung erf??llen
``` sql
SELECT *
FROM Politiker
FULL JOIN Partei ON Politiker.Partei = Partei.ID
```
![full join](./img/full%20join.png)

## INSERT
Erstellt neuen Datensatz in einer Tabelle:
```sql
INSERT INTO <Tabelle> (<Spalten>) VALUES (<Werte>)
```
oder 
```sql
INSERT INTO <Tabelle> VALUES (<Werte>)
```
## UPDATE
Ver??ndert einen bestehenden Datensatz
```sql
UPDATE <Tabelle> SET <Spalte> = <neuer_Wert>
```
-> ver??ndert alle Werte einer Spalte daher:
```sql
UPDATE <Tabelle> SET <Spalte> = <neuer_Wert> WHERE <Bedingung>
```
## DELETE
L??scht Datens??tze aus Tabellen:
```sql
DELETE FROM  <Tabelle> WHERE <Bedingung>
```
-> ohne WHERE wird die komplette Tabelle gel??scht

## CREATE TABLE
Erstellt neuen Tabellen:
```sql
CREATE TABLE <Tebellenname>(
  <Spaltenname01><Datentyp>,
  <Spaltenname02><Datentyp>,
  ...
);
```
**Datentypen:**
- INTEGER
- TEXT
- DATE

Auch mit SELECT Abfrage m??glich:
```sql
CREATE TABLE admin_.Mark
SELECT f.title, ac.actor_id, ac.first_name, ac.last_name
FROM sakila.actor ac
JOIN sakila.film_actor fa ON fa.actor_id = ac.actor_id
JOIN sakila.film f ON f.film_id = fa.film_id
WHERE ac.first_name = 'Nick' AND ac.last_name = 'Wahlberg';
```
## ALTER
Ver??ndert ganze Spalten von Tabellen:
1. L??scht Spalte:
   ```sql
   ALTER TABLE <Tabelle> DROP COLUMN <Spalte>;
   ```
2. F??gt Spalte hinzu:
   ```sql
   ALTER TABLE <Tabelle> ADD <Spalte> <Datentyp>;
   ```
3. Ver??ndert Spalte:
   ```sql
   ALTER TABLE <Tabelle> CHANGE COLUMN <AlterName> <NeuerName> <Datentyp>;
   ```
## IF-Bedingungen
### Aufbau
```sql
IF(condition, true_value, false_value)
```
### Beispiel
```sql
SELECT
IF(CategoryName IN('Condiments','Confections'), 's????', 'nicht s????')
AS 'Einstufung'
FROM northwind.Categories;
```
## CASE WHEN
### Aufbau
```sql
CASE case_value
WHEN when_value THEN statement_list
[WHEN when_value THEN statement_list]...
[ELSE statement_list]
END CASE
```
### Beispiel
```sql
SELECT *
CASE 
WHEN name IN ('Children', 'Comedy', 'Family', 'Travel') THEN 'Kinder-geeignet'
WHEN name IN ('Action', 'Thriller', 'Drama', 'Horror') THEN 'NIcht f??r Kinder geeignet'
ELSE 'unbestimmt'
END AS 'Einstufung'
FROM sakila.category;
```
## Views
Eine View ist quasi eine Virtuelle Tabelle die in weiteren Abfragen verwendet werden kann.
### Aufbau 
```sql
CREATE VIEW <View_name>
AS
<SELECT-Abfrage>
```
### Beispiel
```sql
CREATE VIEW admin .vMark AS 
SELECT f.title, ac.actor id, ac.first name, ac.last name 
FROM sakila.actor ac 
JOIN sakila.film actor fa ON fa.actor id = ac.actor id 
JOIN sakila.film f ON f.film id = fa.film id 
WHERE ac.first_name = 'Nick' AND ac.last_name = 'Wahlberg';
```

## Unterabfragen
### Unterabfragen in SELECT
**Aufbau**:
```sql
SELECT (SELECT s1 FROM t2)
FROM t1;
```
-> Diese Art der Unterabfrage muss einen **Skalarwert** zur??ckgeben (**eine Zeile und Eine Spalte** -> nur eine Spalte zur??ckgeben und LIMIT auf 1 setzen)
### Unterabfragen in FROM
**Aufbau**:
```sql
SELECT *
FROM (SELECT s1,s2,s3 FROM t2) t1;
``` 
-> FROM Unterabfragen werden mit einem Alias benannt und k??nnen wie normale Tabellen behandelt werden <br>
-> mehrfache verschachtelung m??glich
### Unterabfragen in WHERE
**Aufbau**:
```sql
SELECT * 
FROM t1
WHERE t1.s1 <OPERAND> <Unterabfrage>
```
-> Vergleichs-Operanden: =, \>, <, \>=, <=, <>, != <br>

-> Vergleich mit Skalarwert der Unterabfrage
### Listen-Unterabfragen in WHERE
**Aufbau**:
```sql
SELECT *
FROM t1
WHERE t1.s1 <OPERATOR> <SOME/ANY> <Unterabfrage>
```
oder
```sql
SELECT *
FROM t1
WHERE t1.s1 <OPERATOR> <ALL> <Unterabfrage>
```
oder
```sql
SELECT *
FROM t1
WHERE t1.s1 <OPERATOR> <IN> <Unterabfrage>
```
oder 
```sql
SELECT *
FROM t1
WHERE t1.s1 <NOT IN> <Unterabfrage>
```
-> ``IN``, ``SOME`` und ``ANY`` sind Synonyme (TRUE wenn Vergleich mit mind einem Element der Unterabfrage erf??llt ist)<br>
-> ``NOT IN`` ist Abk??rzung f??r ``<> ALL`` oder ``!= ALL``
### EXISTS-Unterabfragen in WHERE
**Aufbau**:
```sql
SELECT * 
FROM t1
WHERE (NOT) EXISTS <Unterabfrage>
```
-> ``EXISTS`` ist TRUE wenn die Unterabfrage mind. einen Wert zur??ckliefert <br>
-> ``NOT EXISTS`` ist TRUE wenn die Unterabfrage keine Werte zur??ckliefert

## Ergebnismengenoperationen
### Aufbau
```sql
<Abfrage1> UNION (ALL) <Abfrage2> UNION (ALL) <Abfrage3> ...
```
-> Kombiniert Ergebnismenge mehrerer Abfragen <br>
-> ``UNION`` entfernt doppelte Zeilen (??hnlich zu ``SELECT DISTINCT``)<br>
-> ``UNION ALL`` includiert doppelte Zeilen


## Common Table Expression (CTE)
### Aufbau
```sql
WITH <CTE-Name> AS <SELECT-Abfrage>
```
-> speichert Abfragen f??r Mehrfachnutzung (??hnlich wie VIEW)<br>
-> Mehrere CTEs hintereinander werden mit Komma getrennt<br>
-> CTEs k??nnen aufeinander aufbauen (Reihenfolge beachten)

# ERM Diagramme
ER-Diagramme werden zur Visualisierung der Verbindungen in einer relationalen Datenbank genutzt. Dabei werden grundlegend zwischen 3 verschiedenen Relationen/Beziehung zwischen den Entit??ten unterschieden:
1. 1 zu 1
2. 1 zu n
3. n zu m
## Chen-Notation
![](./img/chen%20notation.png)
## UML-Notation
![](./img/UML%20notation.png)
## Crow's Foot-Notation
![](./img/Crows%20foot%20notation.png)
# Tools
## Data Grip
## Q-Gis
Ein Tool zum visualisieren von geospazialen Daten.
![](./img/q-gis.png)
## DBeaver
# Aufgaben
## MariaDB
### Languages
Geben Sie mithilfe von CTEs aus: 
1.	Liste aller L??nder und deren offiziell Sprachen
2.	Auflistung der L??nder/Regionen/Kontinente (pro Land/Region/Kontinent nur 1 Zeile!)
a.	Liste aller L??nder, dazu die Anzahl und Namen der offiziellen Sprachen je Land
b.	Liste aller Regionen, dazu die Anzahl und Namen der offiziellen Sprachen je Region
c.	Liste aller Kontinente, dazu die Anzahl und Namen der offiziellen Sprachen je Kontinent
3.	Auflistung der Sprachen: Liste aller Sprachen (pro Sprache nur 1 Zeile!), dazu die Anzahl und Namen der L??nder, Regionen und Kontinente, in denen die Sprache gesprochen wird
4.	Die 5 L??nder mit den meisten offiziellen Landessprachen
5.	Die 5 Sprachen, die in den meisten L??ndern offizielle Landessprache sind und deren
6.	Die 5 Sprachen, die 2015 von den meisten Menschen der Erde gesprochen wurden und die Anzahl der Muttersprachler (Ann??herung)

[L??sung](./scripts/CTE%20Script%20languages.sql) f??r die language Aufgaben.
### World GDP
Geben Sie mithilfe von CTEs aus:
1.	Absolute Weltwirtschaftsleistung (GDP) aus 1995 und 2015: absolute und prozentuale Ver??nderung ([L??sung](./scripts/CTE%20Script%20world%20gdp.sql))
### World Population
Geben Sie mithilfe von CTEs aus:
1.	Weltbev??lkerung (Population) aus 1995 und 2015: absolute und prozentuale Ver??nderung. ([L??sung](./scripts/CTE%20Script%20world%20population.sql))

## Postgres/Postgis
Geben Sie mithilfe von CTEs aus:
1.	Absolute Weltwirtschaftsleistung (GDP) aus 1995 und 2015: absolute und prozentuale Ver??nderung ([L??sung](./scripts/CTE%20Script%20world%20gdp%20Postgres.sql))
2.	Weltbev??lkerung (Population) aus 1995 und 2015: absolute und prozentuale Ver??nderung ([L??sung](./scripts/CTE%20Script%20population%20Postgres.sql))
3.	Pro-Kopf-BIP der Welt aus 1995 und 2015: absolute und prozentuale Ver??nderung ([L??sung](./scripts/CTE%20Script%20gdp_per_capita%20Postgres.sql))


Geben Sie mithilfe von CTEs aus: 
1.	Liste aller L??nder und deren offiziell Sprachen
2.	Auflistung der L??nder/Regionen/Kontinente (pro Land/Region/Kontinent nur 1 Zeile!)
a.	Liste aller L??nder, dazu die Anzahl und Namen der offiziellen Sprachen je Land
b.	Liste aller Regionen, dazu die Anzahl und Namen der offiziellen Sprachen je Region
c.	Liste aller Kontinente, dazu die Anzahl und Namen der offiziellen Sprachen je Kontinent
3.	Auflistung der Sprachen: Liste aller Sprachen (pro Sprache nur 1 Zeile!), dazu die Anzahl und Namen der L??nder, Regionen und Kontinente, in denen die Sprache gesprochen wird
4.	Die 5 L??nder mit den meisten offiziellen Landessprachen
5.	Die 5 Sprachen, die in den meisten L??ndern offizielle Landessprache sind und deren
6.	Die 5 Sprachen, die 2015 von den meisten Menschen der Erde gesprochen wurden und die Anzahl der Muttersprachler (Ann??herung)

[L??sung](./scripts/CTE%20Script%20languages%20Postgres.sql) f??r die Language-Aufgaben

## Hausaufgabe
Geben Sie aus und visualisieren Sie in QGIS???
1. alle L??nder des Kontinents Europa ([L??sung](./scripts/Geo%20Hausaufgabe%201%20a%20Musterl??sung.sql))
2. alle L??nder, in denen Englisch offizielle Amtssprache ist ([L??sung](./scripts/Geo%20Hausaufgabe%201%20b%20Musterl??sung.sql))
3. alle St??dte, in denen Spanisch offizielle Amtssprache ist ([L??sung](./scripts/Geo%20Hausaufgabe%201%20c%20Musterl??sung.sql))
