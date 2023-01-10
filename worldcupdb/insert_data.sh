#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# drop all tables prior to running script
$PSQL "TRUNCATE TABLE games, teams"

# Add each unique team to the teams table
{
	read
	while IFS=, read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
	do
		WINNER_EXISTS="$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")"
		OPP_EXISTS="$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")"
		if [[ -z $WINNER_EXISTS ]]
		then
			$PSQL "INSERT INTO teams(name) VALUES('$WINNER')"
		elif [[ -z $OPP_EXISTS ]]
		then
			$PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')"
		fi
	done
} < games.csv

# Insert row for each line in games.csv (other than top of line of the file)
{
	read
	while IFS=, read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
	do
		OPP_ID="$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT'")"
		WINNER_ID="$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER'")"
		$PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPP_ID, $WINNER_GOALS, $OPPONENT_GOALS)"
	done
} < games.csv
	
