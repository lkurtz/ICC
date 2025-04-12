# ICC (Symfony + Blockchain)

## Description

ICC est une application qui combine un backend Symfony avec une solution blockchain utilisant Hardhat. 
Elle permet de gérer un jeu de casino basé sur la blockchain, où les utilisateurs peuvent se connecter via leur portefeuille RabbiWallet, participer à des jeux et interagir avec un smart contract. 

---

## Prérequis

Avant de commencer, vous devez avoir installé les outils suivants sur votre machine :

- [Docker](https://www.docker.com/get-started)
Pour faciliter le lancement de l'application et l'utilisation de Docker, la lancer sur un système Linux.
- [Docker Compose](https://docs.docker.com/compose/)
- [Node.js](https://nodejs.org/) (pour npx et Hardhat)
- [Symfony CLI](https://symfony.com/download) (facultatif, peut être remplacé par `composer`)
- [Hardhat](https://hardhat.org/) (pour la gestion smart contract)

---

## Lancer l'application

### 1. Lancer le serveur Symfony

Depuis le répertoire du projet, exécutez cette commande pour lancer le serveur Symfony :
```
symfony serve
```
Cela démarrera le serveur Symfony sur http://localhost:8000.

Si vous n'avez pas installé Symfony CLI, vous pouvez utiliser php -S localhost:8000 -t public/ ou un autre serveur web compatible.

### 2. Lancer Docker et la base de données
L'application utilise Docker et Docker Compose pour gérer les services. Pour démarrer tous les services, exécutez la commande suivante :
```
docker compose up -d
```
Cela va lancer tous les conteneurs nécessaires en arrière-plan (base de données, services tiers, etc.).

### 3. Lancer le réseau Hardhat
Pour interagir avec la blockchain, Hardhat crée un réseau local. Exécutez la commande suivante pour démarrer Hardhat :
```
npx hardhat node
```
Cela lancera un nœud local Hardhat sur le port 8545. Vous pourrez y déployer votre contrat et interagir avec la blockchain.

### 4. Déployer le contrat
Assurez-vous que votre nœud Hardhat est lancé, puis déployez votre contrat avec cette commande :
```
npx hardhat run scripts/deploy.js --network localhost
```
Cela déploiera le smart contract sur le réseau local Hardhat. Vous pourrez interagir avec ce smart contract via l'application Symfony.

## Fonctionnalités
L'application permet de gérer un jeu de casino blockchain :

Inscription des joueurs : Les utilisateurs peuvent rejoindre un jeu en envoyant des fonds.

Jeu avec durée : Le jeu commence dès qu'il y a deux joueurs et dure 3 minutes.

Sélection du gagnant : Une fois la durée du jeu écoulée, un gagnant est sélectionné au hasard, et il remporte le solde du jeu.

Smart contract Ethereum : Le jeu est géré par un smart contract déployé sur un réseau local via Hardhat.

## Problématiques
Le contrat compile et se déploie bien, l'inscription et la connexion également, ainsi que la connexion au Wallet.
Le problème a été de trouver un autre random pour le nombre aléatoire, les imports de chainlick ne fonctionnant pas.
Également, même après la connexion au Wallet, la monnaie n'est pas reconnue et il n'est donc pas possible de jouer.
