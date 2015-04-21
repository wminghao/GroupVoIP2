var queryString = function () {
  // This function is anonymous, is executed immediately and 
  // the return value is assigned to QueryString!
  var query_string = {};
  var query = window.location.search.substring(1);
  var vars = query.split("&");
  for (var i=0;i<vars.length;i++) {
    var pair = vars[i].split("=");
        // If first entry with this name
    if (typeof query_string[pair[0]] === "undefined") {
      query_string[pair[0]] = pair[1];
        // If second entry with this name
    } else if (typeof query_string[pair[0]] === "string") {
      var arr = [ query_string[pair[0]], pair[1] ];
      query_string[pair[0]] = arr;
        // If third or later entry with this name
    } else {
      query_string[pair[0]].push(pair[1]);
    }
  } 
    return query_string;
} ();

var VP = {    
    flashAPI: {
	// return room info.
	getRoom: function() { 
	    return queryString["room"];
	},
	// return user info.
	getUser: function() { 
	    return queryString["user"];
	},
	isArchive: function() { 
	    return queryString["isArchive"];
	},
	getMode: function() { 
	    return "auto";
	    //return queryString["mode"];
	}, 
	forceAudioOnly: function() { 
	    return queryString["forceAudioOnly"];
	},
	getServerIp: function() { 
	    //return "121.40.163.69";
	    return "54.148.16.2";
	    //return "52.10.61.227";
	    //return "54.201.108.66:9000";
	    //return httpGet("http://54.201.108.66:8000/findroom/"+queryString["room"]);
	    //return queryString["serverIp"];
	} 
    }
}
