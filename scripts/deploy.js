async function main() {
    // Get the contract factory
    const DigitalPet = await ethers.getContractFactory("DigitalPet");

    // Deploy the contract
    const digitalPet = await DigitalPet.deploy();

    // Wait for the contract to be deployed
    await digitalPet.waitForDeployment();

    console.log("DigitalPet deployed to:", await digitalPet.getAddress());
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
