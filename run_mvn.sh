#!/bin/bash
mvn exec:java -Dexec.mainClass=tests.Connect -Dexec.args="-h localhost -p 5432 -t 30 -w 5" -f pom.xml