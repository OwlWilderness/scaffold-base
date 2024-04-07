import { expect } from "chai";
import { ethers } from "hardhat";
import { GarageManager } from "../typechain-types";
//import { Address } from "hardhat-deploy/types";

describe("GarageManager", function () {
  let contract: GarageManager;
  //let addy: Address;
  before(async () => {
    const factory = await ethers.getContractFactory("GarageManager");
    contract = (await factory.deploy()) as GarageManager;
    // const [signer] = await ethers.getSigners();
    // addy = signer.address;
    await contract.waitForDeployment();
  });

  describe("Deployment", function () {
    it("Should deploy ok and have the symbol GM", async function () {
      expect(await contract.Symbol()).to.equal("GM");
    });
  });
});
