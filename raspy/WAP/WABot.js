const qrcode = require('qrcode-terminal');

const { Client, LocalAuth, MessageMedia} = require('whatsapp-web.js');
const client = new Client({
	authStrategy: new LocalAuth()
});
const delay = ms => new Promise(resolve => setTimeout(resolve, ms))

console.log('Please wait');

client.on('qr', qr => {
	qrcode.generate(qr, {small: true});
});

client.on('ready', () => {
	console.log("Client is ready!");
	
	// Number where you want to send the message.
	const number = "insert-phone-number";
	// Getting chatId from the number.
	// we have to delete "+" from the beginning and add "@c.us" at the end of the number.
	const chatId = number.substring(1) + "@c.us";
	client.sendMessage(chatId, "BootDevice");

	const watch = require('node-watch')

	// import os module
	const os = require("os");

	// check the available memory
	const PathPoint = os.homedir().concat("/raspy/bing-rewards/points.txt");
	//send message when bingBot finish
	watch(PathPoint, function(event, filename) {
		const fs = require('fs');
	
		fs.readFile(PathPoint, 'utf8', (err, data) => {
			if (err) {
				console.error(err);
				return;
			}
			console.log(data);
	
		
			// Sending message.
			client.sendMessage(chatId, data.toString());
		});
	});
});
	
client.initialize();
