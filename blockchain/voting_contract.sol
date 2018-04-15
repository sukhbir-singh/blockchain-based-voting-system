pragma solidity ^0.4.11;

contract VotingManager {
	
	struct dataLink {
		string link;
		string timestamp;
		string hash;
	}

	mapping (string => dataLink) registry;
	//mapping (string => string) private passwords; 
	string[] users;


	function _isValid(string _user_id) returns (bool) {
		for(uint i = 0;i<users.length;i++){
			if(keccak256(users[i]) == keccak256(_user_id)) {
			return true;
			}
		}
		return false;
	}

	function addUser(string _user_id) {
		users.push(_user_id);
	}

	function totalUsers() returns (uint) {
		return users.length;
	}


	function storeLink(string _user_id, string _link, string _ts, string _hash){

		// check if user is present in blockchain
		if(_isValid(_user_id)){
			registry[_user_id] = dataLink(_link, _ts, _hash);

		}

	}


	function retrieveLink(string _user_id) returns (string, string, string) {

		//check if user is present in blockchain
		require(_isValid(_user_id));

		dataLink link = registry[_user_id];
		return (link.link, link.timestamp, link.hash);

	}

}
