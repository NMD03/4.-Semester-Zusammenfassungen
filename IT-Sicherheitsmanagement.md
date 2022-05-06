# IT-Sicherheitsmanagement <!-- omit in toc -->
Dieses File beinhaltete eine kleine Zusammenfassung der Vorlesung [IT-Sicherheitsmanagement](https://app.mural.co/t/muralworkspace0660/m/muralworkspace0660/1649403349728/628afc077b71280e3990441f323e0eb96e9fb9a7?sender=u97fae70e91dca3860c9e8161).
# Inhaltsverzeichnis <!-- omit in toc -->
- [Der Fall Buchbinder](#der-fall-buchbinder)
  - [Mögliche Ursachen](#mögliche-ursachen)
  - [Gegenmaßnahmen](#gegenmaßnahmen)
- [Exkurs: ISMS-Vergleich](#exkurs-isms-vergleich)
- [Exkurs: S-Protect](#exkurs-s-protect)
- [ISMS](#isms)

# [Der Fall Buchbinder](https://app.mural.co/t/muralworkspace0660/m/muralworkspace0660/1649403544278/ca053bed349485fd3eb457c9abc74d249721bb3c?sender=u97fae70e91dca3860c9e8161)

## Mögliche Ursachen
- Kostenersparnis im Bereich IT
- Fehlendes Fachwissen
- evtl. historisch gewachsen (SMB)
- Verfügbarkeit > Sicherheit
- Weg über die IT-Abteilung zu aufwendig
- Schatten IT
- fehlende Governance

## Gegenmaßnahmen
|Richtlinien/Prozesse|Präventiv|Detektiv|
|---|---|---|
|Prozesse und Data Lifecycle klar definieren|Ursache: Nachlässigkeit bei Config, Update, Debug|Audits|
|Service Level Agreement mit dem Server-Betreiber|Regelmäßige, automatisierte Scans des eigenen Netzwerks|Zusammenarbeit mit dem Sicherheitsexperten|
|Klassifizierung (SBF)|Vuln Scans etablieren|Auf Warnungen frühzeitig reagieren|
|Aufbewahrung (wo / wie lange) (Löschkonzept)|DB mit  Passwort schützen|Themen: Incident Response, Security 101, Datenumgang, Webbased Training|
|Vorgaben für Benutzername / Passwort|SMB Port blockieren|Penetrationstests|
|Berechtigungs-konzept|Backup verschlüsseln|
| |Baseline-Konfiguration / Härtung|
| |VPN-verbindung zum Server aufbauen|
| |Generelle Schulung der Mitarbeiter|

# Exkurs: [ISMS-Vergleich](https://app.mural.co/t/muralworkspace0660/m/muralworkspace0660/1650627698169/6c1698b2f4ecc70b2a05bb37584d6326040b7ca0?sender=ub64e6270e8be28f188f38372)


# Exkurs: [S-Protect](https://app.mural.co/t/muralworkspace0660/m/muralworkspace0660/1651821857612/2f18d6ec811388f090a85ebc6bc3fd93d7f257c6?sender=u97fae70e91dca3860c9e8161)
|Pro|Contra|
|---|---|
|weniger Phsising anfällig|suggeriert absolute Sicherheit
|auf aktuellen OS verfügbar|zusätzliches Tool, welches geupdated werden muss
|keine Kosten|keine Auskunft über technische Details
| einfache Bedienung|keine Zertifikate|
| |integrierter Password Manager + keine Tan -> alle Informationen auf einem Gerät

![](./img/Dreieck.png)

-> Risiken überwiegen<br> 
-> auf keinen Fall im Business-Umfeld

# [ISMS](https://app.mural.co/t/muralworkspace0660/m/muralworkspace0660/1651832952585/bb799f32fbde1461e87e042e33d55374d1e06ebe?sender=u97fae70e91dca3860c9e8161)

