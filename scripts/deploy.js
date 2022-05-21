const main = async () => {
  // gets info of the account used to deploy
  const [deployer] = await hre.ethers.getSigners();
  const accountBalance = await deployer.getBalance();

  console.log('Deploying contract with account: ', deployer.address);
  console.log('Account balance: ', accountBalance.toString());

  // read contract file
  const examContractFactory = await hre.ethers.getContractFactory(
    'ExamContract'
  );
  // triggers deployment
  const examContract = await examContractFactory.deploy({});

  // wait for deployment to finish
  await examContract.deployed();

  console.log('ExamNumber contract address: ', examContract.address);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
};

runMain();