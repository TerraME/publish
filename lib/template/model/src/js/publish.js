$(function () {
	var map, menu;
	var data = {};
	var layersName = {};
	var $legend = $('#legend');
	var $loader = $('#loader');
	var $loaderMessage = $('#loader-message');
	var $loaderMessageText = $('#loader-message-text');
	var $description = $('#layer-description');
	var $properties = $('#properties');
	var $legends = $('#legends');
	var $descriptionTitle = $('#description-title');
	var $legendTitle = $('#legend-title');
	var $layersTitle = $('#layers-title');
	var $downloadTitle = $('#download-title');
	var $panelDownload = $('#panel-download');
	var $leftToggler = $('.mini-submenu-left');
	var $sidebar = $('.sidebar');
	var $sidebarLeftBody = $('.sidebar-left .sidebar-body');
	var $sidebarLeftSubmenu = $('.sidebar-left .slide-submenu');
	var $modalDescription = $('#modal-app-description');
	var $modalCompletedDescription = $("#modal-completed-description");
	var $modalTitleDescription = $("#modal-title-description");
	var $infoDescription = $("#info-description");
	var $map = $('#map');
	var $more = $('#more');
	var $layers = $('#layers');
	var $views = $layers.find('label');
	var $viewsLayers = $views.find('input');
	var $viewsInformation = $views.find('a');
	var $play = $('#play');
	var $slider = $('#slider');
	var $sliderContainer = $('#slider-container');
	var $sliderCol = $('#slider-col');
	var $detachedSliderContainer = null;
	var $spanSelectedYear = $('#spanSelectedYear');
	var $scenarioCombobox = $('#scenario-combobox');
	var $scenarioDescription = $('#scenario-description');
	var $scenarioMore = $('#more-scenario-description');
	var $scenarioModalCompletedDescription = $("#modal-scenario-completed-description");
	var $scenarioModalTitleDescription = $("#modal-scenario-title-description");
	var $scenarioInfoDescription = $("#scenario-info-description");
	var navBarHeight = $('.navbar').height();
	var mapHeight = $map.height();
	var timelineLayers = [];
	var timelineYears = [];
	var selectedInterval = [];
	var viewsActive = {};
	var viewsCheckbox = {};
	var scenarioApp = {};
	var scenarioState = {};
	var scenarioCache = {};
	var hasTemporalView = false;
	var hasScenario = false;
	var hasWMS = false;

	var SLIDER_INTERVAL = Publish.interval || 1000;

	var GEOMETRY = {
		Point: "Point",
		MultiPoint: "MultiPoint",
		LineString: "LineString",
		MultiLineString: "MultiLineString",
		WMS: "WMS"
	};

	function addLegendContent(lengend, color, label) {
		var $div = $('<div style="height:25px;">');
		if (color.endsWith(".png")) {
			$div.append($('<div class="legend-img-box">').css('background-image', 'url(' + color + ')'));
		} else {
			$div.append($('<div class="legend-color-box">').css({ backgroundColor: color }));
		}

		$div.append($('<span>').css("lineHeight", "23px").html(label));
		lengend.append($div);
	}

	function renderLegend(label) {
		$legend.empty();
		$legendTitle.text("  " + Publish.legend);

		var keys = [];
		$.each(label, function (text) {
			keys.push(text);
		});

		keys.sort();
		$.each(keys, function (_, text) {
			var color = label[text];
			addLegendContent($legend, color, text);
		});
	}

	function refreshMenu(selected, layer) {
		var emptyStr = "";
		var spaceStr = " ";
		var dot = ".";

		var label = selected.label;
		var title = layer || "Description";
		var description = selected.description || emptyStr;
		var sentences = description.split(dot);

		var firstSentence = sentences[0] ? sentences[0] + dot : emptyStr;

		var navBarProportionHeight = navBarHeight + 40;

		var proportionLayer = (((mapHeight - navBarProportionHeight) * 40) / 100);
		var proportion = (((mapHeight - navBarProportionHeight) * 20) / 100);

		if ($layers.height() < proportionLayer)
			proportion = (((mapHeight - navBarProportionHeight) * 30) / 100);

		$layers.css('max-height', proportionLayer);
		$properties.css('max-height', proportion);
		$legends.css('max-height', proportion);

		if ((sentences.length - 1) > 1)
			$more.show();
		else
			$more.hide();

		$descriptionTitle.text(spaceStr + title);
		$description.text(firstSentence);

		$modalTitleDescription.text(spaceStr + title);
		$infoDescription.text(description);

		renderLegend(label);
	}

	function setStyle(feature) {
		return {
			fillColor: feature.getProperty("color"),
			strokeColor: feature.getProperty("border"),
			strokeWeight: feature.getProperty("width"),
			zIndex: feature.getProperty("order"),
			icon: feature.getProperty("icon")
		};
	}

	function getColorStrategy(selected) {
		var colors = selected.color;
		if (selected.slices) {
			var slicesColors = Object.keys(colors).sort(function (a, b) {
				return a - b;
			});
			var slicesRange = slicesColors.map(Number);
			return function (value) {
				var currentColor = null;
				$.each(slicesRange, function (idx, slice) {
					if (value >= slice) {
						currentColor = colors[slicesColors[idx]];
					}
				});

				return currentColor;
			};
		} else {
			return function (value) {
				return colors[value];
			};
		}
	}

	function setFeatureProperties(feature, layer, selected) {
		var type = selected.geom || feature.getGeometry().getType();
		var select = getSelect(selected, 1);
		var getColor = getColorStrategy(selected);

		if (selected.icon && (type === GEOMETRY.Point || type === GEOMETRY.MultiPoint)) {
			var icon = selected.icon.options[feature.getProperty(select)];
			if (!icon) {
				icon = selected.icon.path;
			}

			feature.setProperty("icon", icon);
		} else {
			var property = select || layer;
			var colors = selected.color;

			if ($.type(colors) === "object") {
				feature.setProperty("color", getColor(feature.getProperty(property)));
			} else {
				feature.setProperty("color", colors);
			}

			feature.setProperty("border", selected.border);
			feature.setProperty("width", selected.width);
		}

		feature.setProperty("order", selected.order);
	}

	function setFeatureStyle(gdata, layer, selected) {
		gdata.setStyle(setStyle);
		if (selected.report) {
			gdata.addListener("click", function (event) {
				if (selected.report === "function") {
					var select = event.feature.getProperty(getSelect(selected, 0));
					if ($.type(select) === "string") {
						select = select.replace(/\s/g, "");
					}

					$('#modal-report-' + layer + select).modal('show');
				} else {
					$('#modal-report-' + layer).modal('show');
				}
			});
		}

		data[layer] = gdata;
	}

	function changePolylineLayer(id, path, time) {
		$.each(path, function (_, pol) {
			if (pol.getVisible()) {
				removePolyline(id, pol);
			} else {
				drawPolyline(id, pol, time);
				changeMenu(id, $properties.hasClass("in"), $legends.hasClass("in"));
			}
		});
	}

	function isLineString(element) {
		return element.geom === GEOMETRY.LineString;
	}

	function isMultiLineString(element) {
		return element.geom === GEOMETRY.MultiLineString;
	}

	function isLineStringOrMultiLineString(element) {
		return isLineString(element) || isMultiLineString(element);
	}

	function loadData(layer, selected, __sof__) {
		var visible = selected.visible;
		var viewInCheckBox = (selected.time) ? selected.id : layer;
		if (selected.geom === "WMS") {
			var deferred = new $.Deferred();
			var name = (selected.time) ? layer : selected.name;
			var mdata = new geoambiente.maps.WmsLayer({
				url: selected.url,
				layer: name,
				visibility: visible,
				opacity: selected.transparency,
				map: map
			});

			deferred.resolve(mdata);
			data[layer] = mdata;
			if (visible) setCheckbox(viewInCheckBox, true);
			if (!hasWMS) hasWMS = true;
			if (__sof__) __sof__(mdata);
			return deferred.promise();
		} else {
			var url = Publish.path + layer + ".geojson";
			return $.getJSON(url, function (geojson) {
				var mdata = new google.maps.Data();
				mdata.addGeoJson(geojson);

				if (isLineStringOrMultiLineString(selected)) {
					setPolylineProperties(mdata, layer, selected);
				} else {
					setDataProperties(mdata, layer, selected);
					if (visible) {
						mdata.setMap(map);
						setCheckbox(viewInCheckBox, true);
					}

					if (__sof__) __sof__(mdata);
				}
			});
		}
	}

	function removeLayer(gdata, id) {
		gdata.setMap(null);
		setCheckbox(id, false);
	}

	function addLayer(gdata, id) {
		gdata.setMap(map);
		setCheckbox(id, true);
		changeMenu(id, $properties.hasClass("in"), $legends.hasClass("in"));
	}

	function drawTimelineLayers() {
		var firstYear = selectedInterval[0];
		var lastYear = selectedInterval[1];
		if ((firstYear !== null && firstYear !== undefined) && (lastYear !== null && lastYear !== undefined)) {
			for (var i = firstYear; i <= lastYear; i++) {
				setLayerVisibility(i);
			}
		}
	}

	function changePolyline(selected, layer, mdata) {
		var time = selected.icon.time;
		if (isLineString(selected)) {
			changePolylineLayer(layer, mdata, time);
		} else {
			$.each(mdata, function (_, path) {
				changePolylineLayer(layer, path, time);
			});
		}
	}

	function changePolygon(layer, mdata) {
		if (viewsActive[layer]) {
			removeLayer(mdata, layer);
		} else {
			addLayer(mdata, layer);
		}
	}

	function changePolygonTimeline(layer) {
		if (viewsActive[layer]) {
			setCheckbox(layer, false);
		} else {
			setCheckbox(layer, true);
			changeMenu(layer, $properties.hasClass("in"), $legends.hasClass("in"));
		}

		drawTimelineLayers();
	}

	function changeLayer(layer) {
		var selected = Publish.data[layer];
		if (selected.time) {
			changePolygonTimeline(layer);
		} else {
			var mdata = data[layer];
			if (mdata) {
				if (isLineStringOrMultiLineString(selected)) {
					changePolyline(selected, layer, mdata);
				} else {
					changePolygon(layer, mdata);
				}
			} else {
				enableLoaderMessage();
				$loaderMessageText.empty();
				addLoaderMessage(layer, 1, 1);
				selected.visible = true;
				loadData(layer, selected).done(function () {
					changeMenu(layer, $properties.hasClass("in"), $legends.hasClass("in"));
				}).always(function () {
					disableLoaderMessage();
				});
			}
		}
	}

	function disableMenu($propertiesHasClass, $legendsHasClass) {
		menu = null;
		$legend.empty();
		$description.empty();
		$descriptionTitle.text(" Description");
		$panelDownload.hide();
		$("button").removeClass("button-selected");

		if ($propertiesHasClass) {
			$descriptionTitle.click();
			$descriptionTitle.prop('disabled', true);
		}

		if ($legendsHasClass) {
			$legendTitle.click();
			$legendTitle.prop('disabled', true);
		}
	}

	function changeMenu(id, $propertiesHasClass, $legendsHasClass) {
		menu = id;
		var selected = Publish.data[id];
		refreshMenu(selected, layersName[id]);

		if (!$propertiesHasClass) {
			$descriptionTitle.prop('disabled', false);
			$descriptionTitle.click();
		}

		if (!$legendsHasClass) {
			$legendTitle.prop('disabled', false);
			$legendTitle.click();
		}

		if (selected.download) {
			var filename = id + ".zip";
			$downloadTitle.prop('href', Publish.path + filename);
			$downloadTitle.prop('download', filename);
			$panelDownload.show();
		} else {
			$panelDownload.hide();
		}

		$viewsInformation.removeClass("button-selected");
		$("#" + id).addClass('button-selected');
	}

	function onInformationClick(event) {
		var id = event.target.id;
		if (!id) return;

		var $propertiesHasClass = $properties.hasClass("in");
		var $legendsHasClass = $legends.hasClass("in");
		if (menu === id) {
			disableMenu($propertiesHasClass, $legendsHasClass);
		} else {
			changeMenu(id, $propertiesHasClass, $legendsHasClass);
		}
	}

	function onLayerClick(event) {
		var id = event.target.name;
		if (!id) return;

		var groups = Publish.group;
		if (groups) {
			var group = Publish.data[id].group;
			var active = groups[group];
			if (!active) {
				groups[group] = id;
				changeLayer(id);
			} else {
				changeLayer(active);
				if (active === id) {
					groups[group] = null;
				} else {
					groups[group] = id;
					changeLayer(id);
				}
			}
		} else {
			changeLayer(id);
		}

		sliderToggle();
	}

	function animatedLine(id, polyline, interval) {
		var counter = 0;
		var func = setInterval(function () {
			counter = (counter + 1) % 200;
			var arrows = polyline.get('icons');
			arrows[0].offset = (counter / 2) + '%';
			polyline.set('icons', arrows);
		}, interval);

		if (!window.intervals) {
			window.intervals = {};
		}

		if (!window.intervals[id]) {
			window.intervals[id] = [];
		}

		window.intervals[id].push(func);
	}

	function createPolyline(selected, line) {
		var options = selected.icon.options;
		var path = [];

		line.forEachLatLng(function (latLong) {
			path.push(latLong);
		});

		var symbol = {
			path: options.path,
			anchor: new google.maps.Point(175, 175),
			scale: 0.1,
			fillColor: options.fillColor,
			fillOpacity: options.fillOpacity,
			strokeWeight: options.strokeWeight
		};

		var lineOptions = {
			path: path,
			icons: [{ icon: symbol }],
			strokeWeight: selected.width,
			strokeColor: selected.border || selected.color,
			strokeOpacity: selected.transparency
		};

		return new google.maps.Polyline(lineOptions);
	}

	function drawPolyline(id, polyline, interval) {
		polyline.setMap(map);
		polyline.setVisible(true);
		animatedLine(id, polyline, interval);
	}

	function removePolyline(id, polyline) {
		polyline.setMap(null);
		polyline.setVisible(false);

		if (window.intervals) {
			$.each(window.intervals[id], function (_, func) {
				clearInterval(func);
			});
		}
	}

	function setPolylineProperties(gdata, layer, selected) {
		var path = [];
		var visible = selected.visible;
		var time = selected.icon.time;
		gdata.forEach(function (feature) {
			var geom = feature.getGeometry();
			if (isLineString(selected)) {
				var pol = createPolyline(selected, geom);
				path.push(pol);
				if (visible) drawPolyline(layer, pol, time);
			} else if (isMultiLineString(selected)) {
				var points = [];
				$.each(geom.getArray(), function (_, line) {
					var pol = createPolyline(selected, line);
					points.push(pol);
					if (visible) drawPolyline(layer, pol, time);
				});

				path.push(points);
			}
		});

		data[layer] = path;
		if (visible) setCheckbox(layer, true);
	}

	function setDataProperties(gdata, layer, selected) {
		gdata.forEach(function (feature) {
			setFeatureProperties(feature, layer, selected);
		});

		setFeatureStyle(gdata, layer, selected);
	}

	function getLoadMessage(id, actual, total) {
		return "Loading" + layersName[id] + " (" + actual + "/" + total + ")";
	}

	function addLoaderMessage(id, actual, total) {
		var message = getLoadMessage(id, actual, total);
		$loaderMessageText.text(message);
	}

	function enableLoaderMessage() {
		$loader.fadeIn();
		$loaderMessage.css('z-index', 10000000);
	}

	function disableLoaderMessage() {
		$loader.fadeOut();
		$loaderMessageText.empty();
		$loaderMessage.css('z-index', -1);
	}

	function getInitialZoom(zoom, zoomMax) {
		if ($.type(zoom) === "number") {
			return zoom;
		}

		function getZoom(mapPx, worldPx, fraction) {
			return Math.floor(Math.log(mapPx / worldPx / fraction) / Math.LN2);
		}

		var latZoom = getZoom(mapHeight, zoom.yTile, zoom.latFraction);
		var longZoom = getZoom($map.width(), zoom.xTile, zoom.longFraction);
		return Math.min(latZoom, longZoom, zoomMax);
	}

	function clone(array) {
		var newArray = [];
		$.each(array, function (_, value) {
			newArray.push(value);
		});

		return newArray;
	}

	function loadInitialData(dataset) {
		var XHRs = [];
		var actual = 0;
		var total = Object.keys(dataset).length;

		var hasTemporalViewVisible = false;
		var timeCreation = "creation";

		enableLoaderMessage();
		$.each(dataset, function (id, selected) {
			initLabel(selected);
			var isLayerVisible = selected.visible;
			var timeStrategy = selected.time;

			if (selected.scenario) {
				scenarioApp[id] = true;
				if (!hasScenario) hasScenario = true;
			}

			if (!isLayerVisible && !timeStrategy) {
				return true;
			}

			actual += 1;
			$loaderMessageText.empty();
			addLoaderMessage(id, actual, total);
			if (timeStrategy) {
				var timelineIndex = 0;
				if (timeStrategy === timeCreation) {
					var url = Publish.path + id + ".geojson";
					XHRs.push($.getJSON(url, function (geojson) {
						var mdata = new google.maps.Data();
						mdata.addGeoJson(geojson);

						var years = {};
						$.each(selected.timeline, function (_, year) {
							years[year] = new google.maps.Data();
						});

						var select = selected.name;
						mdata.forEach(function (feature) {
							setFeatureProperties(feature, id, selected);
							var year = feature.getProperty(select);
							var newData = years[year];
							if (newData) {
								newData.add(feature);
							}
						});

						selected.name = [];
						$.each(years, function (year, gdata) {
							var layer = id + "_" + year;
							setFeatureStyle(gdata, layer, selected);
							timelineValues(year, gdata, id, timeStrategy);
							selected.name.push(layer);
							timelineIndex++;

							if (isLayerVisible) {
								gdata.setMap(map);
								setCheckbox(id, true);
							}
						});
					}));
				} else {
					$.each(selected.name, function (_, temporalLayer) {
						var year = selected.timeline[timelineIndex];
						XHRs.push(loadData(temporalLayer, selected, function (gdata) {
							timelineValues(year, gdata, id, timeStrategy);
						}));

						timelineIndex++;
					});
				}

				if (!hasTemporalView && isLayerVisible) {
					hasTemporalView = true;
					hasTemporalViewVisible = true;
				}
			} else {
				XHRs.push(loadData(id, selected));
			}
		});

		var $propertiesHasClass = $properties.hasClass("in");
		var $legendsHasClass = $legends.hasClass("in");
		var firstId = $viewsInformation[0].id;

		changeMenu(firstId, $propertiesHasClass, $legendsHasClass);

		$.when.apply($, XHRs).always(function () {
			if (hasTemporalViewVisible && hasTemporalView) {
				createSlider();
				scenarioState.timelineYears = clone(timelineYears);
				scenarioState.timelineLayers = clone(timelineLayers);
				scenarioState.backup = clone(timelineYears);
			}

			disableLoaderMessage();
		});
	}

	function initMap() {
		google.maps.visualRefresh = true;
		var mapOptions = {
			center: new google.maps.LatLng(Publish.center.lat, Publish.center.long),
			zoom: getInitialZoom(Publish.zoom, Publish.maxZoom),
			minZoom: Publish.minZoom,
			maxZoom: Publish.maxZoom,
			mapTypeId: google.maps.MapTypeId[Publish.mapTypeId],
			mapTypeControl: true,
			mapTypeControlOptions: {
				style: google.maps.MapTypeControlStyle.DROPDOWN_MENU,
				position: google.maps.ControlPosition.TOP_RIGHT
			}
		};

		map = new google.maps.Map($map[0], mapOptions);
		map.controls[google.maps.ControlPosition.BOTTOM_RIGHT].push($('#footer')[0]);
		startMenu();

		google.maps.event.addListenerOnce(map, "idle", function () {
			loadInitialData(Publish.data);
		});
	}

	google.maps.event.addDomListener(window, "load", initMap);

	function createSlider() {
		$slider.slider({
			range: true,
			min: 0,
			max: timelineYears.length - 1,
			step: 1,
			values: [0, timelineYears.length - 1]
		}).each(createTimeline).on("slide", changeSlide);

		sliderToggle();
	}

	function sliderToggle() {
		if (hasTemporalView) {
			if (hasOnlyOneViewTemporal()) {
				if (!$detachedSliderContainer) {
					$detachedSliderContainer = $sliderContainer.detach();
				}
			} else {
				var hasTemporalActive = hasTemporalViewActive();
				if (hasTemporalActive && $detachedSliderContainer !== null) {
					$detachedSliderContainer.appendTo($sliderCol);
					$detachedSliderContainer = null;
				} else if ((!hasTemporalActive && $detachedSliderContainer === null)) {
					$detachedSliderContainer = $sliderContainer.detach();
				}
			}			
		}
	}

	function setLayerVisibility(yearIndex) {
		$.each(timelineLayers, function (_, item) {
			var gmap = null;
			if (viewsActive[item.type] && item.year === timelineYears[yearIndex]) {
				gmap = map;
			}

			item.layer.setMap(gmap);
		});
	}

	function changeSlide(event, ui) {
		var vals = timelineYears.length - 1;
		var current = ui.values[1];
		var leftMargin = ((current / vals * 100) - 1) || 0;
		$spanSelectedYear.css('left', leftMargin + '%');
		selectedInterval = ui.values;
		setLayerVisibility(current);
	}

	function createTimeline() {
		var x = 0;
		var timelineYearsLength = timelineYears.length;
		var vals = timelineYearsLength - 1;
		selectedInterval = [0, vals];

		$.each(timelineYears, function (idx, item) {
			var leftMargin = (x / vals * 100) || 0;
			var el = $('<label>' + (item) + '</label>').css('left', leftMargin + '%');
			$slider.append(el);
			x++;
		});

		if (timelineYearsLength > 0) {
			var percentageThreshold = 6;
			var percentagePerElement = 100 / timelineYearsLength;
			if (percentagePerElement < percentageThreshold) {
				var maxIncrease = $map.width() * 0.6;
				var currentWidth = $sliderContainer.width();
				var newWidth = currentWidth * (percentageThreshold / percentagePerElement);

				if (newWidth > maxIncrease) {
					newWidth = maxIncrease;
				}

				$sliderContainer.width(newWidth);
			}
		}
	}

	function timelineValues(year, layer, index, time, scenario) {
		var exist = existYear(year);
		var position = identifyTimelinePosition(year);

		if (exist) {
			addArrayLayer(index, layer, year, time, scenario);
		}
		else {
			timelineYears.splice(position, 0, year);
			addArrayLayer(index, layer, year, time, scenario);
		}
	}

	function addArrayLayer(type, layer, year, time, scenario) {
		timelineLayers.push(
			{
				type: type,
				layer: layer,
				year: year,
				time: time,
				scenario: scenario
			});
	}

	function identifyTimelinePosition(year) {
		var i = 0;
		$.each(timelineYears, function (idx, item) {
			if (item === year) {
				return idx;
			}

			if (year < item)
				return idx;

			i++;
		});
		return i;
	}

	function hasTemporalViewActive() {
		var active = false;
		if (hasTemporalView && timelineLayers.length > 0) {
			$.each(timelineLayers, function (_, item) {
				if (viewsActive[item.type]) {
					active = true;
					return false;
				}
			});
		}

		return active;
	}

	function hasOnlyOneViewTemporal() {
		return timelineYears.length === 1;
	}

	function existYear(year) {
		var exist = false;
		$.each(timelineYears, function (idx, item) {
			if (item === year)
				exist = true;
		});
		return exist;
	}

	function onPlayClick() {
		$viewsLayers.prop("disabled", true);
		$viewsInformation.off('click');
		$play.prop("disabled", true);
		$slider.slider("disable");
	
		var size = timelineYears.length - 1;
		var current = selectedInterval[0];
		var last = selectedInterval[1];
		var interval = null;
		var changeYear = null;

		function nextYear() {
			$spanSelectedYear.css('left', ((current / size * 100) - 1) + '%');
			setLayerVisibility(current);
			current++;
		}

		function enableButtons() {
			$viewsLayers.prop("disabled", false);
			$viewsInformation.click(onInformationClick);
			$play.prop("disabled", false);
			$slider.slider("enable");
		}

		if (hasWMS) {
			changeYear = function () {
				if (current <= last) {
					google.maps.event.addListenerOnce(map, "tilesloaded", function() {    
						setTimeout(changeYear, SLIDER_INTERVAL);
					});
		
					nextYear();
				}
				else {
					enableButtons();
				}
			};

			changeYear();
		} else {
			changeYear = function () {
				if (current <= last) {
					nextYear();
				}
				else {
					clearInterval(interval);
					enableButtons();
				}
			};

			interval = setInterval(changeYear, SLIDER_INTERVAL);
		}
	}

	function hasViewWithScenarioActive() {
		var active = false;
		if (hasScenario) {
			$.each(viewsActive, function (name, isActive) {
				if (isActive && scenarioApp[name]) {
					active = true;
					return false;
				}
			});
		}

		return active;
	}

	function removeCurrentScenarioIfExist() {
		if (scenarioState.currentScenario) {
			var currentView = Publish.data[scenarioState.currentView];
			var currentScenario = currentView.scenario[scenarioState.currentScenario];
			$.each(currentScenario.name, function (_, layer) {
				var mdata = data[layer];
				mdata.setMap(null);
			});

			timelineYears = clone(scenarioState.timelineYears);
			timelineLayers = clone(scenarioState.timelineLayers);
			scenarioState.currentScenario = null;
			scenarioState.currentView = null;
		}
	}

	function onScenarioChange() {
		removeCurrentScenarioIfExist();

		var emptyStr = "";
		var $separator = $('#scenarioSeparator');

		var scenarioName = $scenarioCombobox.find('option:selected').text().trim();
		var view = $scenarioCombobox.find('option:selected').val();
		if (view) {
			scenarioName = Publish.scenarioWrapper[scenarioName];
			if ($separator.length === 0) {
				$separator = $('<br id="scenarioSeparator"/>');
				$separator.insertBefore($scenarioDescription);
			}

			var inCache = scenarioCache[scenarioName];
			if (inCache) {
				timelineYears = clone(inCache.timelineYears);
				timelineLayers = clone(inCache.timelineLayers);
				scenarioState.currentScenario = scenarioName;
				scenarioState.currentView = view;

				$slider.find('label').remove();
				createSlider();
				drawTimelineLayers();
			} else {
				var XHRs = [];
				var selected = Publish.data[view];
				var scenario = selected.scenario[scenarioName];

				enableLoaderMessage();
				var yearIndex = 0;
				var timeStrategy = selected.time;
				$.each(scenario.name, function (_, layer) {
					var year = scenario.timeline[yearIndex];
					XHRs.push(loadData(layer, selected, function (gdata) {
						timelineValues(year, gdata, view, timeStrategy, scenarioName);
					}));

					yearIndex++;
				});

				$.when.apply($, XHRs).always(function () {
					scenarioState.currentScenario = scenarioName;
					scenarioState.currentView = view;
					scenarioCache[scenarioName] = {
						timelineYears: clone(timelineYears),
						timelineLayers: clone(timelineLayers)
					};

					$slider.find('label').remove();
					createSlider();
					disableLoaderMessage();
					drawTimelineLayers();
				});
			}

			var spaceStr = " ";
			var dot = ".";

			var scenarioDescription = Publish.scenario[scenarioName];
			var sentences = scenarioDescription.split(dot);
			var firstSentence = sentences[0] ? sentences[0] + dot : emptyStr;

			if ((sentences.length - 1) > 1)
				$scenarioMore.show();
			else
				$scenarioMore.hide();

			$scenarioDescription.text(firstSentence);
			$scenarioModalTitleDescription.text(spaceStr + scenarioName);
			$scenarioInfoDescription.text(scenarioDescription);
		} else {
			$slider.find('label').remove();
			createSlider();
			drawTimelineLayers();

			if ($separator.length > 0) {
				$separator.remove();
			}

			$scenarioDescription.text(emptyStr);
			$scenarioMore.hide();
		}
	}

	function startMenu() {
		$viewsLayers.each(function (_, checkbox) {
			viewsCheckbox[checkbox.name] = $(checkbox);
		});

		$viewsInformation.each(function (_, link) {
			layersName[link.id] = link.innerText;
			viewsActive[link.id] = false;
		});

		$viewsLayers.click(onLayerClick);
		$viewsInformation.click(onInformationClick);
		$play.click(onPlayClick);
		$scenarioCombobox.change(onScenarioChange);
		$descriptionTitle.prop('disabled', true);
		$legendTitle.prop('disabled', true);
		$layersTitle.text("  " + Publish.layers);
		$panelDownload.hide();
	}

	function applyMargins() {
		if ($leftToggler.is(':visible')) {
			$map.find('.ol-zoom')
				.css('margin-left', 0)
				.removeClass('zoom-top-opened-sidebar')
				.addClass('zoom-top-collapsed');
		} else {
			var $sidebarLeft = $('.sidebar-left');
			$map.find('.ol-zoom')
				.css('margin-left', $sidebarLeft.width())
				.removeClass('zoom-top-opened-sidebar')
				.removeClass('zoom-top-collapsed');
		}
	}

	function isConstrained() {
		return $sidebar.width() === $(window).width();
	}

	function applyInitialUIState() {
		if (isConstrained()) {
			$sidebarLeftBody.fadeOut('slide');
			$leftToggler.fadeIn();
		}

		if ($('#logo')) {
			var navDefaultHeight = 50;
			var marginTop = navBarHeight - navDefaultHeight;
			$('body').css('padding-top', marginTop);
			$leftToggler.css('margin-top', marginTop);
		}

		var customFontSize = Publish.fontSize;
		if (customFontSize) {
			var $fontView = $('.custom-font-layer');
			var $fontAppTitle = $('.custom-font-app-title');
			var $fontGroupSubTitle = $('.custom-font-group-title');
			var $fontReportTitle = $('.custom-font-report-title');
			var $fontSubTitle = $('.custom-font-subtitle');
			var $fontBody = $('.custom-font-body');
			var $fontLegend = $('.custom-font-legend');
			var $fontBtnMore = $('.custom-font-more ');

			var PX = "px";
			var FONT_SIZE = 'font-size';
			var getSize = function ($element) {
				return parseFloat($element.css(FONT_SIZE));
			};

			var setSize = function ($element, size) {
				$element.css(FONT_SIZE, size + PX);
			};

			var DEFAULT_VIEW_SIZE = getSize($fontView);
			var setProportionSize = function ($element) {
				var proportionSize = getSize($element) - DEFAULT_VIEW_SIZE;
				var newSize = customFontSize + proportionSize;
				setSize($element, newSize);
			};

			setSize($fontView, customFontSize);
			setProportionSize($fontAppTitle);
			setProportionSize($fontGroupSubTitle);
			setProportionSize($fontReportTitle);
			setProportionSize($fontSubTitle);
			setProportionSize($fontBody);
			setProportionSize($fontLegend);
			setProportionSize($fontBtnMore);
		}
	}

	function initLabel(selected) {
		if (!selected.label) {
			selected.label = {};
			var defaultStrokeColor = "rgba(0, 0, 0, 1)";
			selected.label[selected.id] = selected.color || selected.border || defaultStrokeColor;
		}
	}

	function setCheckbox(id, value) {
		if (viewsActive[id] !== value) {
			viewsActive[id] = value;

			if (hasScenario) {
				if (id === scenarioState.currentView) {
					$scenarioCombobox.val("").change();
				}
			}

			viewsCheckbox[id].prop('checked', value);
		}

		if (hasScenario) {
			if (hasViewWithScenarioActive()) {
				$scenarioCombobox.prop("disabled", false);
			} else {

				$scenarioCombobox.prop("disabled", true);
			}
		}
	}

	function getSelect(selected, idx) {
		if ($.type(selected.select) === "array") {
			return selected.select[idx];
		}

		return selected.select;
	}

	$sidebarLeftSubmenu.on('click', function () {
		var thisEl = $(this);
		thisEl.closest('.sidebar-body').fadeOut('slide', function () {
			$leftToggler.fadeIn();
			applyMargins();
		});
	});

	$leftToggler.on('click', function () {
		var thisEl = $(this);
		$sidebarLeftBody.toggle('slide');
		thisEl.hide();
		applyMargins();
	});

	$more.on('click', function () {
		$modalCompletedDescription.modal('show');
	});

	$scenarioMore.on('click', function () {
		$scenarioModalCompletedDescription.modal('show');
	});

	$(window).on('resize', applyMargins);
	$modalDescription.modal('show');

	applyInitialUIState();
	applyMargins();
});
