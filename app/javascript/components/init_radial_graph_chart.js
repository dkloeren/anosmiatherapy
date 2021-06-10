/* Imports */
import * as am4core from "@amcharts/amcharts4/core";
import * as am4charts from "@amcharts/amcharts4/charts";
import am4themes_animated from "@amcharts/amcharts4/themes/animated";


const iniRadialGraphChart = () => {
  const chartElement = document.getElementById('chart_radial_graph');
  if (chartElement) {
    am4core.useTheme(am4themes_animated);
    const chart = am4core.create("chart_radial_graph", am4charts.XYChart);

    // Create data
    const data = [];
    const overview = JSON.parse(chartElement.dataset.overview);
    var year = 2000
    overview.forEach((entry, index) => {
      data.push({
        "year": year.toString(),
        "value1" : overview.strength,
        "value2" : overview.accuracy
      })
      year += 1;
    });

    console.log(data)
    console.log(overview)
    // let data = [];
    // let value1 = 500;
    // let value2 = 600;

    // for(var i = 0; i < 12; i++){
    //   let date = new Date();
    //   date.setMonth(i, 1);
    //   value1 -= Math.round((Math.random() < 0.5 ? 1 : -1) * Math.random() * 50);
    //   value2 -= Math.round((Math.random() < 0.5 ? 1 : -1) * Math.random() * 50);
    //   data.push({date:date, value1:value1, value2:value2})
    // }

    chart.data = data;

    /* Create axes */
    let categoryAxis = chart.xAxes.push(new am4charts.DateAxis());

    let valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
    valueAxis.extraMin = 0.2;
    valueAxis.extraMax = 0.2;
    valueAxis.tooltip.disabled = true;

    /* Create and configure series */
    let series1 = chart.series.push(new am4charts.RadarSeries());
    series1.dataFields.valueY = "value1";
    series1.dataFields.dateX = "date";
    series1.strokeWidth = 3;
    series1.tooltipText = "{valueY}";
    series1.name = "Series 2";
    series1.bullets.create(am4charts.CircleBullet);
    series1.dataItems.template.locations.dateX = 0.5;

    let series2 = chart.series.push(new am4charts.RadarSeries());
    series2.dataFields.valueY = "value2";
    series2.dataFields.dateX = "date";
    series2.strokeWidth = 3;
    series2.tooltipText = "{valueY}";
    series2.name = "Series 2";
    series2.bullets.create(am4charts.CircleBullet);
    series2.dataItems.template.locations.dateX = 0.5;

    chart.scrollbarX = new am4core.Scrollbar();
    chart.scrollbarY = new am4core.Scrollbar();

    chart.cursor = new am4charts.RadarCursor();

    chart.legend = new am4charts.Legend();
  }
}

export {iniRadialGraphChart}
