import { expect } from "chai";
import { ethers } from "hardhat";
import { utils } from "ethers";

describe("Mapping Test", function () {
    it("Should set isComplete to true", async function () {
        const [owner, hacker] = await ethers.getSigners();

        const Mapping = await ethers.getContractFactory("MappingChallenge");
        const map = await Mapping.connect(owner).deploy();
        await map.deployed();


        // the array items wrap around after they reached the max storage slot of 2^256 - 1.
        // so 2**256 = 0, 2**256 + 1 = 1

        // need to find array index that maps to 0 mod 2^256
        // i.e., keccak(1) + index mod 2^256 = 0
        // <=> index = -keccak(1) mod 2^256
        // => index = 2^256 - keccak(1) as keccak(1) is in range//
        
        // all of contract storage is a 32 bytes key to 32 bytes value mapping
        // first make map expand its size to cover all of this storage by setting
        // key = 2^256 - 2 => map.length = 2^256 - 2 + 1 = 2^256 - 1 = max u256
        // this bypasses bounds checking
        
        // // map[0] value is stored at keccak(p) = keccak(1)
        // needs to be padded to a 256 bit
        
        const mapDataBegin = ethers.BigNumber.from(
            ethers.utils.keccak256(
            `0x0000000000000000000000000000000000000000000000000000000000000001`
            )
        )
        // // need to find index at this location now that maps to 0 mod 2^256
        // // i.e., 0 - keccak(1) mod 2^256 <=> 2^256 - keccak(1) as keccak(1) is in range
        const isCompleteOffset = ethers.BigNumber.from(`2`)
        .pow(`256`)
        .sub(mapDataBegin)

        // await map.set(isCompleteOffset, `1`)
        // console.log(await map.isComplete());
    })
});
