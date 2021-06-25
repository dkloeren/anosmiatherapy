import * as css from './css_helper'

// Check if any radio buttons for both strength and accuracy rating have been
// checked and control visibility of submit button.
const controlSmellEvalSubmitBtn = (formEvaluation) => {
  const checkRadioBtns = (event) => {
    var checked = 0
    Array.from(formEvaluation).forEach ((element) => {
      if(element.type === 'radio' && element.checked) checked++
    })
    if (checked === 2) {
      const btnSubmit = document.getElementById("btn-submit-evaluation")
      css.removeHide(btnSubmit);
      formEvaluation.removeEventListener('change', checkRadioBtns);
    }
  }

  formEvaluation.addEventListener("change", checkRadioBtns);
}

export {controlSmellEvalSubmitBtn}
