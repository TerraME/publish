var Publish = {
	zoom: null,
	minZoom: 0,
	maxZoom: 20,
	mapTypeId: "SATELLITE",
	legend: "Legend",
	path: (function(){
		var data = "./data/";
		var url = "";
		if(url)
			return data + url + "/";
		return data;
	}()),
	data: {
		river: ["river", { 0: "rgba(236, 231, 242, 1)",1: "rgba(166, 189, 219, 1)",2: "rgba(43, 140, 190, 1)", }],
		limit: ["river", { 0: "rgba(236, 231, 242, 1)",1: "rgba(166, 189, 219, 1)",2: "rgba(43, 140, 190, 1)", }],
		cells: ["river", { 0: "rgba(236, 231, 242, 1)",1: "rgba(166, 189, 219, 1)",2: "rgba(43, 140, 190, 1)", }],
		firebreak: ["river", { 0: "rgba(236, 231, 242, 1)",1: "rgba(166, 189, 219, 1)",2: "rgba(43, 140, 190, 1)", }],
	}
};