const hre = require('hardhat')

async function main() {
  const baseURI = 'https://api'
  const devAddress = ''
  const openseaProxyContract = '0xa5409ec958c83c3f309868babaca7c86dcb077c1'

  const FattyChuchucat = await hre.ethers.getContractFactory('FattyChuchucat')

  const fattyChuchucat = await FattyChuchucat.deploy(baseURI, devAddress, openseaProxyContract)
  await fattyChuchucat.deployed()

  console.log('FattyChuchucat deployed to:', fattyChuchucat.address)
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error)
    process.exit(1)
  })
