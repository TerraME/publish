var Publish = {
	"mapTypeId": "SATELLITE",
	"center": {
		"long": -45.489454594686,
		"lat": -23.621560836269
	},
	"group": {
		"Border": "limit",
		"OccupationalClasses": "use",
		"SocialClasses": "classes"
	},
	"scenarioWrapper": {
		"Base Line": "baseline",
		"Less Growth": "lessgrowth",
		"Plus Growth": "plusgrowth"
	},
	"data": {
		"classes": {
			"group": "SocialClasses",
			"id": "classes",
			"width": 0,
			"title": "Social Classes 2010",
			"transparency": 1,
			"label": {
				"Condition C": "rgba(255, 0, 0, 1)",
				"Condition B": "rgba(255, 165, 0, 1)",
				"Condition A": "rgba(255, 255, 0, 1)"
			},
			"description": "This is the main endogenous variable of the model. It was obtained from a classification that categorizes the social conditions of households in Caraguatatuba on 'condition A' (best), 'B' or 'C''.",
			"color": {
				"1": "rgba(255, 0, 0, 1)",
				"2": "rgba(255, 165, 0, 1)",
				"3": "rgba(255, 255, 0, 1)"
			},
			"decimal": 5,
			"visible": true,
			"order": 4,
			"report": "table",
			"download": false,
			"scenario": {
				"plusgrowth": {
					"name": [
						"classes_plusgrowth_2025"
					],
					"timeline": [
						2025
					]
				},
				"baseline": {
					"name": [
						"classes_baseline_2025"
					],
					"timeline": [
						2025
					]
				},
				"lessgrowth": {
					"name": [
						"classes_lessgrowth_2025"
					],
					"timeline": [
						2025
					]
				}
			},
			"select": "classe",
			"geom": "MultiPolygon",
			"timeline": [
				2010
			],
			"name": [
				"classes_2010"
			],
			"time": "snapshot"
		},
		"use": {
			"group": "OccupationalClasses",
			"report": "table",
			"visible": true,
			"width": 0,
			"geom": "MultiPolygon",
			"id": "use",
			"order": 1,
			"title": "Occupational Classes 2010",
			"transparency": 1,
			"download": false,
			"label": {
				"0.700001 - 0.930000": "rgba(122, 1, 119, 1)",
				"0.500001 - 0.700000": "rgba(197, 27, 138, 1)",
				"0.350001 - 0.500000": "rgba(247, 104, 161, 1)",
				"0.200001 - 0.350000": "rgba(251, 180, 185, 1)",
				"0.000000 - 0.200000": "rgba(254, 235, 226, 1)"
			},
			"select": "uso",
			"description": "The occupational class describes the percentage of houses and apartments inside such areas that have occasional use. The dwelling is typically used in summer vacations and holidays.",
			"color": {
				"1": "rgba(254, 235, 226, 1)",
				"2": "rgba(251, 180, 185, 1)",
				"3": "rgba(247, 104, 161, 1)",
				"4": "rgba(197, 27, 138, 1)",
				"5": "rgba(122, 1, 119, 1)"
			},
			"decimal": 5
		},
		"limit": {
			"group": "Border",
			"visible": true,
			"id": "limit",
			"width": 1,
			"report": "table",
			"download": false,
			"geom": "MultiPolygon",
			"order": 3,
			"transparency": 1,
			"description": "Bounding box of Caraguatatuba.",
			"color": "rgba(218, 165, 32, 1)",
			"decimal": 5
		},
		"regions": {
			"group": "Border",
			"report": "table",
			"visible": false,
			"geom": "MultiPolygon",
			"id": "regions",
			"order": 2,
			"select": "name",
			"transparency": 1,
			"width": 1,
			"label": {
				"South": "rgba(141, 160, 203, 1)",
				"Central": "rgba(252, 141, 98, 1)",
				"North": "rgba(102, 194, 165, 1)"
			},
			"download": false,
			"description": "Regions of Caraguatatuba.",
			"color": {
				"1": "rgba(102, 194, 165, 1)",
				"2": "rgba(252, 141, 98, 1)",
				"3": "rgba(141, 160, 203, 1)"
			},
			"decimal": 5
		}
	},
	"scenario": {
		"baseline": "Baseline simulation for 2025.",
		"plusgrowth": "Plus growth simulation in 2025. Categorizes the social conditions of households in Caraguatatuba using classes A (3), B (2) or C (1).",
		"lessgrowth": "Less growth simulation in 2025. Categorizes the social conditions of households in Caraguatatuba using classes A (3), B (2) or C (1)."
	},
	"minZoom": 0,
	"zoom": {
		"xTile": 256,
		"yTile": 256,
		"longFraction": 0.0012789097413039,
		"latFraction": 0.00083946787647867
	},
	"legend": "Legend",
	"path": "./data/scenario/",
	"maxZoom": 20
};