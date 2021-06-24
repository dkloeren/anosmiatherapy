const waitButtonToggle = (button) => {
  // const btnEval = document.getElementById(buttonId);
  button.classList.toggle("btn-wait");
}

const hideToggle = (element) => {
  // const element = document.getElementById(elementID);
element.classList.toggle("hide");
}

export {hideToggle}
