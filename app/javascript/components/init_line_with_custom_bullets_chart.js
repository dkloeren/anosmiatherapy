/* Imports */
import * as am4core from "@amcharts/amcharts4/core";
import * as am4charts from "@amcharts/amcharts4/charts";
import am4themes_dataviz from "@amcharts/amcharts4/themes/dataviz";
import am4themes_animated from "@amcharts/amcharts4/themes/animated";

/* Chart code */
// Themes begin
am4core.useTheme(am4themes_dataviz);
am4core.useTheme(am4themes_animated);
// Themes end

// Create chart instance
let chart = am4core.create("chartdiv", am4charts.XYChart);

// Add data
chart.data = [{
  "date": new Date(2018, 3, 20),
  "value": 90
}, {
  "date": new Date(2018, 3, 21),
  "value": 102
}, {
  "date": new Date(2018, 3, 22),
  "value": 65
}, {
  "date": new Date(2018, 3, 23),
  "value": 62
}, {
  "date": new Date(2018, 3, 24),
  "value": 55
}, {
  "date": new Date(2018, 3, 25),
  "value": 81
}];

// Create axes
let dateAxis = chart.xAxes.push(new am4charts.DateAxis());

// Create value axis
let valueAxis = chart.yAxes.push(new am4charts.ValueAxis());

// Create series
let lineSeries = chart.series.push(new am4charts.LineSeries());
lineSeries.dataFields.valueY = "value";
lineSeries.dataFields.dateX = "date";
// lineSeries.dataFields.dateX = "value";
lineSeries.name = "Sales";
lineSeries.strokeWidth = 3;

// Add simple bullet
let bullet = lineSeries.bullets.push(new am4charts.Bullet());
let image = bullet.createChild(am4core.Image);
image.href = "https://www.amcharts.com/lib/images/star.svg";
image.width = 30;
image.height = 30;
image.horizontalCenter = "middle";
image.verticalCenter = "middle";
