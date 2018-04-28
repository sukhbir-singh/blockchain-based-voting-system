web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));

json_string='[{"constant":false,"inputs":[{"name":"_user_id","type":"string"}],"name":"addUser","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"_user_id","type":"string"},{"name":"_link","type":"string"},{"name":"_ts","type":"string"},{"name":"_hash","type":"string"}],"name":"storeLink","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"_user_id","type":"string"}],"name":"retrieveLink","outputs":[{"name":"","type":"string"},{"name":"","type":"string"},{"name":"","type":"string"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[],"name":"totalUsers","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"_user_id","type":"string"}],"name":"_isValid","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"}]';

abi = JSON.parse(json_string);

VotingContract = web3.eth.contract(abi);

// In your nodejs console, execute contractInstance.address to get the address at which the contract is deployed and change the line below to use your deployed address

var contractInstance = VotingContract.at('0x51a89381334d8c331bab2e0c92ffd67068a66d38');

function voteForCandidate() {  
  candidateName = $("#candidate").val();
  contractInstance.addUser(candidateName,{from: web3.eth.accounts[0]}, function(){
    console.log(contractInstance.totalUsers.call());
  }) 
}
