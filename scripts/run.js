const main = async () => {
  const [owner, randomPerson] = await hre.ethers.getSigners();
    const pumpContractFactory = await hre.ethers.getContractFactory('PumpPortal');
    const pumpContract = await pumpContractFactory.deploy();
    await pumpContract.deployed();
    console.log("Contract deployed to:", pumpContract.address);

    let pumpCount;
  pumpCount = await pumpContract.getTotalPumps();
  
  let pumpTxn = await pumpContract.pump();
  await pumpTxn.wait();

  pumpTxn = await pumpContract.connect(randomPerson).pump();
await pumpTxn.wait();

  pumpCount = await pumpContract.getTotalPumps();
  };
  
  const runMain = async () => {
    try {
      await main();
      process.exit(0);
    } catch (error) {
      console.log(error);
      process.exit(1);
    }
  };
  
  runMain();