// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";

// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';
// import { initCountdown } from '../components/init_countdown';
// import { startTimer} from '../components/init_countdown';
import {startChrono, waitButtonToggle, showButtonToggle} from '../components/init_countdown';


document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  // initSelect2();
  const btnTimer = document.getElementById("btn-start-training-counter")
  if (btnTimer) {
    const chrono = document.getElementById("starting_chrono")
    btnTimer.addEventListener("click",(e) => {
      e.preventDefault()
      chrono.innerHTML = ""
      startChrono()
      const btnEvalId = "btn-next-training"
      btnTimer.classList.toggle("btn-disappear");

      setTimeout(() => {
        waitButtonToggle(btnEvalId)
        showButtonToggle(btnEvalId)
      }, 3000);
      setTimeout(waitButtonToggle(btnEvalId), 20000);
    })
  }

});
