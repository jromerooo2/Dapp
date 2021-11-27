const { expect } = require('chai');


describe("MyPunks Contract", () => {
        const setup = async ({ maxSupply = 10000 }) => {
        const [owner] = await ethers.getSigners();
        const PlatziPunks = await ethers.getContractFactory("MyPunk");
        const deployed = await PlatziPunks.deploy(maxSupply);
    
        return {
            owner,
            deployed,
        };
        };
    
        describe("Deployment", () => {
        it("Sets max supply to passed param", async () => {
            const maxSupply = 4000;
    
            const { deployed } = await setup({ maxSupply });
    
            const returnedMaxSupply = await deployed.MaxSupply();
            expect(maxSupply).to.equal(returnedMaxSupply);
        });
        });

        describe("Minting", () => {
            it("Should Mint and assign it to message sender", async()=>{
                const { owner, deployed } = await setup({ });

                await deployed.mint();
                
                const ownerOfMinted = await deployed.ownerOf(0);
                expect(ownerOfMinted).to.equal(owner.address);

            })
            it("Should")
        });
}); 