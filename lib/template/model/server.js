var express = require('express');
var app = express();
var server = require('http').Server(app);
var io = require('socket.io')(server);

io.set('origins', '*:*');

app.use(express.static('src'));

app.use(function(req, res, next) {
	res.header('Access-Control-Allow-Origin', req.get('Origin') || '*');
	res.header('Access-Control-Allow-Credentials', 'true');
	res.header('Access-Control-Allow-Methods', 'GET,HEAD,PUT,PATCH,POST,DELETE');
	res.header('Access-Control-Expose-Headers', 'Content-Length');
	res.header('Access-Control-Allow-Headers', 'Accept, Authorization, Content-Type, X-Requested-With, Range');
	if (req.method === 'OPTIONS') {
		return res.send(200);
	} else {
		return next();
	}
});

server.listen(8080, function () {
	console.log("Server listening on: http://localhost:%s", 8080);
});
