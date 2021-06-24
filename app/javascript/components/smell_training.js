import {hideToggle} from './helper'

const controlSmellEvalSubmitBtn = (formEvaluation) => {
  var not_changed = true
  formEvaluation.onchange = evt => {
    var checked = 0
    for(var i = 0; i < formEvaluation.length; i++) {
      if(formEvaluation[i].type == 'radio') {
        if (formEvaluation[i].checked) {
          checked ++
        }
      }
    }
    if (checked === 2 && not_changed) {
      not_changed = false
      const btnSubmitEvl = document.getElementById("btn-submit-evaluation")
      hideToggle(btnSubmitEvl)
    }
  }
}

export {controlSmellEvalSubmitBtn}
