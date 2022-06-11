const buildHTML = (XHR) => {
  const html = `
  <div class="comment-inner">
    <div class="comment-upper-container">
      <div class="comment-user-name">
        ${XHR.response.name}
      </div>
      <div class="comment-date">
        ${XHR.response.date}
      </div>
    </div>
    <div class="comment-lower-container">
      <div class="comment-text">
        ${XHR.response.text}
      </div>
    </div>
  </div>`;
  return html;
};

function commentCreate (){
  const submit = document.getElementById("comment-form-submit");
  submit.addEventListener('click',(e)=>{
    e.preventDefault();
    const form = document.getElementById("comment-create-form")
    const formData = new FormData(form);
    const XHR = new XMLHttpRequest();
    const tweetId = document.getElementById("tweet_id")
    XHR.open("POST", `/tweets/${tweetId.value}/comments`, true);
    XHR.responseType = "json";
    XHR.send(formData);
    XHR.onload = () => {
      if(XHR.response.judge == "false"){
        XHR.response.message.forEach(function(message){
          alert(message)
        })
        return null;
      };
      const list = document.getElementById("comments-list")
      const formText = document.getElementById("exampleFormControlInput1");
      list.insertAdjacentHTML("afterbegin", buildHTML(XHR));
      formText.value = "";
    };
  });
};

function commentDestroy (){
  const submits = document.getElementsByName("comment-destroy-submit")
  submits.forEach(function(submit){
    submit.addEventListener("click",(e)=>{
      e.preventDefault();
      const form = submit.form
      const formData = new FormData(form);
      const XHR = new XMLHttpRequest();
      XHR.open("DELETE", form.action, true);
      XHR.send(formData);
      XHR.onload = () => {
        submit.form.parentNode.parentNode.parentNode.innerHTML = "";
      };
    });
  })
};

window.addEventListener('load', commentCreate);
window.addEventListener('load', commentDestroy);