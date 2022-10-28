#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
  echo Este es un test

  echo $($PSQL "truncate teams, games")

  cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
  do 
    if [[ $YEAR != "year" ]]
    then
      #get team_id
      TEAM_ID_1=$($PSQL "select team_id from teams where name='$WINNER'")
      TEAM_ID_2=$($PSQL "select team_id from teams where name='$OPPONENT'")
      #if not found
      if [[ -z $TEAM_ID_1 ]]
      then
        #insert team
        INSERT_TEAM_1=$($PSQL "insert into teams(name) values ('$WINNER')")
        echo Se inserto $WINNER
      fi
      if [[ -z $TEAM_ID_2 ]]
      then
        #insert team
        INSERT_TEAM_2=$($PSQL "insert into teams(name) values ('$OPPONENT')")
        echo Se inserto $OPPONENT
      fi

      WINNER_ID=$($PSQL "select team_id from teams where name='$WINNER'")
      OPPONENT_ID=$($PSQL "select team_id from teams where name='$OPPONENT'")

      INSERT_GAMES=$($PSQL "insert into games (year, round, winner_id, opponent_id, winner_goals, opponent_goals) values ('$YEAR', '$ROUND', '$WINNER_ID', '$OPPONENT_ID', '$WINNER_GOALS', '$OPPONENT_GOALS')") 

      echo Se inserto $YEAR, $ROUND, $WINNER_ID, $WINNER, $OPPONENT_ID, $OPPONENT, $WINNER_GOALS, $OPPONENT_GOALS

    fi
  done


else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"

  cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
  do 
    if [[ $YEAR != "year" ]]
    then
      #get team_id
      TEAM_ID_1=$($PSQL "select team_id from teams where name='$WINNER'")
      TEAM_ID_2=$($PSQL "select team_id from teams where name='$OPPONENT'")
      #if not found
      if [[ -z $TEAM_ID_1 ]]
      then
        #insert team
        INSERT_TEAM_1=$($PSQL "insert into teams(name) values ('$WINNER')")
        echo Se inserto $WINNER
      fi
      if [[ -z $TEAM_ID_2 ]]
      then
        #insert team
        INSERT_TEAM_2=$($PSQL "insert into teams(name) values ('$OPPONENT')")
        echo Se inserto $OPPONENT
      fi

      WINNER_ID=$($PSQL "select team_id from teams where name='$WINNER'")
      OPPONENT_ID=$($PSQL "select team_id from teams where name='$OPPONENT'")

      INSERT_GAMES=$($PSQL "insert into games (year, round, winner_id, opponent_id, winner_goals, opponent_goals) values ('$YEAR', '$ROUND', '$WINNER_ID', '$OPPONENT_ID', '$WINNER_GOALS', '$OPPONENT_GOALS')") 

      echo Se inserto $YEAR, $ROUND, $WINNER_ID, $WINNER, $OPPONENT_ID, $OPPONENT, $WINNER_GOALS, $OPPONENT_GOALS
    fi
  done
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
