function post (){
  const submit = document.getElementById("expense-submit");
  submit.addEventListener("click", (e)=>{
    e.preventDefault();
    const form = document.getElementById("expense-form");
    const formData = new FormData(form);
    const XHR = new XMLHttpRequest();
    XHR.open("POST", "/expenses", true);
    XHR.responseType = "json";
    XHR.send(formData)
  });
};

window.addEventListener('load', post);