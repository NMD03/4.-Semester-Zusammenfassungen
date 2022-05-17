# Datenbanken <!-- omit in toc -->
Dieses File beinhaltete eine kleine Zusammenfassung der Vorlesung Datenbanken
# Inhaltsverzeichnis <!-- omit in toc -->
- [SQL-Befehle](#sql-befehle)
  - [SELECT](#select)
    - [Aufbau](#aufbau)
    - [Berechnungen](#berechnungen)
    - [Datum](#datum)
    - [Stringfunktionen](#stringfunktionen)
  - [CASE (SELECT ohne Tabelle)](#case-select-ohne-tabelle)
    - [Aufbau](#aufbau-1)
    - [Beispiele](#beispiele)
  - [JOIN](#join)
  - [CTEs](#ctes)
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
1. SELECT
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

## JOIN
## CTEs

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