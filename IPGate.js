const Event = {
  PluginLoaded: 1,
  WebViewShouldLoad: 11,
  WebViewStartLoading: 12,
  WebViewEventFinished: 13,
  WebViewErrorLoading: 14,
}
var noNeed = false;

var Plugin = function(){

  return {
    Init: function() {
      App.showSuccessHUD("载入网关插件");
      App.addToolButton(function(){
        Plugin.Disconnect();
      }, "断开");
    },
    __raw_connect: function(callback) {

        var http = null;
        http = new XMLHttpRequest();
        var url = 'https://its.pku.edu.cn:5428/ipgatewayofpku?uid=00904701&password=19910103&timeout=2&range=2&operation=connect';

        http.onreadystatechange = callback
        http.open('GET', url, true);
        http.send(null);
    },

    Connect: function() {
      if (noNeed) return;

        var url = 'https://its.pku.edu.cn:5428/ipgatewayofpku?uid=00904701&password=19910103&timeout=2&range=2&operation=connect';

        Http.get(url, function(status, responseText){

          if (status == 200) {
            console.log(responseText);
            var success = /SUCCESS=([^ ]*)/.exec(responseText)[1];
            if (success == 'YES') {
              var desc = /FR_DESC_CN=([^ ]*)/.exec(responseText)[1];
              App.showSuccessHUD("已连接\n" + desc);
              noNeed = true;
            }
            else if (success == 'NO') {
              var reason = /REASON=([^ ]*)/.exec(responseText)[1];
              App.showErrorHUD(reason);
            }
            else
              App.showErrorHUD(responseText);
          }
          else {
            App.showErrorHUD("连接失败");
          }

        });

      },
    Disconnect: function() {
        var url = 'https://its.pku.edu.cn:5428/ipgatewayofpku?uid=00904701&password=19910103&timeout=2&range=2&operation=disconnectall';

        Http.get(url, function(status, responseText){

          if (status == 200) {
            console.log(responseText);
            var success = /SUCCESS=([^ ]*)/.exec(responseText)[1];
            if (success == 'YES') {
              App.showSuccessHUD("已断开");
            }
            else if (success == 'NO') {
              var reason = /REASON=([^ ]*)/.exec(responseText)[1];
              App.showErrorHUD(reason);
            }
            else
              App.showErrorHUD(responseText);
          }
          else {
            App.showErrorHUD("断开连接失败");
          }

        });
    },
    // Disconnect: function() {
    //     var http = null;
    //     http = new XMLHttpRequest();
    //     var url = 'https://its.pku.edu.cn:5428/ipgatewayofpku?uid=00904701&password=19910103&timeout=2&range=2&operation=disconnectall';

    //     http.onreadystatechange = function() {
    //       if (http.readyState == 4) {
    //         if (http.status == 200) {
    //           console.log(http.responseText);
    //           App.showSuccessHUD("已断开全部连接");
    //         }
    //         else {
    //           App.showErrorHUD("断开连接失败");
    //         }
    //       }
    //     };

    //     http.open('GET', url, true);
    //     http.send(null);
    // },
    Query: function() {
      var judge = "您的IP来自校本部之外";
    },


    feedEvent: function(event){
      switch(event) {
        case Event.WebViewStartLoading:
          this.Connect();
          break;
        case Event.WebViewErrorLoading:
          this.Disconnect();
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
