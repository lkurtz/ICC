// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Casino {
    address public owner;
    address[] public players;
    uint256 public gameStartTime;
    uint256 public gameDuration = 3 minutes;  // Le jeu dure maintenant 3 minutes
    bool public countdownStarted = false;
    bool public winnerRequested = false;

    event GameStarted(uint256 startTime, uint256 duration);
    event PlayerJoined(address indexed player);
    event WinnerRequested(uint256 requestId);
    event WinnerSelected(address indexed winner, uint256 prize);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, unicode"Not owner");
        _;
    }

    function enterGame() public payable {
        require(msg.value > 0, unicode"Mise obligatoire");
        players.push(msg.sender);
        emit PlayerJoined(msg.sender);

        // Démarrer le timer si deux joueurs ont rejoint la partie
        if (players.length == 2 && !countdownStarted) {
            gameStartTime = block.timestamp;
            countdownStarted = true;
            emit GameStarted(gameStartTime, gameDuration);
        }
    }

    function isGameOver() public view returns (bool) {
        return countdownStarted && (block.timestamp >= gameStartTime + gameDuration);
    }

    function pickWinner() public onlyOwner {
        require(isGameOver(), unicode"Le jeu n'est pas terminé");
        require(players.length >= 2, unicode"Pas assez de joueurs");

        uint256 winnerIndex = random() % players.length;
        address winner = players[winnerIndex];
        uint256 prize = address(this).balance;

        payable(winner).transfer(prize);
        emit WinnerSelected(winner, prize);

        // Reset du jeu
        resetGame();
    }

    // Aléatoire simple sans Chainlink parceque l'import marche pas ca casse les couilles
    function random() internal view returns (uint256) {
    // prevrandao car difficulty remplacé par ca
       return uint256(keccak256(abi.encodePacked(block.timestamp, block.prevrandao, players.length)));}

    function getPlayers() external view returns (address[] memory) {
        return players;
    }

    function resetGame() internal {
        delete players;
        countdownStarted = false;
        winnerRequested = false;
    }
}
