$(document).ready(function(){
  if ('WebSocket' in window) {

    var loc = window.location, wsUri;
    if (loc.protocol === "https:") {
      wsUri = "wss:";
    } else {
      wsUri = "ws:";
    }
    wsUri += "//" + loc.host;
    wsUri += loc.pathname + "/ws";

    var connection = new WebSocket(wsUri);
    connection.onopen = function(){
      console.log('Connection opened');
    }
    connection.onmessage = function(e){
      var message = e.data;
      $("#message")[0].innerHTML += "<p>" + message + "</p>";
    }
    connection.onclose = function(){
      console.log('Connection closed');
    }
    connection.onerror = function(error){
      console.log('Error: ' + error);
    }
  } else {
    alert('Web sockets are not supported on this browser');
  }
});
