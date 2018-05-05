pragma solidity ^0.4.11;

contract VotingManager {
	
	struct dataLink {
		string link;
		string timestamp;
		string hash;
	}

	mapping (string => dataLink) registry;
	mapping (string => bytes32) private passwords; 
	string[] users;


	function _isValid(string _user_id, string _encryption_key_hash) returns (bool) {
		for(uint i = 0;i<users.length;i++){
			if(keccak256(users[i]) == keccak256(_user_id) && 
				keccak256(_encryption_key_hash) == passwords[_user_id]) {

				return true;
			}
		}
		return false;
	}

	function addUser(string _user_id, string _encryption_key_hash) {
		users.push(_user_id);
		passwords[_user_id] = keccak256(_encryption_key_hash);
	}

	function totalUsers() returns (uint) {
		return users.length;
	}


	// link is alias of generated_id
	function storeLink(string _user_id, string _link, string _ts, string _hash, string _encryption_key_hash){

		// check if user is present in blockchain
		//require(_isValid(_user_id, _encryption_key_hash));

		registry[_user_id] = dataLink(_link, _ts, _hash);
	}


	function retrieveLink(string _user_id, string _encryption_key_hash) returns (string, string, string) {

		//check if user is present in blockchain
		require(_isValid(_user_id, _encryption_key_hash));

		dataLink link = registry[_user_id];
		return (link.link, link.timestamp, link.hash);

	}

}
