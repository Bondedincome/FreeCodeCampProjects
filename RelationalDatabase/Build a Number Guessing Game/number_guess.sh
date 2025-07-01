#!/bin/bash


Main () {
  while true
  do
  if [[ ! $USER_GUESS =~ ^[0-9]+$ ]]
  then
    echo -e "That is not an integer, guess again:"
    ((NUMBER_OF_GUESSES++))
    read USER_GUESS
  elif [[ $USER_GUESS < $SECRET_NUMBER ]]
  then
    echo -e "It's higher than that, guess again:"
    ((NUMBER_OF_GUESSES++))
    read USER_GUESS
  elif [[ $USER_GUESS > $SECRET_NUMBER ]]
  then
    echo -e "It's lower than that, guess again:"
    ((NUMBER_OF_GUESSES++))
    read USER_GUESS
  else
    echo -e "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
    UPDATE_GAMES_PLAYED=$($PSQL "UPDATE users SET games_played = games_played + 1 WHERE username = '$USERNAME';")
    if [[ -z $BEST_GAME || $BEST_GAME > $NUMBER_OF_GUESSES ]]
    then
      UPDATE_BEST_GAME=$($PSQL "UPDATE users SET best_game = $NUMBER_OF_GUESSES WHERE username='$USERNAME' AND (best_game is null OR best_game > $NUMBER_OF_GUESSES);")
    fi
    break
  fi
  done
}

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

SECRET_NUMBER=$(( 1 + $RANDOM % 1000 ))

echo -e "Enter your username:"
read USERNAME

USERNAME_RESULT=$($PSQL "SELECT * FROM users WHERE username ='$USERNAME';")

if [[ -z $USERNAME_RESULT ]]
then
  INSERT_USERNAME=$($PSQL "INSERT INTO users(username, games_played) VALUES ('$USERNAME', 0)")
  echo -e "Welcome, $USERNAME! It looks like this is your first time here."
  echo -e "Guess the secret number between 1 and 1000:"
  read USER_GUESS
  NUMBER_OF_GUESSES=1

  Main

else
  IFS="|" read -r USERNAME GAMES_PLAYED BEST_GAME <<< "$USERNAME_RESULT"
  echo -e "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  echo -e "Guess the secret number between 1 and 1000:"
  read USER_GUESS
  NUMBER_OF_GUESSES=1

  Main
fi