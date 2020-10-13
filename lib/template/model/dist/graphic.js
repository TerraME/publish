/**
 * This is a description of the chart function
 * @author Ryan Douglas da Silva <ryandouglasdasilva@outlook.com>
 * @version 0.1
 *
 * @author Heitor Carneiro <heitorgcarneiro@gmail.com>
 * @version 0.2
 */
$(function () {
    function getRandomRgba() {
        var t = Math.round(16777215 * Math.random()),
            e = t >> 16,
            a = t >> 8 & 255,
            r = 255 & t;
        return ["rgba(" + e + ", " + a + ", " + r + ", 1)", "rgba(" + e + ", " + a + ", " + r + ", 0.3)"]
    }

    function getChartType(tableElement) {
        var chartType = 'line';
        if (tableElement.classList.contains("line")) {
            chartType = "line"
        } else if (tableElement.classList.contains("bar")) {
            chartType = "bar"
        } else if (tableElement.classList.contains("radar")) {
            chartType = "radar"
        }
        return chartType;
    }

    function setLabels(data, trs) {
        var ths = trs[1].getElementsByTagName("th");
        if (ths && ths.length) {
            for (var indexTh = 0; indexTh < ths.length; indexTh++) {
                var th = ths[indexTh];
                if (th && th.innerText) {
                    data.labels.push(th.innerText.trim());
                }
            }
        }
    }

    function createDataset(tds) {
        var chartColor = getRandomRgba();
        var dataset = {
            label: '',
            data: [],
            backgroundColor: chartColor[1],
            borderColor: chartColor[0],
            borderWidth: 1,
            hidden: false
        }

        for (var indexTd = 0; indexTd < tds.length; indexTd++) {
            var td = tds[indexTd];
            if (td && td.innerText) {
                var innerText = td.innerText.trim();
                if (indexTd === 0) {
                    dataset.label = innerText;
                } else {
                    dataset.data.push(innerText);
                }
            }
        }

        return dataset;
    }

    function setDatasets(data, trs, datasetsStartIndex) {
        for (var indexTr = datasetsStartIndex; indexTr < trs.length; indexTr++) {
            var tds = trs[indexTr].getElementsByTagName("td");
            if (tds && tds.length) {
                var dataset = createDataset(tds);
                data.datasets.push(dataset);
            }
        }
    }

    function createSingleChart(chart) {
        const tableElement = document.querySelector("table." + chart.id);
        if (!tableElement) {
            return;
        }

        var chartType = getChartType(tableElement);
        var trs = tableElement.getElementsByTagName("tr");
        if (!(trs && trs.length)) {
            return;
        }

        var data = {
            title: '',
            labels: [],
            datasets: []
        };

        if (trs[0].innerText) {
            data.title = trs[0].innerText.trim()
        }

        if (trs[1]) {
            setLabels(data, trs);
        }

        var datasetsStartIndex = 2;
        if (trs[datasetsStartIndex]) {
            setDatasets(data, trs, datasetsStartIndex);
        }

        if (data.datasets.length) {
            var chartContext = document.getElementById(chart.id).getContext("2d");
            new Chart(chartContext, {
                type: chartType,
                data: {
                    labels: data.labels,
                    datasets: data.datasets
                },
                options: {
                    title: {
                        fontSize: 13,
                        display: !0,
                        text: data.title,
                        position: "top"
                    }
                }
            });
        }

    }

    /**
     * Main function
     */
    function createAllCharts() {
        var charts = document.querySelectorAll("canvas.chart");
        if (charts && charts.length) {
            charts.forEach(chart => {
                createSingleChart(chart);
            });
        }
    }

    createAllCharts();
});
