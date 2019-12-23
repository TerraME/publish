$(function(){
	var map;
	var $legend = $('#legend');

	function getRandomColor() {
		var letters = '0123456789ABCDEF';
		var color = '#';
		for (var i = 0; i < 6; i++ ) {
			color += letters[Math.floor(Math.random() * 16)];
		}

		return color;
	}
	
	function onClick(event){
		window.location.href = "./" + event.target.id + ".html";
	}

	function initialZoom(mdata, bounds) {
		if(Publish.zoom)
			return;

		mdata.forEach(function(feature){
			feature.getGeometry().forEachLatLng(function(coordinate){
				bounds.extend(coordinate);
			});
		});
	}

	function loadAreasOfInterest(){
		$legend.append($('<div id="legend-container"><h4 class="panel-title">' + Publish.legend +'</h4><br/></div>'));
		var $legendContent = $('<div id="legend-content">').appendTo($('#legend-container'));

		var XHRs = [];
		var bounds = new google.maps.LatLngBounds();
		$.each(Publish.data, function(proj, layer){
			var url = "./data/" + proj + "/" + layer + ".geojson";
			var defer = $.getJSON(url, function(geojson){
				var color = getRandomColor();
				var mdata = new google.maps.Data();

				mdata.addGeoJson(geojson);
				mdata.setStyle(function(feature){
					feature.setProperty("project", proj);
					return{
						fillColor: color,
						strokeWeight: 1
					};
				});

				mdata.addListener("click", function(event){
					window.location.href = "./" + event.feature.getProperty("project") + ".html";
				});

				mdata.setMap(map);
				initialZoom(mdata, bounds);

				var $div = $('<div style="height:25px;">')
				.append($('<div class="legend-color-box">').css({backgroundColor: color}))
				.append($('<span>').css("lineHeight", "23px").html(proj));
				$legendContent.append($div);
			});

			defer.done(function(){
				XHRs.push(defer);
			});
		});

		setTimeout(function () {
			$.when(XHRs).then(function(){
				map.fitBounds(bounds);
			});
		}, 1000);
	}

	function initMap(){
		google.maps.visualRefresh = true;
		var mapOptions = {
			minZoom: Publish.minZoom,
			maxZoom: Publish.maxZoom,
			mapTypeId: google.maps.MapTypeId[Publish.mapTypeId],
			mapTypeControl: true,
			mapTypeControlOptions: {
				style: google.maps.MapTypeControlStyle.DROPDOWN_MENU,
				position: google.maps.ControlPosition.TOP_RIGHT
			}
		};

		if(Publish.center){
			mapOptions.center = new google.maps.LatLng(Publish.center.lat, Publish.center.long);
		}

		if(Publish.zoom){
			mapOptions.zoom = Publish.zoom;
		}

		var mapElement = document.getElementById("map");
		map = new google.maps.Map(mapElement, mapOptions);
		map.controls[google.maps.ControlPosition.LEFT_BOTTOM].push($legend[0]);
		map.controls[google.maps.ControlPosition.BOTTOM_RIGHT].push($('#footer')[0]);

		$('#layers').find(':button').click(onClick);
		loadAreasOfInterest();
	}

	google.maps.event.addDomListener(window, "load", initMap);

	function applyMargins(){
		var leftToggler = $('.mini-submenu-left');
		if (leftToggler.is(':visible')) {
			$('#map').find('.ol-zoom')
			.css('margin-left', 0)
			.removeClass('zoom-top-opened-sidebar')
			.addClass('zoom-top-collapsed');
		} else {
			$('#map').find('.ol-zoom')
			.css('margin-left', $('.sidebar-left').width())
			.removeClass('zoom-top-opened-sidebar')
			.removeClass('zoom-top-collapsed');
		}
	}

	function isConstrained(){
		return $('.sidebar').width() == $(window).width();
	}

	function applyInitialUIState(){
		if (isConstrained()){
			$('.sidebar-left .sidebar-body').fadeOut('slide');
			$('.mini-submenu-left').fadeIn();
		}
	}

	$('.sidebar-left .slide-submenu').on('click',function(){
		var thisEl = $(this);
		thisEl.closest('.sidebar-body').fadeOut('slide',function(){
			$('.mini-submenu-left').fadeIn();
			applyMargins();
		});
	});

	$('.mini-submenu-left').on('click',function(){
		var thisEl = $(this);
		$('.sidebar-left .sidebar-body').toggle('slide');
		thisEl.hide();
		applyMargins();
	});

	$(window).on('resize', applyMargins);

	applyInitialUIState();
	applyMargins();
});
