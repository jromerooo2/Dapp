const { expect } = require('chai');


describe("MyPunks Contract", () => {
        const setup = async ({ MaxSupply = 2 }) => {
        const [owner] = await ethers.getSigners();
        const PlatziPunks = await ethers.getContractFactory("MyPunk");
        const deployed = await PlatziPunks.deploy(MaxSupply);
    
        return {
            owner,
            deployed,
        };
        };
    
        describe("Deployment", () => {
        it("Sets max supply to passed param", async () => {
            const MaxSupply = 4000;
    
            const { deployed } = await setup({ MaxSupply });
    
            const returnedMaxSupply = await deployed.MaxSupply();
            expect(MaxSupply).to.equal(returnedMaxSupply);
        });
        });

        describe("Minting", () => {
            it("Should Mint and assign it to message sender", async()=>{
                const { owner, deployed } = await setup({ });

                await deployed.mint();
                
                const ownerOfMinted = await deployed.ownerOf(0);
                expect(ownerOfMinted).to.equal(owner.address);

            })
            it("Should have a minting limit", async()=>{
                const MaxSupply = 2;

                const { deployed } = await setup({ MaxSupply });
          
                // Mint all
                await Promise.all([deployed.mint(), deployed.mint()]);
          
                // Assert the last minting
                await expect(deployed.mint()).to.be.revertedWith(
                  "No Punks left :("
                );
              });
        });
}); 