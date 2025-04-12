const hre = require("hardhat");

async function main() {
    const [deployer] = await hre.ethers.getSigners();

    console.log("Déploiement avec le compte :", deployer.address);

    const Casino = await hre.ethers.getContractFactory("Casino");
    const casino = await Casino.deploy();

    await casino.waitForDeployment();

    console.log("Casino déployé à l'adresse :", await casino.getAddress());
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
