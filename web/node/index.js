var http = require('http');
var mysql = require('mysql');
// Create the connection. 
// Data is default to new mysql installation and should be changed according to your configuration. 
var connection = mysql.createConnection({ 
    user: "root", 
    password: "root", 
    database: "vispar"
}); 

var express = require('express');
var app = express();
app.set('port', process.env.PORT || 8000); //open port on 8000

//default path
app.get('/', function (req, res) {
  res.send('<html><body><h1>Hello World</h1></body></html>');
});

//new event insertion.
app.post("/newevent", function (req, res) {
    var body = '';
    req.on('data', function (data) {
        body += data;

        // Too much POST data, kill the connection!
        if (body.length > 1e6)
            request.connection.destroy();
    });

    req.on('end', function () {
	//parse the json object
        var obj = JSON.parse(body);
	console.log(sys.inspect(obj));

	//insert into sql server
	var post={OrganizerId:obj.OrganizerId, EventTitle:obj.EventTitle, EventStartTime:obj.EventStartTime, EventEndTime:obj.EventEndTime, EventDescription:obj.EventDescription, 
		  EventLogo:"", Privacy:obj.Privacy};

	//then insert the record
	var queryInsert = connection.query('INSERT INTO Event SET ?', post, function(err, result) {
	    res.send("Success", 200);
	});
	console.log(queryInsert.sql);
    });
});

//view event with eventid as query
app.get('/viewevent/:eventid', function (req,res) {
    //do sql query.
    // Query the database. 
    connection.query('SELECT * FROM Event where EventId = '+ req.params.eventid +';', function (error, rows, fields) { 
	res.writeHead(200, { 
	    'Content-Type': 'x-application/json' 
	}); 
	// Send data as JSON string. 
	// Rows variable holds the result of the query. 
	res.end(JSON.stringify(rows[0])); 
	console.log(rows[0]);
    }); 
});

//view event in html with eventid as query
app.get('/viewhtmlevent/:eventid', function (req,res) {
    //do sql query.
    // Query the database. 
    connection.query('SELECT * FROM Event where EventId = '+ req.params.eventid +';', function (error, rows, fields) { 
	res.writeHead(200, { 
	    'Content-Type': 'text/html' 
	}); 
	// Send data as JSON string. 
	// Rows variable holds the result of the query. 
	htmltext = 
	    "<html><head><title>Vispar Event "+
	    rows[0].EventTitle +
	    "</title></head><body>" +
	    "<h1>Vispar Event\t"+
	    "<input type=\"submit\" id=\"Add2Calendar\" value=\"Add to calendar\"  style=\"width: 200px; height: 30px; font-size: 25px;\" ></html>"+
	    "</h1>" +
	    "<h3>"+
	    rows[0].EventDescription+
	    "</h3>"+
	    "<img src=\"http://cp91279.biography.com/1000509261001/1000509261001_1912696506001_TDIH-Picasso-Born-RETRY.jpg\" alt=\""+
	    rows[0].EventTitle +
	    "\"/><br><br>"+
	    "<form action=\"http://54.148.16.2/flashconf/bin-debug/flashconf.html?room=howard&user=mama\" method=\"post\">"+
	    "<input type=\"submit\" id=\"Attend\" value=\"Attend Now\"  style=\"width: 160px; height: 30px; font-size: 25px;\" ></form>"+
	    "</body>"+		
	    "</html>";
	//"<form action=\"http://www.vispar.com/rooms/howard\"><input type=\"submit\" id=\"Attend\" value=\"Attend Now\"  style=\"width: 160px; height: 30px; font-size: 25px;\" ></form>"+
	res.end(htmltext);
	console.log(htmltext);
    }); 
});

http.createServer(app).listen(app.get('port'), function(){
  console.log('Express server listening on port ' + app.get('port'));
});
