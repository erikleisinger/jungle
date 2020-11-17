const players = [
  { winner: 'Alice', loser: 'Bob',   loser_points: 3 },
  { winner: 'Carol', loser: 'Dean',  loser_points: 1 },
  { winner: 'Elise', loser: 'Bob',   loser_points: 2 },
  { winner: 'Elise', loser: 'Carol', loser_points: 4 },
  { winner: 'Alice', loser: 'Carol', loser_points: 2 },
  { winner: 'Carol', loser: 'Dean',  loser_points: 3 },
  { winner: 'Dean',  loser: 'Elise', loser_points: 2 },
]

const gamePlayers = function(players) {

  const sortedPlayers = players.reduce((acc, currentValue) => {
    if (!acc.includes(currentValue.winner)) {
      acc.push(currentValue.winner)
    }
    if (!acc.includes(currentValue.loser)) {
      acc.push(currentValue.loser)
    }
    return acc
  }, [])
  return sortedPlayers.sort()
}

const winners = function(players) {
  const playersArray = gamePlayers(players)
  // ['Alice', 'Bob', 'Carol', 'Dean', 'Elise']
  return playersArray.reduce((acc, winner) => {
    acc[winner] = [];
    players.forEach((match) => {
      if (match.winner === winner && !acc[winner].includes(match.loser)) {
        acc[winner].push(match.loser)
      }
    })
    return acc;
  }, {})

}

console.log(winners(players));

// console.log(gamePlayers(players))

// ['Alice', 'Bob', 'Carol', 'Dean', 'Elise']

//  {
//   'Alice': ['Bob', 'Carol'],
//   'Bob':   [],
//   'Carol': ['Dean'],
//   'Dean':  ['Elise'],
//   'Elise': ['Bob', 'Carol'],
// }