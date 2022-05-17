#!/bin/bash


PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"
NUMBER_TO_BE_GUESSED=$(( 1 + $RANDOM % 1000 ))
GUESS_COUNT=0

GET_GUESS() {
  echo $1
  read GUESS

  while ! [[ "$GUESS" =~ ^[0-9]+$ ]]
  do
    echo "That is not an integer, guess again:"
    read GUESS
  done

  ((GUESS_COUNT++))

  while [[ $GUESS -ne $NUMBER_TO_BE_GUESSED ]]
  do
    if [[ $GUESS -gt $NUMBER_TO_BE_GUESSED ]]
    then
      GET_GUESS "It's lower than that, guess again:"
    else
      GET_GUESS "It's higher than that, guess again:"
    fi
  done
}

INSERT_DATA() {
if [[ -z $BEST_SCORE ]]
then
  INSERT_INTO_RESULT=$($PSQL "INSERT INTO games(user_id, best_score, total_games) VALUES($USER_ID, $NEW_SCORE, 1)")
else
  #Had to use full command rather that $PSQL for some unknown reason
  UPDATE_INFO_RESULT=$($PSQL "UPDATE games SET (best_score, total_games) = ($NEW_SCORE, total_games + 1) WHERE user_id = $USER_ID")
fi
}

echo "Enter your username:"
read USERNAME

USERINFO=$($PSQL "SELECT users.user_id, best_score, total_games FROM users INNER JOIN games ON users.user_id = games.user_id WHERE name = '$USERNAME'")

if [[ -z $USERINFO ]]
then
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  INSERT_USER_RESULT=$($PSQL "INSERT INTO users(name) VALUES ('$USERNAME')")
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE name = '$USERNAME'")

else
  IFS='|' read USER_ID BEST_SCORE TOTAL_GAMES <<< "$USERINFO"
  echo "Welcome back, $USERNAME! You have played $TOTAL_GAMES games, and your best game took $BEST_SCORE guesses."
fi

GET_GUESS "Guess the secret number between 1 and 1000:"

echo "You guessed it in $GUESS_COUNT tries. The secret number was $NUMBER_TO_BE_GUESSED. Nice job!"

if [[ -z $BEST_SCORE ]] || [[ $BEST_SCORE -gt $GUESS_COUNT ]]
then
  NEW_SCORE=$GUESS_COUNT
else
  NEW_SCORE=$BEST_SCORE
fi

INSERT_DATA

