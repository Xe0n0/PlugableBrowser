const Event = {
  PluginLoaded: 1,
  WebViewShouldLoad: 10,
}

var Plugin = function(){
  var http = null;

  return {
    Init: function() {
      console.log('Plugin did load');
    },

    Connect: function() {
        http = new XMLHttpRequest();
        var url = 'https://its.pku.edu.cn:5428/ipgatewayofpku?uid=00904701&password=19910103&timeout=2&range=2&operation=connect';

        http.onreadystatechange = function() {
          if (http.readyState == 4) {
            if (http.status == 200) {
              console.log(http.responseText);
              PBBrowser.sendNotification("已连接");
            }
            else {
              PBBrowser.sendNotification("连接失败");
            }
          }
        };

        http.open('GET', url, true);
        http.send(null);
      },


    feedEvent: function(event){
      switch(event) {
        case Event.WebViewShouldLoad:
          this.Connect();
          break;
        case Event.PluginLoaded:
          this.Init();
          break;
        default:
          console.log('unknown event ' + event.toString());
          break;
      }
    }
  }
}();
