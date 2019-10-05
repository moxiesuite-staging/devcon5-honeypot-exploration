const Log_Honest = artifacts.require("./Log_Honest.sol");
const PrivateBank = artifacts.require("./PrivateBank.sol");

module.exports = async function(deployer) {
  // Only deploy the PrivateBenk on our local testnet
  return deployer.then(async () => {
    if (/(local)/.test(deployer.network)) {
      await deployer.deploy(Log_Honest);
      const logContract = await Log_Honest.deployed();

      await deployer.deploy(PrivateBank, logContract.address)
      const bankContract = await PrivateBank.deployed()
    }
  })
}
