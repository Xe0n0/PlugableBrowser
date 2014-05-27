const Event = {
  PluginLoaded: 1,
  WebViewShouldLoad: 11,
  WebViewStartLoading: 12,
  WebViewEventFinished: 13,
  WebViewErrorLoading: 14,
}

var Plugin = function(){

  return {
    Init: function() {
      App.showSuccessHUD("载入网关插件");
      App.addToolButton(function(){
        App.exec("document.getElementById('user_id').value='1000012926';document.getElementById('password').value='4924857888';document.getElementsByClassName('login_btn')[0].click();");
      }, "登录");
    },
   

    feedEvent: function(event){
      switch(event) {
        case Event.PluginLoaded:
          this.Init();
        default:
          break;
      }
    }
  }
}();

