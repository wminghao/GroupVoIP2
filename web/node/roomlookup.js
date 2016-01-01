/*
This is a room lookup service for redirector.
========================================================================================================
We need to expose both HAProxy external port as well as all video server external port to the outside world.

GeoIP server query to find where client’s geo location is. (China/US)
Room location server query to find if a room exists, and where the room host server is now. (China/US)
If a room does not exist, connect to the HAProxy of the client’s region. (China/US) HAProxy will pick a server with minimum load.
Otherwise, connect to the room host server's IP address directly.
If a room is in different geolocation than the client, only allow viewing only for the client, b/c the network latency is OUT OF CONTROL.
*/

var http = require('http');

var mongoose = require('mongoose');
mongoose.connect('mongodb://localhost/roomdb');
var db = mongoose.connection;
db.on('error', console.error.bind(console, 'connection error:'));
db.once('open', function (callback) {
    console.log('mongogoose db connected');
});
var roomSchema = mongoose.Schema({
    name: String, //room name
    ipaddr:String //ip:port
})
var Room = mongoose.model('Room', roomSchema)
var express = require('express');
var app = express();
app.set('port', process.env.PORT || 8000); //open port on 8000

//create a room request
app.get('/createroom/:roomname', function (req,res) {
    //save a new room into db
    var room = new Room({ name: req.params.roomname, ipaddr: req.connection.remoteAddress})
    room.save(function (err, room) {
	if (err) {
	    res.end('failed');
	    return console.error(err);
	}
	res.end('ok');
	console.log('created room. name=' + room.name + ' ipaddr='+room.ipaddr);
    });
});

//delete a room request
app.get('/deleteroom/:roomname', function (req,res) {
    Room.find({ name: req.params.roomname }, function(err,docs){ 
	if (err) {
	    res.end('failed');
	    return console.log(err);
	}
	if ( !docs || !Array.isArray(docs) || docs.length === 0) {
	    res.end('failed');
	    return console.log('no docs found');
	}
	docs.forEach( function (doc) {
	    doc.remove();
	    res.end('ok');
	    console.log('deleted a room. name=' + req.params.roomname);
	});
    });
});

var lookupFunc = function(req, res, remoteaddr) {
    var options = {
	host: 'localhost',
	port: 8080,
	path: '/json/'+remoteaddr,
	method: 'GET'
    };
    //first find the geoIp of the client
    var reqGeoIp = http.request(options, function(resGeoIp) {
	//console.log('STATUS: ' + resGeoIp.statusCode);
	//console.log('HEADERS: ' + JSON.stringify(resGeoIp.headers));
	var data = '';
	resGeoIp.setEncoding('utf8');
	resGeoIp.on('data', function (chunk) {
	    data += chunk;
	});
	resGeoIp.on('end',function(){
	    var geoObj = JSON.parse(data);
	    var isClientFromCN = (geoObj.country_code == 'CN');
	    //console.log('BODY: ' + chunk);
	    Room.findOne({ name: req.params.roomname }, function(err,room){ 
		if (err) {
		    res.end('failed');
		    return console.log(err);
		}
		if (!room) {
		    if( isClientFromCN ) {
			res.end('121.40.163.69') //return the aliyun ip address
		    } else {
			res.end('54.201.108.66:9000') //return the HA proxy address for US server
		    }
		} else {
		    res.end(room.ipaddr); //return the actual ip of the hosting machine
		    console.log('found a room. name=' + room.name + ' ipAddr='+room.ipaddr);
		}
	    });
	});
    });
    reqGeoIp.on('error', function(err) {
	res.end('failed');
	return console.log(err);
    });
    reqGeoIp.end();
};

app.get('/findroom/:roomname', function (req, res) {
    lookupFunc(req, res, req.connection.remoteAddress);
});

app.get('/findroomwithclientip/:roomname/:clientip', function (req, res) {
    lookupFunc(req, res, req.params.clientip);
});

http.createServer(app).listen(app.get('port'), function(){
    console.log('Express server listening on port ' + app.get('port'));
});
