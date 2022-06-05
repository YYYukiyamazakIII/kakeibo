function create(){
  const submits = document.getElementsByName("good-items-button")
  submits.forEach(function(submit){
    submit.addEventListener('click',(e)=>{
      e.preventDefault();
      const form = submit.form
      const formData = new FormData(form);
      const XHR = new XMLHttpRequest();
      XHR.open("POST", form.action, true);
      XHR.responseType = "json";
      XHR.send(formData);
      XHR.onload = () => {
        if(XHR.response.judge=="false"){
          XHR.open("DELETE", `/tweets/${XHR.response.tweet_id}/good_tweets/${XHR.response.good_tweet_id}`, true)
          XHR.responseType = "json";
          XHR.send(formData);
          return;
        }
        submit.value = `いいね ${XHR.response.good_tweet_count}`
      };
    })
  });
};



window.addEventListener('load', create)