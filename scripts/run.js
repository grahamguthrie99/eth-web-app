const main = async () => {
  const [owner, randomPerson] = await hre.ethers.getSigners();
    const pumpContractFactory = await hre.ethers.getContractFactory('PumpPortal');
    const pumpContract = await pumpContractFactory.deploy({
      value: hre.ethers.utils.parseEther('0.1'),
    });;
    await pumpContract.deployed();
    console.log("Contract deployed to:", pumpContract.address);

    let contractBalance = await hre.ethers.provider.getBalance(
      pumpContract.address
    );
    console.log(
      'Contract balance:',
      hre.ethers.utils.formatEther(contractBalance)
    );

    let pumpCount;
    pumpCount = await pumpContract.getTotalPumps();
  


  pumpTxn = await pumpContract.connect(randomPerson).pump('Another message!');
  await pumpTxn.wait();

  contractBalance = await hre.ethers.provider.getBalance(pumpContract.address);
  console.log(
    'Contract balance:',
    hre.ethers.utils.formatEther(contractBalance)
  );


  let allPumps = await pumpContract.getAllPumps();
  console.log(allPumps);

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