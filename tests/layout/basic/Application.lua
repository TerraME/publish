-------------------------------------------------------------------------------------------
-- TerraME - a software platform for multiple scale spatially-explicit dynamic modeling.
-- Copyright (C) 2001-2016 INPE and TerraLAB/UFOP -- www.terrame.org

-- This code is part of the TerraME framework.
-- This framework is free software; you can redistribute it and/or
-- modify it under the terms of the GNU Lesser General Public
-- License as published by the Free Software Foundation; either
-- version 2.1 of the License, or (at your option) any later version.

-- You should have received a copy of the GNU Lesser General Public
-- License along with this library.

-- The authors reassure the license terms regarding the warranties.
-- They specifically disclaim any warranties, including, but not limited to,
-- the implied warranties of merchantability and fitness for a particular purpose.
-- The framework provided hereunder is on an "as is" basis, and the authors have no
-- obligation to provide maintenance, support, updates, enhancements, or modifications.
-- In no event shall INPE and TerraLAB / UFOP be held liable to any party for direct,
-- indirect, special, incidental, or consequential damages arising out of the use
-- of this software and its documentation.
--
-------------------------------------------------------------------------------------------

return {
	Application = function(unitTest)
		local brazilDir = Directory("layout-basic-app")
		if brazilDir:exists() then brazilDir:delete() end

		local app = Application{
			project = filePath("brazil.tview", "publish"),
			biomes = View{
				select = "name",
				value = {"Caatinga", "Cerrado", "Amazonia", "Pampa", "Mata Atlantica", "Pantanal"},
				color = {"brown", "purple", "green", "yellow", "blue", "orange"},
				description = "Basic Test"
			},
			progress = false,
			output = brazilDir,
			title = "Testing Application Functional",
		}

		unitTest:assertType(app, "Application")
		unitTest:assertEquals(app.title, "Testing Application Functional")
		unitTest:assertNil(app.description)
		unitTest:assertEquals(app.base, "satellite")
		unitTest:assertEquals(app.minZoom, 0)
		unitTest:assertEquals(app.maxZoom, 20)
		unitTest:assertNotNil(app.zoom)
		unitTest:assertNotNil(app.center)

		if brazilDir:exists() then brazilDir:delete() end

		app = Application{
			project = filePath("brazil.tview", "publish"),
			biomes = View{
				select = "name",
				value = {"Caatinga", "Cerrado", "Amazonia", "Pampa", "Mata Atlantica", "Pantanal"},
				color = {"brown", "purple", "green", "yellow", "blue", "orange"},
				description = "Basic Test",
			},
			progress = false,
			output = brazilDir,
			title = "Testing Application Functional",
			base = "roadmap",
			zoom = 10,
			minZoom = 5,
			maxZoom = 17,
			center = {lat = -23.179017, long = -45.889188}
		}

		unitTest:assertType(app, "Application")
		unitTest:assertEquals(app.title, "Testing Application Functional")
		unitTest:assertNil(app.description)
		unitTest:assertEquals(app.base, "roadmap")
		unitTest:assertEquals(app.zoom, 10)
		unitTest:assertEquals(app.minZoom, 5)
		unitTest:assertEquals(app.maxZoom, 17)
		unitTest:assertEquals(app.center.lat, -23.179017)
		unitTest:assertEquals(app.center.long, -45.889188)
		unitTest:assertEquals(app.template.navbar, "#1ea789")
		unitTest:assertEquals(app.template.title, "white")

		if brazilDir:exists() then brazilDir:delete() end

		app = Application{
			project = filePath("brazil.tview", "publish"),
			output = brazilDir,
			template = {navbar = "#034871", title = "#F63B4C"},
			biomes = View{
				select = "name",
				value = {"Caatinga", "Cerrado", "Amazonia", "Pampa", "Mata Atlantica", "Pantanal"},
				color = {"brown", "purple", "green", "yellow", "blue", "orange"},
				description = "abc.",
			},
			progress = false,
			fontSize = 10
		}

		unitTest:assertType(app, "Application")
		unitTest:assertType(app.template, "table")
		unitTest:assertEquals(app.template.navbar, "#034871")
		unitTest:assertEquals(app.template.title, "#F63B4C")
		unitTest:assertEquals(app.fontSize, 10)

		if brazilDir:exists() then brazilDir:delete() end

		app = Application{
			project = filePath("brazil.tview", "publish"),
			output = brazilDir,
			template = {navbar = {3, 72, 113}, title = {246, 59, 76}},
			biomes = View{
				select = "name",
				value = {"Caatinga", "Cerrado", "Amazonia", "Pampa", "Mata Atlantica", "Pantanal"},
				color = {"brown", "purple", "green", "yellow", "blue", "orange"},
				description = "abc.",
			},
			progress = false,
		}

		unitTest:assertType(app, "Application")
		unitTest:assertType(app.template, "table")
		unitTest:assertEquals(app.template.navbar, "rgba(3, 72, 113, 1)")
		unitTest:assertEquals(app.template.title, "rgba(246, 59, 76, 1)")

		if brazilDir:exists() then brazilDir:delete() end

		local logo = File(packageInfo("luadoc").path.."/logo/logo.png")
		app = Application{
			project = filePath("brazil.tview", "publish"),
			output = brazilDir,
			template = {navbar = "dodgerblue", title = "brown"},
			description = "abc.",

			biomes = View{
				select = "name",
				value = {"Caatinga", "Cerrado", "Amazonia", "Pampa", "Mata Atlantica", "Pantanal"},
				color = {"brown", "purple", "green", "yellow", "blue", "orange"},
				description = "abc.",
			},
			select = "river",
			color = "BuGn",
			value = {0, 1, 2},
			progress = false,
			logo = tostring(logo)
		}

		unitTest:assertType(app, "Application")
		unitTest:assertType(app.template, "table")
		unitTest:assertType(app.logo, "string")
		unitTest:assertEquals(app.template.navbar, "rgba(30, 144, 255, 1)")
		unitTest:assertEquals(app.template.title, "rgba(165, 42, 42, 1)")
		unitTest:assertEquals(app.logo, logo:name())

		if brazilDir:exists() then brazilDir:delete() end

		local caraguaDir = Directory("CaraguaWebMap")
		if caraguaDir:exists() then caraguaDir:delete() end

		local function zoom(mapPx, worldPx, fraction)
			return math.floor(math.log(mapPx / worldPx / fraction) / math.log(2));
		end

		local function applicationZoom(application)
			local mapResolution = {width = 1241.818115234375, height = 538.1818237304688}
			local longZoom = zoom(mapResolution.width, application.zoom.xTile, application.zoom.longFraction)
			local latZoom = zoom(mapResolution.height, application.zoom.yTile, application.zoom.latFraction)

			return math.min(latZoom, longZoom, application.maxZoom)
		end

		app = Application{
			project = filePath("caragua.tview", "publish"),
			output = caraguaDir,
			progress = false,
			use = View{
				description = "abc.",
				title = "Occupational Classes 2010",
				select = "uso",
				color = "RdPu"
			}
		}

		unitTest:assertType(app, "Application")
		unitTest:assertNotNil(app.center)
		unitTest:assertNotNil(app.zoom)
		unitTest:assertType(app.center, "table")
		unitTest:assertType(app.zoom, "table")
		unitTest:assertEquals(getn(app.center), 2)
		unitTest:assertEquals(app.center.lat, -23.648856395349, 0.000001)
		unitTest:assertEquals(app.center.long, -45.369608573718, 0.000001)
		unitTest:assertEquals(getn(app.zoom), 4)
		unitTest:assertEquals(app.zoom.latFraction, 0.00055808444572516, 0.000001)
		unitTest:assertEquals(app.zoom.longFraction, 0.00053538327991453, 0.000001)
		unitTest:assertEquals(app.zoom.xTile, 256)
		unitTest:assertEquals(app.zoom.yTile, 256)
		unitTest:assertEquals(applicationZoom(app), 11)

		if caraguaDir:exists() then caraguaDir:delete() end

		app = Application{
			project = filePath("caragua.tview", "publish"),
			output = caraguaDir,
			progress = false,
			center = {lat = -23.648856395349, long = -45.489454594686094},
			use = View{
				description = "abc.",
				title = "Occupational Classes 2010",
				select = "uso",
				color = "RdPu"
			}
		}

		unitTest:assertType(app, "Application")
		unitTest:assertNotNil(app.center)
		unitTest:assertNotNil(app.zoom)
		unitTest:assertType(app.center, "table")
		unitTest:assertType(app.zoom, "table")
		unitTest:assertEquals(getn(app.center), 2)
		unitTest:assertEquals(app.center.lat, -23.648856395349)
		unitTest:assertEquals(app.center.long, -45.489454594686094)
		unitTest:assertEquals(getn(app.zoom), 4)
		unitTest:assertEquals(app.zoom.latFraction, 0.00055808444572516, 0.000001)
		unitTest:assertEquals(app.zoom.longFraction, 0.00053538327991453, 0.000001)
		unitTest:assertEquals(app.zoom.xTile, 256)
		unitTest:assertEquals(app.zoom.yTile, 256)
		unitTest:assertEquals(applicationZoom(app), 11)

		if caraguaDir:exists() then caraguaDir:delete() end

		app = Application{
			project = filePath("caragua.tview", "publish"),
			output = caraguaDir,
			progress = false,
			zoom = 12,
			use = View{
				description = "abc.",
				title = "Occupational Classes 2010",
				select = "uso",
				color = "RdPu"
			}
		}

		unitTest:assertType(app, "Application")
		unitTest:assertNotNil(app.center)
		unitTest:assertNotNil(app.zoom)
		unitTest:assertType(app.center, "table")
		unitTest:assertType(app.zoom, "number")
		unitTest:assertEquals(getn(app.center), 2)
		unitTest:assertEquals(app.center.lat, -23.648856395349, 0.000001)
		unitTest:assertEquals(app.center.long, -45.369608573718, 0.000001)
		unitTest:assertEquals(app.zoom, 12)

		if caraguaDir:exists() then caraguaDir:delete() end

		local municipalitiesProj = File("municipalities.tview")
		municipalitiesProj:deleteIfExists()

		local municipalitiesir = Directory("municipalities")
		if municipalitiesir:exists() then municipalitiesir:delete() end

		local gis = getPackage("gis")
		local proj = gis.Project{
			title = "municipalities",
			author = "Carneiro, H.",
			file = municipalitiesProj,
			clean = true,
			municipalities = filePath("sp_municipalities.shp", "publish"),
		}

		app = Application {
			project = proj,
			output = municipalitiesir,
			progress = false,
			municipalities = View {
				description = "abc.",
				select = "pib",
				color = "Spectral",
				slices = 5
			}
		}

		unitTest:assertType(app, "Application")

		local view = app.view.municipalities
		unitTest:assertType(view, "View")
		unitTest:assertEquals(view.select, "pib")
		unitTest:assertEquals(view.slices, 5)
		unitTest:assertEquals(view.min, 17147)
		unitTest:assertEquals(view.max, 443600102)

		unitTest:assertType(view.color, "table")
		unitTest:assertEquals(#view.value, 740)

		if municipalitiesir:exists() then municipalitiesir:delete() end

		app = Application {
			project = proj,
			output = municipalitiesir,
			progress = false,
			municipalities = View {
				description = "abc.",
				select = "pib",
				color = "Spectral",
				slices = 5,
				min = 0,
				max = 453600102
			}
		}

		unitTest:assertType(app, "Application")

		view = app.view.municipalities
		unitTest:assertType(view, "View")
		unitTest:assertEquals(view.select, "pib")
		unitTest:assertEquals(view.slices, 5)
		unitTest:assertEquals(view.min, 0)
		unitTest:assertEquals(view.max, 453600102)

		unitTest:assertType(view.color, "table")
		unitTest:assertEquals(#view.value, 740)

		if municipalitiesir:exists() then municipalitiesir:delete() end

		app = Application {
			project = proj,
			output = municipalitiesir,
			progress = false,
			municipalities = View {
				description = "abc.",
				select = "pib",
				color = "Spectral",
				slices = 5,
				min = 0
			}
		}

		unitTest:assertType(app, "Application")

		view = app.view.municipalities
		unitTest:assertType(view, "View")
		unitTest:assertEquals(view.select, "pib")
		unitTest:assertEquals(view.slices, 5)
		unitTest:assertEquals(view.min, 0)
		unitTest:assertEquals(view.max, 443600102)

		unitTest:assertType(view.color, "table")
		unitTest:assertEquals(#view.value, 740)

		if municipalitiesir:exists() then municipalitiesir:delete() end

		app = Application {
			project = proj,
			output = municipalitiesir,
			progress = false,
			municipalities = View {
				description = "abc.",
				select = "pib",
				color = "Spectral",
				slices = 5,
				max = 453600102
			}
		}

		unitTest:assertType(app, "Application")

		view = app.view.municipalities
		unitTest:assertType(view, "View")
		unitTest:assertEquals(view.select, "pib")
		unitTest:assertEquals(view.slices, 5)
		unitTest:assertEquals(view.min, 17147)
		unitTest:assertEquals(view.max, 453600102)

		unitTest:assertType(view.color, "table")
		unitTest:assertEquals(#view.value, 740)

		if municipalitiesir:exists() then municipalitiesir:delete() end
		municipalitiesProj:deleteIfExists()
	end
}
