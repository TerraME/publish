
/**
* This is a description of the chart function
* @author Ryan Douglas da Silva <ryandouglasdasilva@outlook.com>
* @version 0.1
*/

/**
 * This is a description of the chart function
 * @author Ryan Douglas da Silva <ryandouglasdasilva@outlook.com>
 * @version 0.1
 */
var chartType = "line";

function getRandomRgba() {
  var t = Math.round(16777215 * Math.random()),
    e = t >> 16,
    a = t >> 8 & 255,
    r = 255 & t;
  return ["rgba(" + e + ", " + a + ", " + r + ", 1)", "rgba(" + e + ", " + a + ", " + r + ", 0.3)"]
}
var table = document.querySelectorAll("canvas.chart"),
  area = document.querySelectorAll(".legend-color.box"),
  tableByArea = table.length / area.length;

function tableToArray(t) {
  var e = document.getElementById(t.id).getContext("2d");
  return {
    Title: document.querySelectorAll("." + t.id + " th"),
    Data: document.querySelectorAll("." + t.id + " td"),
    ctx: e
  }
}

function getChartData(t) {
  var e = [],
    a = [];
  for (y = 2; y < t.Title.length; y++) e.push(t.Title[y].innerText);
  var r = t.Data.length / (t.Title.length - 1);
  for (z = 0; z < r; ++z) {
    for (chartColor = getRandomRgba(), dataArray = [], i = 0; i < t.Title.length - 1; i++) !i % (t.Title.length - 1) == 0 && dataArray.push(t.Data[i + (t.Title.length - 1) * z].innerText);
    a.push({
      label: t.Data[z * (t.Title.length - 1)].innerText,
      data: dataArray,
      backgroundColor: chartColor[1],
      borderColor: chartColor[0],
      borderWidth: 1,
      hidden: !1
    })
  }
  return [e, a]
}

function generateChart() {
  
  var fronTables = document.querySelectorAll('canvas.chart');

  for (x = 0; x < table.length; x++) {

    var classes = document.querySelectorAll('.'+fronTables[x].id)
    classes = classes[0].classList

    var chartType = 'line';

    if(classes.contains("line")) {
      chartType = "line"
    } else if(classes.contains("bar")) {
      chartType = "bar"
    } else if(classes.contains("radar")) {
      chartType = "radar"
    }

    var e = tableToArray(table[x]),
      a = getChartData(e);
    new Chart(e.ctx, {
      type: chartType,
      data: {
        labels: a[0],
        datasets: a[1]
      },
      options: {
        title: {
          fontSize: 13,
          display: !0,
          text: "" + e.Title[0].innerText,
          position: "top"
        }
      }
    })
  }
}

generateChart();