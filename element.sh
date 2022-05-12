#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ -z $1 ]]
then
  echo -e "Please provide an element as an argument."
else
 if [[ "$1" =~ ^[0-9]+$ ]]
  then
    LOOKUP=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM properties FULL JOIN elements USING (atomic_number) FULL JOIN types USING (type_id) WHERE atomic_number = $1")
  elif [[ "$1" =~ ^[a-zA-Z]{1,2}$ ]]
  then
    LOOKUP=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM properties FULL JOIN elements USING (atomic_number) FULL JOIN types USING (type_id) WHERE symbol = '$1'")
  elif [[ "$1" =~ ^[a-zA-Z]{3,}$ ]]
  then
    LOOKUP=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM properties FULL JOIN elements USING (atomic_number) FULL JOIN types USING (type_id) WHERE name = '$1'")
  fi
  if [[ -z $LOOKUP ]]
  then
    echo -e "I could not find that element in the database."
  else
    echo "$LOOKUP" | (read ATOMIC_NUMBER BAR NAME BAR SYMBOL BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT;
    echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius.")
  fi
fi
