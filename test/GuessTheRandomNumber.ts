import { expect } from "chai";
import { ethers } from "hardhat";

describe("GuessTheRandomNumberChallenge Test", function () {
    it("Should hack the contract", async function () {
        const [owner, hacker] = await ethers.getSigners();

        const GuessTheRandomNumber = await ethers.getContractFactory("GuessTheRandomNumberChallenge");
        const guessran = await GuessTheRandomNumber.connect(owner).deploy({value: ethers.utils.parseEther("1")});
        await guessran.deployed();

        const answer = await ethers.provider.getStorageAt(guessran.address, 0);
        await guessran.connect(hacker).guess(parseInt(answer, 16), {value: ethers.utils.parseEther("1")});
        expect(await guessran.isComplete()).to.be.true;
    })
});