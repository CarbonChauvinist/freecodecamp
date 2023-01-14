#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess --tuples-only --csv --command"

# generate random number between 1 and 1000
SECRET=$((RANDOM % 1001))

GUESS_TOO_HIGH="It's lower than that, guess again:"
GUESS_TOO_LOW="It's higher than that, guess again:"
GUESS_NOT_INT="That is not an integer, guess again:"

# keep track of number of guesses
COUNTER=0

echo "Enter your username:"
read SELECTED_USERNAME

USERNAME_EXISTS="$($PSQL "SELECT count(*) FROM games WHERE username = '$SELECTED_USERNAME'")"

if [[ $USERNAME_EXISTS -gt 0 ]]; then
  RETURNING_USER="$($PSQL "SELECT username, games_played, best_game FROM games WHERE username = '$SELECTED_USERNAME'")"
  IFS=, read USERNAME GAMES_PLAYED BEST_GAME <<<"$RETURNING_USER"
  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
else
  echo "Welcome, $SELECTED_USERNAME! It looks like this is your first time here."
fi

echo "Guess the secret number between 1 and 1000:"
while [[ $GUESS -ne $SECRET ]]; do
  read GUESS
  # handle if input is not an integer
  if [[ ! $GUESS =~ ^[[:digit:]]+$ ]]; then
    echo "$GUESS_NOT_INT" && continue
  fi
  ((COUNTER += 1))
  if [[ $GUESS -lt $SECRET ]]; then
    echo "$GUESS_TOO_LOW"
  elif [[ $GUESS -gt $SECRET ]]; then
    echo "$GUESS_TOO_HIGH"
  else
    # update username stats in db
    # if new user insert into db
    if [[ -z $RETURNING_USER ]]; then
      INSERT_NEW_USER_RESULT="$($PSQL "INSERT INTO games(username, games_played, best_game) VALUES('$SELECTED_USERNAME', 1, $COUNTER)")"
    # if returning user update records
    else
      ((GAMES_PLAYED += 1))
      UPDATE_GAMES_PLAYED_RESULT="$($PSQL "UPDATE games SET games_played = $GAMES_PLAYED WHERE username = '$USERNAME'")"
      if [[ $BEST_GAME -lt $COUNTER ]]; then
        UPDATE_BEST_GAMES_RESULT="$($PSQL "UPDATE games SET best_game = $BEST_GAME WHERE username = '$USERNAME'")"
      else
        UPDATE_BEST_GAMES_RESULT="$($PSQL "UPDATE games SET best_game = $COUNTER WHERE username = '$USERNAME'")"
      fi
    fi
    echo "You guessed it in $COUNTER tries. The secret number was $SECRET. Nice job!" && exit
  fi
done

