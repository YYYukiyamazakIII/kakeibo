const { buildNavLinkAttrs, buildIsoString } = require("@fullcalendar/core");

function create (){
  const submit = document.getElementById("expense-submit")
  submit.addEventListener("click", (e, submit)=>{
    e.preventDefault();
    if(document.getElementById("expense-submit")){
      const form = document.getElementById("expense-form");
      const formData = new FormData(form);
      const XHR = new XMLHttpRequest();
      XHR.open("POST", "/expenses", true);
      XHR.responseType = "json";
      XHR.send(formData);
      XHR.onload = () => {
        if(XHR.response.judge == "false"){
          showErrorMessage(XHR)
        };
        const expenseList = document.getElementById("expenses-list");
        expenseList.insertAdjacentHTML("afterbegin", createHTML(XHR));
        calc();
        resetFormValue();
      }
    }
  });
};

function edit(){
  const expenses = []
  const submits = document.getElementsByName("get-submit")
  submits.forEach(function(submit){
    submit.addEventListener("click",(e)=>{
      e.preventDefault();
      const form = submit.form
      const formData = new FormData(form);
      const XHR = new XMLHttpRequest();
      XHR.open("GET", form.action, true);
      XHR.responseType = "json";
      XHR.send(formData);
      XHR.onload = () => {
        const expense = XHR.response.expense
        changeEditForm(expense);
        update(expenses, expense, submit);
      };
    });
  })
}

function update (expenses, expense, defaultHTML){
  const submit = document.getElementById("edit-submit");
  submit.addEventListener("click", (e)=>{
    e.preventDefault();
    if (!expenses.includes(expense.id)){
      const form = document.getElementById("expense-form");
      const formData = new FormData(form);
      const XHR = new XMLHttpRequest();
      XHR.open("PATCH", `/expenses/${expense.id}`, true);
      XHR.responseType = "json";
      XHR.send(formData);
      XHR.onload = () => {
        if(XHR.response.judge == "false"){
          showErrorMessage(XHR)
        };
        defaultHTML.parentNode.parentNode.parentNode.parentNode.innerHTML = createHTML(XHR);
        calc();
        resetFormValue();
        changePostSubmit(); 
        expenses.push(expense.id)
      };
    }
  });
}

function destroy (){
  const submits = document.getElementsByName("destroy-submit")
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
        calc();
      };
    });
  })
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

const createHTML = (XHR) => {
  const expense = XHR.response.expense;
  const categoryName = XHR.response.categoryName;
  const html = `
    <tr>
      <td></td>
      <td> ${expense.name} </td>
      <td> ${categoryName} </td>
      <td name="expense-value"> ${expense.value} </td>
      <td class="post-message">登録しました</td>
    </tr>`;
  return html;
};

const resetFormValue = () => {
  const inputName = document.getElementById("input-name");
  const inputValue = document.getElementById("input-value");
  const inputCategoryId = document.getElementById("input-category_id");
  inputName.value = "";
  inputValue.value = "";
  inputCategoryId.value = 1;
}

const showErrorMessage = (XHR) => {
  XHR.response.message.forEach(function(message){
    alert(message)
  })
  return null;
}

const changeEditForm = (expense) =>{
  const inputName = document.getElementById("input-name");
  const inputValue = document.getElementById("input-value");
  const inputCategoryId = document.getElementById("input-category_id");
  const editSubmit = document.getElementById("expense-submit")
  inputName.value = expense.name;
  inputValue.value = expense.value;
  inputCategoryId.value = expense.category_id
  editSubmit.id = "edit-submit"
  editSubmit.value = "編集"
}

const changePostSubmit = () =>{
  const expenseSubmit = document.getElementById("edit-submit")
  expenseSubmit.id = "expense-submit"
  expenseSubmit.value = "登録"
}

window.addEventListener('load', create);
window.addEventListener('load', calc);
window.addEventListener('submit', calc);
window.addEventListener('load', destroy);
window.addEventListener('load', edit);