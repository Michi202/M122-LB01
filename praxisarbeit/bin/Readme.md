# Backup Script

## Verwendung
Um das backup script zu verwenden muss einfach backup.sh mit bash ausgeführt werden.
Danach erstellt das Skript die Backups der gruppen so, wie es in der Konfiguration gespeichert ist.
Es wird auch ein `.log` File erstellt, welches Informationen über den Verlauf festhält.
**WICHTIG** Alle Konfig und Skrip-Files sollten am gleichen Ort sein.

## Konfiguration
Das Skript hat ein Haup-Konfig file welches `backup_config.config` heisst.
Alle Konfigurationsoptionen sind innerhalb der [Sample-Datei](https://github.com/Michi202/M122-LB01/blob/master/praxisarbeit/etc/backup_config.conf.sample) beschrieben.
**WICHTIG** Alle Pfäde innerhalb der Konfigurationsdatei müssen absolut sein.

## Gruppen
Die Gruppen für welche ein Backup erstellt werden soll, müssen in einem `.txt` File festgehalten werden.
Ein Beispiel kann kann [hier](https://github.com/Michi202/M122-LB01/blob/master/praxisarbeit/etc/groups.txt) gefunden werden.

## Ausnahmen
Es können Ausnahmen für ordner oder Files von Gruppen gemacht werden.
Diese sollen folgendem format folgen: `gruppenname_exclusions.txt`
Die Ausnahmen werden dem Home-Verzeichnis der einzelnen Benutzer angehängt.
Ein Beispiel kann [hier](https://github.com/Michi202/M122-LB01/blob/master/praxisarbeit/etc/sampleGroup1_exclusions.txt) gefunden werden.
**WICHTIG** Diese Exclusion-Dateien müssen am gleichen Ort wie das backup_functions.sh abgelegt werden.

## Abhängigkeiten
Das Skript verwendet den members Command, welcher mit `sudo apt-get install` members installiert werden