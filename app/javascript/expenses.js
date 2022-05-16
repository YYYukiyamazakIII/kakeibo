const buildHTML = (XHR) => {
  const item = XHR.response.post;
  const name = XHR.response.name;
  const html = `
    <tr>
      <td></td>
      <td> ${item.name}  </td>
      <td> ${name} </td>
      <td name="expense-value"> ${item.value} </td>
      <td>編集 / 削除</td>
    </tr>`;
  return html;
};

function post (){
  const submit = document.getElementById("expense-submit");
  submit.addEventListener("click", (e)=>{
    e.preventDefault();
    const form = document.getElementById("expense-form");
    const formData = new FormData(form);
    const XHR = new XMLHttpRequest();
    XHR.open("POST", "/expenses", true);
    XHR.responseType = "json";
    XHR.send(formData);
    XHR.onload = () => {
      if(XHR.response.judge == false){
        XHR.response.message.forEach(function(message){
          alert(message)
        })
        return null;
      };
      const list = document.getElementById("list");
      const formName = document.getElementById("form-name");
      const formValue = document.getElementById("form-value");
      const formCategoryId = document.getElementById("form-category_id");
      list.insertAdjacentHTML("afterbegin", buildHTML(XHR));
      calc()
      formName.value = "";
      formValue.value = "";
      formCategoryId.value = "";
    };
  });
};

function calc (){
  let totalValue = 0
  const expenseValueList = []
  const expenseValues = document.getElementsByName("expense-value")
  const totalValueSpace = document.getElementById("total-value-space")
  expenseValues.forEach(function(expenseValue){
    expenseValueList.push(expenseValue.innerHTML)
  })
  expenseValueList.forEach(function(value){
    totalValue += Number(value)
  })
  totalValueSpace.innerHTML = `合計金額：${totalValue}円`
}

window.addEventListener('load', post);
window.addEventListener('load', calc);
window.addEventListener('submit', calc);