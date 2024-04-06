import { expect } from "chai";
import { ethers } from "hardhat";
import { FavoriteRecords } from "../typechain-types";
import { Address } from "hardhat-deploy/types";

//import { MaxUint256, getUint } from "ethers";

describe("FavoriteRecords", function () {
  // We define a fixture to reuse the same setup in every test.

  const albums = [
    "Thriller",
    "Back in Black",
    "The Bodyguard",
    "The Dark Side of the Moon",
    "Their Greatest Hits (1971-1975)",
    "Hotel California",
    "Come On Over",
    "Rumours",
    "Saturday Night Fever",
  ];

  let contract: FavoriteRecords;
  let addy: Address;
  before(async () => {
    const factory = await ethers.getContractFactory("FavoriteRecords");
    contract = (await factory.deploy(albums)) as FavoriteRecords;
    const [signer] = await ethers.getSigners();
    addy = signer.address;
    await contract.waitForDeployment();
  });

  describe("approvedRecords", async function () {
    /*
        Loading Approved Albums
        Using the method of your choice, load approvedRecords with the following:

        ['Thriller',
        'Back in Black',
        'The Bodyguard',
        'The Dark Side of the Moon',
        'Their Greatest Hits (1971-1975)',
        'Hotel California',
        'Come On Over',
        'Rumours',
        'Saturday Night Fever']
    */
    it("Back in Black is approved.", async function () {
      expect((await contract.getApprovedRecords())[1]).be.equal("Back in Black");
    });

    it("The approved album list len is nine.", async function () {
      expect((await contract.getApprovedRecords()).length).be.equal(9);
    });
  });

  describe("User Records", async function () {
    it("Reverts on unapproved album.", async function () {
      expect(contract.addRecord("not approved")).to.be.revertedWithCustomError(contract, "NotApproved");
    });

    it("Adds approved album 'Back in Black'.", async function () {
      expect(await contract.addRecord("Back in Black")).to.be.ok;
      // expect(await contract.getRecord("The Bodygaurd")).be.equal(true);
    });

    it("Get Record 'Back in Black' to be a favorite.", async function () {
      //expect(await contract.addRecord("The Bodyguard")).to.be.ok;
      expect(await contract.getRecord(addy, "Back in Black")).be.equal(true);
    });

    it("Adds approved album 'Their Greatest Hits (1971-1975)'.", async function () {
      expect(await contract.addRecord("Their Greatest Hits (1971-1975)")).to.be.ok;
      // expect(await contract.getRecord("The Bodygaurd")).be.equal(true);
    });

    it("Has Favorites List length of 2", async function () {
      expect((await contract.getUserFavorites(addy)).length).be.equal(2);
    });

    it("Favorites List Contains 'Their Greatest Hits (1971-1975)'", async function () {
      expect(await contract.getUserFavorites(addy)).to.contain("Their Greatest Hits (1971-1975)");
    });

    it("Favorites List Contains 'Back in Black'", async function () {
      expect(await contract.getUserFavorites(addy)).to.contain("Back in Black");
    });

    it("Favorites List Does Not Contains 'Rumors'", async function () {
      expect(await contract.getUserFavorites(addy)).to.not.contain("Rumors");
    });
  });
});
