#!/bin/bash
echo "$1 $2 $3";
db2 "connect to $1 user $2 using $3";
db2 "CREATE TABLE Portfolio(owner VARCHAR(32) NOT NULL, total DOUBLE, loyalty VARCHAR(8), PRIMARY KEY(owner))";
db2 "CREATE TABLE Stock(owner VARCHAR(32) NOT NULL, symbol VARCHAR(8) NOT NULL, shares INTEGER, price DOUBLE, total DOUBLE, dateQuoted DATE, FOREIGN KEY (owner) REFERENCES Portfolio(owner) ON DELETE CASCADE, PRIMARY KEY(owner, symbol))";
db2 "quit";