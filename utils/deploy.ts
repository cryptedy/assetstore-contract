import { ethers } from "hardhat";

export const deploy:any = async () => {
  const assetStoreFactory = await ethers.getContractFactory("AssetStore");
  const assetStore = await assetStoreFactory.deploy();
  await assetStore.deployed();

  const materialTokenStoreFactory = await ethers.getContractFactory("MaterialToken");
  const materialToken = await materialTokenStoreFactory.deploy(assetStore.address, assetStore.address);
  await materialToken.deployed();

  const tx = await assetStore.setWhitelistStatus(materialToken.address, true);
  await tx.wait();

  return { assetStore, materialToken };
};