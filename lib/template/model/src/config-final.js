var Publish = {
	"maxZoom": 20,
	"center": {
		"lat": -6.5003526449802,
		"long": -58.359336847922
	},
	"mapTypeId": "TERRAIN",
	"zoom": {
		"xTile": 256,
		"yTile": 256,
		"longFraction": 0.091434201766235,
		"latFraction": 0.066839756754966
	},
	"legend": "Legend",
	"minZoom": 0,
	"path": "./",
	"data": {
		"settlements": {
			"title": "Settlement",
			"time": "snapshot",
			"decimal": 5,
			"geom": "WMS",
			"scenario": [],
			"color": [
				"rgba(214, 133, 137, 1)"
			],
			"download": false,
			"transparency": 1,
			"name": [
				"amazon:settlements_1970",
				"amazon:settlements_1980",
				"amazon:settlements_1990",
				"amazon:settlements_2000",
				"amazon:settlements_2005",
				"amazon:settlements_2010",
				"amazon:settlements_2015"
			],
			"description": "Settlements. Source: ",
			"width": 1,
			"order": 2,
			"label": {
				"Settlement": "rgba(214, 133, 137, 1)"
			},
			"timeline": [
				1970,
				1980,
				1990,
				2000,
				2005,
				2010,
				2015
			],
			"url": "http://35.198.39.192/geoserver/wms",
			"visible": true,
			"id": "settlements"
		},
		"federalConservationUnits": {
			"title": "Federal conservation area",
			"time": "snapshot",
			"decimal": 5,
			"geom": "WMS",
			"scenario": [],
			"color": [
				"rgba(211, 255, 190, 1)"
			],
			"download": false,
			"transparency": 1,
			"name": [
				"amazon:federalConservationUnits_1970",
				"amazon:federalConservationUnits_1980",
				"amazon:federalConservationUnits_1990",
				"amazon:federalConservationUnits_2000",
				"amazon:federalConservationUnits_2005",
				"amazon:federalConservationUnits_2010",
				"amazon:federalConservationUnits_2015"
			],
			"description": "Federal conservation areas. Source: Ministry of Environment (MMA).",
			"width": 1,
			"order": 6,
			"label": {
				"Conservation area": "rgba(211, 255, 190, 1)"
			},
			"timeline": [
				1970,
				1980,
				1990,
				2000,
				2005,
				2010,
				2015
			],
			"url": "http://35.198.39.192/geoserver/wms",
			"visible": true,
			"id": "federalConservationUnits"
		},
		"roads": {
			"download": false,
			"time": "snapshot",
			"decimal": 5,
			"geom": "WMS",
			"transparency": 0.7,
			"name": [
				"amazon:roads_1970",
				"amazon:roads_1980",
				"amazon:roads_1990",
				"amazon:roads_2000",
				"amazon:roads_2005",
				"amazon:roads_2010",
				"amazon:roads_2015"
			],
			"url": "http://35.198.39.192/geoserver/wms",
			"description": "Federal roads.",
			"width": 1,
			"timeline": [
				1970,
				1980,
				1990,
				2000,
				2005,
				2010,
				2015
			],
			"order": 3,
			"label": {
				"Non-paved": "#732600",
				"Paved": "#6E6E6E"
			},
			"visible": true,
			"scenario": [],
			"color": [
				"#6E6E6E",
				"#732600"
			],
			"id": "roads"
		},
		"indigenousLand": {
			"title": "Indigenous area",
			"time": "snapshot",
			"decimal": 5,
			"geom": "WMS",
			"scenario": [],
			"color": [
				"rgba(214, 133, 137, 1)"
			],
			"download": false,
			"transparency": 1,
			"name": [
				"amazon:indigenousLand_1970",
				"amazon:indigenousLand_1980",
				"amazon:indigenousLand_1990",
				"amazon:indigenousLand_2000",
				"amazon:indigenousLand_2005",
				"amazon:indigenousLand_2010",
				"amazon:indigenousLand_2015"
			],
			"description": "Indigenous areas. Source: ",
			"width": 1,
			"order": 5,
			"label": {
				"Indigenous area": "rgba(214, 133, 137, 1)"
			},
			"timeline": [
				1970,
				1980,
				1990,
				2000,
				2005,
				2010,
				2015
			],
			"url": "http://35.198.39.192/geoserver/wms",
			"visible": true,
			"id": "indigenousLand"
		},
		"deforestationMask": {
			"download": false,
			"decimal": 5,
			"geom": "WMS",
			"transparency": 1,
			"name": "amazon:deforestationMask",
			"url": "http://35.198.39.192/geoserver/wms",
			"description": "PRODES deforestation mask. It includes the two areas that were never pristine forest: water bodies and. Source: ",
			"visible": false,
			"order": 7,
			"label": {
				"Non-forest": "rgba(174, 87, 165, 1)"
			},
			"title": "PRODES deforestation mask",
			"width": 1,
			"color": [
				"rgba(174, 87, 165, 1)"
			],
			"id": "deforestationMask"
		},
		"prodes": {
			"title": "Prodes",
			"time": "snapshot",
			"decimal": 5,
			"geom": "WMS",
			"scenario": [],
			"color": [
				"#FF0000"
			],
			"download": false,
			"transparency": 1,
			"name": [
				"amazon:prodes_2000",
				"amazon:prodes_2005",
				"amazon:prodes_2010",
				"amazon:prodes_2015"
			],
			"description": "Monitoring of the Amazon Rainforest by Satellite.",
			"width": 1,
			"order": 4,
			"label": {
				"Prodes": "#FF0000"
			},
			"timeline": [
				2000,
				2005,
				2010,
				2015
			],
			"url": "http://35.198.39.192/geoserver/wms",
			"visible": true,
			"id": "prodes"
		},
		"stateConservationUnits": {
			"title": "State conservation area",
			"time": "snapshot",
			"decimal": 5,
			"geom": "WMS",
			"scenario": [],
			"color": [
				"rgba(233, 255, 190, 1)"
			],
			"download": false,
			"transparency": 1,
			"name": [
				"amazon:stateConservationUnits_1980",
				"amazon:stateConservationUnits_1990",
				"amazon:stateConservationUnits_2000",
				"amazon:stateConservationUnits_2005",
				"amazon:stateConservationUnits_2010",
				"amazon:stateConservationUnits_2015"
			],
			"description": "State conservation areas. Source: Ministry of Environment (MMA).",
			"width": 1,
			"order": 1,
			"label": {
				"Conservation area": "rgba(233, 255, 190, 1)"
			},
			"timeline": [
				1980,
				1990,
				2000,
				2005,
				2010,
				2015
			],
			"url": "http://35.198.39.192/geoserver/wms",
			"visible": true,
			"id": "stateConservationUnits"
		},
		"dam": {
			"title": "Dam",
			"time": "snapshot",
			"decimal": 5,
			"geom": "WMS",
			"scenario": [],
			"color": [
				"rgba(0, 0, 255, 1)"
			],
			"download": false,
			"transparency": 1,
			"name": [
				"amazon:dam_1970",
				"amazon:dam_1980",
				"amazon:dam_1990",
				"amazon:dam_2000",
				"amazon:dam_2005",
				"amazon:dam_2010",
				"amazon:dam_2015"
			],
			"description": "Working dams. Source: ana.gov.br.",
			"width": 1,
			"order": 8,
			"label": {
				"Dam": "rgba(0, 0, 255, 1)"
			},
			"timeline": [
				1970,
				1980,
				1990,
				2000,
				2005,
				2010,
				2015
			],
			"url": "http://35.198.39.192/geoserver/wms",
			"visible": true,
			"id": "dam"
		}
	}
};