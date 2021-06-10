/**
 * ---------------------------------------
 * This demo was created using amCharts 4.
 *
 * For more information visit:
 * https://www.amcharts.com/
 *
 * Documentation is available at:
 * https://www.amcharts.com/docs/v4/
 * ---------------------------------------
 */
import * as am4core from "@amcharts/amcharts4/core";
import * as am4charts from "@amcharts/amcharts4/charts";
import am4themes_animated from "@amcharts/amcharts4/themes/animated";

// Themes begin
am4core.useTheme(am4themes_animated);
// Themes end

// Create chart instance
var chart = am4core.create("chartdiv", am4charts.XYChart);

// Add data
chart.data = [{
  "category": "A",
  "from": 0,
  "to": 15,
  "name": "Stage #1",
  "fill": am4core.color("#0ca948")
}, {
  "category": "B",
  "from": 15,
  "to": 75,
  "name": "Stage #2",
  "fill": am4core.color("#93da49")
}, {
  "category": "C",
  "from": 75,
  "to": 90,
  "name": "Stage #3",
  "fill": am4core.color("#ffd100")
}, {
  "category": "A",
  "from": 90,
  "to": 95,
  "name": "Stage #4",
  "fill": am4core.color("#cd213b")
}, {
  "category": "B",
  "from": 95,
  "to": 100,
  "name": "Stage #5",
  "fill": am4core.color("#9e9e9e")
}];

// Create axes
var yAxis = chart.yAxes.push(new am4charts.CategoryAxis());
yAxis.dataFields.category = "category";
yAxis.renderer.grid.template.disabled = true;
yAxis.renderer.labels.template.disabled = true;

var xAxis = chart.xAxes.push(new am4charts.ValueAxis());
xAxis.renderer.grid.template.disabled = true;
xAxis.renderer.grid.template.disabled = true;
xAxis.renderer.labels.template.disabled = true;
xAxis.min = 0;
xAxis.max = 100;

// Create series
var series = chart.series.push(new am4charts.ColumnSeries());
series.dataFields.valueX = "to";
series.dataFields.openValueX = "from";
series.dataFields.categoryY = "category";
series.columns.template.propertyFields.fill = "fill";
series.columns.template.strokeOpacity = 0;
series.columns.template.height = am4core.percent(100);

// Ranges/labels
chart.events.on("beforedatavalidated", function(ev) {
  var data = chart.data;
  for(var i = 0; i < data.length; i++) {
    var range = xAxis.axisRanges.create();
    range.value = data[i].to;
    range.label.text = data[i].to + "%";
    range.label.horizontalCenter = "right";
    range.label.paddingLeft = 5;
    range.label.paddingTop = 5;
    range.label.fontSize = 10;
    range.grid.strokeOpacity = 0.2;
    range.tick.length = 18;
    range.tick.strokeOpacity = 0.2;
  }
});

// Legend
var legend = new am4charts.Legend();
legend.parent = chart.chartContainer;
legend.itemContainers.template.clickable = false;
legend.itemContainers.template.focusable = false;
legend.itemContainers.template.cursorOverStyle = am4core.MouseCursorStyle.default;
legend.align = "right";
legend.data = chart.data;

export {chart}
