var Publish = {
	"maxZoom": 20,
	"path": ".\/data\/urbis\/",
	"mapTypeId": "SATELLITE",
	"legend": "Legend",
	"minZoom": 0,
	"data": {
		"real": {
			"select": "classe",
			"width": 0,
			"description": "This is the main endogenous variable of the model. It was obtained from a classification that categorizes the social conditions of households in Caraguatatuba on 'condition A' (best), 'B' or 'C''.",
			"order": 3,
			"color": {
				"3": "yellow",
				"2": "orange",
				"1": "red"
			},
			"title": "Social Classes 2010 Real",
			"visible": false
		},
		"plus": {
			"select": "classe",
			"width": 0,
			"description": "The base scenario considers the zoning proposed by the new master plan of Caraguatatuba.",
			"order": 7,
			"color": {
				"3": "yellow",
				"2": "orange",
				"1": "red"
			},
			"title": "Urban Population Plusgrowth 2025",
			"visible": false
		},
		"regions": {
			"select": "name",
			"width": 1,
			"description": "Regions of Caraguatatuba",
			"order": 2,
			"color": {
				"3": "rgba(141, 160, 203, 1)",
				"2": "rgba(252, 141, 98, 1)",
				"1": "rgba(102, 194, 165, 1)"
			},
			"title": "Regions",
			"visible": false
		},
		"less": {
			"select": "classe",
			"width": 0,
			"description": "The base scenario considers the zoning proposed by the new master plan of Caraguatatuba.",
			"order": 6,
			"color": {
				"3": "yellow",
				"2": "orange",
				"1": "red"
			},
			"title": "Urban Population Lessgrowth 2025",
			"visible": false
		},
		"baseline": {
			"select": "classe",
			"width": 0,
			"description": "The base scenario considers the zoning proposed by the new master plan of Caraguatatuba.",
			"order": 5,
			"color": {
				"3": "yellow",
				"2": "orange",
				"1": "red"
			},
			"title": "Social Classes 2025 Simulated",
			"visible": false
		},
		"richer": {
			"select": "classe",
			"width": 0,
			"description": "The base scenario considers the zoning proposed by the new master plan of Caraguatatuba.",
			"order": 9,
			"color": {
				"3": "yellow",
				"2": "orange",
				"1": "red"
			},
			"title": "Socioeconomic Status Richer 2025",
			"visible": false
		},
		"use": {
			"select": "uso",
			"width": 0,
			"description": "The occupational class describes the percentage of houses and apartments inside such areas that have occasional use. The dwelling is typically used in summer vacations and holidays.",
			"order": 4,
			"color": {
				"3": "rgba(230, 117, 228, 1)",
				"2": "rgba(242, 160, 241, 1)",
				"5": "rgba(199, 0, 199, 1)",
				"4": "rgba(214, 71, 212, 1)",
				"1": "rgba(255, 204, 255, 1)"
			},
			"title": "Occupational Classes (IBGE, 2010)",
			"visible": false
		},
		"limit": {
			"description": "Bounding box of Caraguatatuba",
			"order": 1,
			"visible": true,
			"color": "rgba(218, 165, 32, 1)",
			"width": 1
		},
		"poorer": {
			"select": "classe",
			"width": 0,
			"description": "The base scenario considers the zoning proposed by the new master plan of Caraguatatuba.",
			"order": 8,
			"color": {
				"3": "yellow",
				"2": "orange",
				"1": "red"
			},
			"title": "Socioeconomic Status Poorer 2025",
			"visible": false
		}
	}
};