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
import {initCountdown} from '../components/init_countdown';
import {controlSmellEvalSubmitBtn} from '../components/smell_training'
import {initAvatarImgPreview} from '../components/devise'
// import {initStackedAreaChart} from '../components/init_stacked_area_chart'
// import {iniRadialGraphChart} from '../components/init_radial_graph_chart'

document.addEventListener('turbolinks:load', () => {
  // Selectors
  const btnTimer = document.getElementById("btn-start-training-counter")
  const progChartContainer= document.getElementById(".amcharts-progress-chart-container")
  const formInputAvatar = document.getElementById("avatar_image_upload")
  const formEvaluation = document.getElementById("form_smell_entry")

  // Countdown
  if (btnTimer) {
    initCountdown(btnTimer)
  }
  // Login: Image Preview
  if (formInputAvatar) {
    initAvatarImgPreview(formInputAvatar)
  }
  // Assert Strength and Accuracy rating have been evaluated
  if (formEvaluation) {
    controlSmellEvalSubmitBtn(formEvaluation)
  }

  // Charts
  // initStackedAreaChart()
  // iniRadialGraphChart()
});
