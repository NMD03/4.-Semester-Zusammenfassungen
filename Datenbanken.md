# Datenbanken <!-- omit in toc -->
Dieses File beinhaltete eine kleine Zusammenfassung der Vorlesung Datenbanken
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
  - [Postgis](#postgis)
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
- Verknüpfen: ``SELECT CONCAT('Hier', 'steht', 'Text')``
- Ausschneiden: 
  - ``SELECT LEFT('Hier steht Text', 7)`` 
  - ``SELECT RIGHT('Hier steht Text', 7)``
  - ``SELECT SUBSTRlNG('Hier steht Text', 1, 4)``
- Finden: ``SELECT PATINDEX('%steht%', 'Hier steht Text')``
- Ersetzen: ``SELECT REPLACE('Hier steht Text', 'steht', 'stand')`` 
- Trimmen: ``SELECT TRIM(' Leerzeichen vorne und hinten ')``
- Länge ermitteln: ``SELECT LEN('Beispieltext')``
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
SELECT CASE WHEN 1<2 THEN 'Größer' ELSE 'Kleiner' END
```
``` sql
SELECT CASE WHEN 3<2 THEN 'Größer' ELSE 'Kleiner' END 
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
Die Ordnung erfolgt absteigend -> zuerst große Zahlen bzw. Buchstaben am Ende des Alphabets
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
Dient zur Verknüpfung meherer Tabellen miteinander anahnd einer Bedingung (oft Gleichheit von Primär- und Fremdschlüsseln)
### Aufbau 
1. SELECT
2. FROM **inkl. JOINs**
3. WHERE
4. ORDER BY
### INNER JOIN
> Datensätze beider Tabellen werden anhand der Bedingung 
verbunden, d.h. die Datensätze beider Tabellen müssen diese erfüllen 
``` sql
SELECT * 
FROM Politiker 
JOIN Partei ON Politiker.Partei = Partei.ID
```
![inner JOIN](./img/inner%20join.png)
### RIGTH/LEFT JOIN
>  Datensätze beider Tabellen werden anhand der 
Bedingung verbunden und zusätzlich alle Datensätze der rechten/linken 
Tabelle, auch wenn diese nicht die Bedingung erfüllen

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
> Datensätze beider Tabellen werden anhand der 
Bedingung verbunden und zusätzlich alle Datensätze der rechten und 
linken Tabelle, auch wenn diese nicht die Bedingung erfüllen
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
Verändert einen bestehenden Datensatz
```sql
UPDATE <Tabelle> SET <Spalte> = <neuer_Wert>
```
-> verändert alle Werte einer Spalte daher:
```sql
UPDATE <Tabelle> SET <Spalte> = <neuer_Wert> WHERE <Bedingung>
```
## DELETE
Löscht Datensätze aus Tabellen:
```sql
DELETE FROM  <Tabelle> WHERE <Bedingung>
```
-> ohne WHERE wird die komplette Tabelle gelöscht

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

Auch mit SELECT Abfrage möglich:
```sql
CREATE TABLE admin_.Mark
SELECT f.title, ac.actor_id, ac.first_name, ac.last_name
FROM sakila.actor ac
JOIN sakila.film_actor fa ON fa.actor_id = ac.actor_id
JOIN sakila.film f ON f.film_id = fa.film_id
WHERE ac.first_name = 'Nick' AND ac.last_name = 'Wahlberg';
```
## ALTER
Verändert ganze Spalten von Tabellen:
1. Löscht Spalte:
   ```sql
   ALTER TABLE <Tabelle> DROP COLUMN <Spalte>;
   ```
2. Fügt Spalte hinzu:
   ```sql
   ALTER TABLE <Tabelle> ADD <Spalte> <Datentyp>;
   ```
3. Verändert Spalte:
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
IF(CategoryName IN('Condiments','Confections'), 'süß', 'nicht süß')
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
WHEN name IN ('Action', 'Thriller', 'Drama', 'Horror') THEN 'NIcht für Kinder geeignet'
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
-> Diese Art der Unterabfrage muss einen **Skalarwert** zurückgeben (**eine Zeile und Eine Spalte** -> nur eine Spalte zurückgeben und LIMIT auf 1 setzen)
### Unterabfragen in FROM
**Aufbau**:
```sql
SELECT *
FROM (SELECT s1,s2,s3 FROM t2) t1;
``` 
-> FROM Unterabfragen werden mit einem Alias benannt und können wie normale Tabellen behandelt werden <br>
-> mehrfache verschachtelung möglich
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
-> ``IN``, ``SOME`` und ``ANY`` sind Synonyme (TRUE wenn Vergleich mit mind einem Element der Unterabfrage erfüllt ist)<br>
-> ``NOT IN`` ist Abkürzung für ``<> ALL`` oder ``!= ALL``
### EXISTS-Unterabfragen in WHERE
**Aufbau**:
```sql
SELECT * 
FROM t1
WHERE (NOT) EXISTS <Unterabfrage>
```
-> ``EXISTS`` ist TRUE wenn die Unterabfrage mind. einen Wert zurückliefert <br>
-> ``NOT EXISTS`` ist TRUE wenn die Unterabfrage keine Werte zurückliefert

## Ergebnismengenoperationen
### Aufbau
```sql
<Abfrage1> UNION (ALL) <Abfrage2> UNION (ALL) <Abfrage3> ...
```
-> Kombiniert Ergebnismenge mehrerer Abfragen <br>
-> ``UNION`` entfernt doppelte Zeilen (ähnlich zu ``SELECT DISTINCT``)<br>
-> ``UNION ALL`` includiert doppelte Zeilen


## Common Table Expression (CTE)
### Aufbau
```sql
WITH <CTE-Name> AS <SELECT-Abfrage>
```
-> speichert Abfragen für Mehrfachnutzung (ähnlich wie VIEW)<br>
-> Mehrere CTEs hintereinander werden mit Komma getrennt<br>
-> CTEs können aufeinander aufbauen (Reihenfolge beachten)

# ERM Diagramme
ER-Diagramme werden zur Visualisierung der Verbindungen in einer relationalen Datenbank genutzt. Dabei werden grundlegend zwischen 3 verschiedenen Relationen/Beziehung zwischen den Entitäten unterschieden:
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
### World GDP
### World Population
## Postgis
## Hausaufgabe