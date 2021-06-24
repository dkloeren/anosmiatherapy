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
import {startChrono, waitButtonToggle, showButtonToggle} from '../components/init_countdown';
import {initStackedAreaChart} from '../components/init_stacked_area_chart'
import {iniRadialGraphChart} from '../components/init_radial_graph_chart'
// import {chartLineWithBullets} from '../components/init_line_with_custom_bullets_chart'

document.addEventListener('turbolinks:load', () => {

  // Check Selectors
  const btnTimer = document.getElementById("btn-start-training-counter")
  const progChartContainer= document.getElementById(".amcharts-progress-chart-container")

  const jstTestButton = document.getElementById("btn-js-start")

  // Timer
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
      }, 1000);
      setTimeout(waitButtonToggle(btnEvalId), 8000);
    })
  }

  // Charts
  initStackedAreaChart()
  iniRadialGraphChart()

  // if (jstTestButton) {
  //   const progressCharts = document.Element.querySelectorAll(".progress_chart_container")
  //   button.addEventListener("click",(e) => {
  //     // chartPrgressChart();
  //   })
  // }
});
