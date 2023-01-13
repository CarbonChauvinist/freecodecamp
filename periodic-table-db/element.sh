#!/bin/bash

PSQL="psql -U freecodecamp -d periodic_table --csv --quiet --tuples-only --command"
BASE_QUERY="SELECT e.atomic_number, e.name, e.symbol, t.type, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius FROM elements as e INNER JOIN properties AS p USING(atomic_number) INNER JOIN types AS t USING(type_id)"
DOES_NOT_EXIST="I could not find that element in the database."

if [[ $# == 0 ]]; then
	echo "Please provide an element as an argument."
	exit
fi

# if arg is int search atomic_number
if [[ "$1" =~ ^[[:digit:]]+$ ]]; then
	ATOMIC_NUMBER_INPUT=$1
	ATOMIC_NUMBER_EXISTS="$($PSQL "SELECT count(*) FROM elements WHERE atomic_number = $ATOMIC_NUMBER_INPUT")"
	if [[ $ATOMIC_NUMBER_EXISTS -gt 0 ]]; then
		DISPLAY_QUERY="$($PSQL "$BASE_QUERY WHERE e.atomic_number = $ATOMIC_NUMBER_INPUT")"
	else
		echo "$DOES_NOT_EXIST" && exit
	fi
# if arg is two or less characters search symbol
elif [[ ${#1} -le 2 ]]; then
	SYMBOL_INPUT="$1"
	SYMBOL_EXISTS="$($PSQL "SELECT count(*) FROM elements WHERE symbol = '$SYMBOL_INPUT'")"
	if [[ $SYMBOL_EXISTS -gt 0 ]]; then
		DISPLAY_QUERY="$($PSQL "$BASE_QUERY WHERE e.symbol = '$SYMBOL_INPUT'")"
	else
		echo "$DOES_NOT_EXIST" && exit
	fi
# otherwise search name
else
	ELEMENT_NAME_INPUT="$1"
	ELEMENT_NAME_EXISTS="$($PSQL "SELECT count(*) FROM elements WHERE name = '$ELEMENT_NAME_INPUT'")"
	if [[ $ELEMENT_NAME_EXISTS -gt 0 ]]; then
		DISPLAY_QUERY="$($PSQL "$BASE_QUERY WHERE e.name = '$ELEMENT_NAME_INPUT'")"
	else
		echo "$DOES_NOT_EXIST" && exit
	fi
fi

IFS=, read ATOMIC_NUMBER ELEMENT_NAME SYMBOL TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT <<< "$(echo "$DISPLAY_QUERY")"

echo "The element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME ($SYMBOL). It's a nonmetal, with a mass of $ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
