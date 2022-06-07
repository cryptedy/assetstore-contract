// SPDX-License-Identifier: MIT

pragma solidity ^0.8.6;

/*
 * @notice
 * The "messenger" optionaly specifies the messenger application, which offers additional
 * capabilities such as attachments, collaborations and games. 
 * The "id" is a unique id within that particular application.
*/
struct Message {
	address sender;    // sender
	address receiver;  // receiver
	string text;       // text representation
	string imageURL;      // thumbnail representation
	address app;       // messager application
	uint256 messageId; // message id
	uint256 timestamp; 
	bool isRead;
	bool isDeleted;
}

interface IMessageBox {
	function send(address _to, string memory _text) external returns (uint256);
	function sendAppMessage(address _to, string memory _text, string memory _imageURL, address _app, uint256 _messageId) external returns (uint256);
	function count() external returns (uint256);
	function get(uint256 _index) external returns (Message memory);
	function markRead(uint256 _index, bool _isRead) external returns (Message memory);
	function markDeleted(uint256 _index, bool _isDeleted) external returns (Message memory);
	event MessageReceived(address _from, address _to, uint256 _index);
	event MessageRead(address _from, address _to, uint256 _index);
}

interface ISpamFilter {
	function isSpam(address _to, Message memory _message) external returns (bool);
	function reportSpan(address _to, Message memory _message) external;
}