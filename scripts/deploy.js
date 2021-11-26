

const deploy = async () => {
    const [deployer] = await ethers.getSigners();

    console.log("Deploying with: ", deployer.address);

    const MyPunk = await ethers.getContractFactory("MyPunk");
    const addressPunk = await MyPunk.deploy();
    console.log("Deployed at ", addressPunk.address);

};


deploy()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });