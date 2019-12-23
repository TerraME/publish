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
		local brazilDir = Directory("functional-basic-app")
		if brazilDir:exists() then brazilDir:delete() end

		local app = Application{
			project = filePath("brazil.tview", "publish"),
			output = "functional-basic-app",
			biomes = View{
				select = "name",
				value = {"Caatinga", "Cerrado", "Amazonia", "Pampa", "Mata Atlantica", "Pantanal"},
				color = {"brown", "purple", "green", "yellow", "blue", "orange"},
				description = "abc.",
			},
			progress = false,
		}

		unitTest:assertType(app, "Application")
		unitTest:assertType(app.output, "Directory")
		unitTest:assertEquals(app.title, "No title")
		unitTest:assert(app.clean)
		unitTest:assert(not app.progress)
		unitTest:assertNil(app.key)

		if app.output:exists() then app.output:delete() end

		app = Application{
			project = filePath("brazil.tview", "publish"),
			output = brazilDir,
			key = "AIzaSyCFXMRJlfDoDK7Hk8KkJ9R9bWpNauoLVuA",
			biomes = View{
				select = "name",
				value = {"Caatinga", "Cerrado", "Amazonia", "Pampa", "Mata Atlantica", "Pantanal"},
				color = {"brown", "purple", "green", "yellow", "blue", "orange"},
				description = "abc.",
			},
			progress = false,
		}

		unitTest:assertType(app, "Application")
		unitTest:assertNotNil(app.key)
		unitTest:assertEquals(app.key, "AIzaSyCFXMRJlfDoDK7Hk8KkJ9R9bWpNauoLVuA")

		if brazilDir:exists() then brazilDir:delete() end

		local caraguaDir = Directory("CaraguaWebMap")
		if caraguaDir:exists() then caraguaDir:delete() end

		app = Application{
			key = "AIzaSyCFXMRJlfDoDK7Hk8KkJ9R9bWpNauoLVuA",
			project = filePath("caragua.tview", "publish"),
			progress = false,
			output = caraguaDir,
			Limit = List{
				limit = View{
					description = "abc.",
					color = "goldenrod",
				},
				regions = View{
					description = "abc.",
					select = "name",
					color = "Set2"
				}
			},
			SocialClasses = List{
				real = View{
					description = "abc.",
					title = "Social Classes 2010",
					select = "classe",
					color = {"red", "orange", "yellow"},
					label = {"Condition C", "Condition B", "Condition A"}
				},
				baseline = View{
					description = "abc.",
					title = "Social Classes 2025",
					select = "classe",
					color = {"red", "orange", "yellow"},
					label = {"Condition C", "Condition B", "Condition A"}
				}
			},
			OccupationalClasses = List{
				use = View{
					description = "abc.",
					title = "Occupational Classes 2010",
					select = "uso",
					color = "RdPu"
				}
			}
		}

		unitTest:assertType(app, "Application")
		unitTest:assertNotNil(app.key)
		unitTest:assertEquals(app.key, "AIzaSyCFXMRJlfDoDK7Hk8KkJ9R9bWpNauoLVuA")

		local group = app.group
		unitTest:assertNotNil(group)
		unitTest:assertType(group, "table")
		unitTest:assertType(group.Limit, "string")
		unitTest:assertEquals(group.Limit, "limit")

		unitTest:assertType(group.SocialClasses, "string")
		unitTest:assertEquals(group.SocialClasses, "baseline")

		unitTest:assertType(group.OccupationalClasses, "string")
		unitTest:assertEquals(group.OccupationalClasses, "use")

		local view = app.view.limit
		unitTest:assertType(view, "View")
		unitTest:assertEquals(view.group, "Limit")

		view = app.view.real
		unitTest:assertType(view, "View")
		unitTest:assertEquals(view.group, "SocialClasses")

		view = app.view.use
		unitTest:assertType(view, "View")
		unitTest:assertEquals(view.group, "OccupationalClasses")

		if caraguaDir:exists() then caraguaDir:delete() end

		local file = File("caragua-simplify-test.tview")
		file:deleteIfExists()

		local gis = getPackage("gis")
		local proj = gis.Project{
			title = "Occupational Classes",
			author = "Carneiro, H.",
			file = file,
			clean = true,
			regions = filePath("regions.shp", "publish"),
			use = filePath("occupational2010.shp", "publish")
		}

		app = Application{
			project = proj,
			output = caraguaDir,
			progress = false,
			simplify = true,
			use = View{
				description = "abc.",
				title = "Occupational Classes 2010",
				select = "uso",
				color = "RdPu",
				decimal = 2
			},
			regions = View {
				description = "Regions of Caraguatatuba.",
				select = "name",
				color = "Set2",
				label = { "North", "Central", "South" }
			}
		}

		unitTest:assertType(app, "Application")
		unitTest:assertNil(app.key)
		unitTest:assert(app.clean)
		unitTest:assert(not app.progress)
		unitTest:assert(app.simplify)

		view = app.view.regions
		unitTest:assertType(view, "View")
		unitTest:assertType(view.select, "string")
		unitTest:assertNotNil(view.properties)
		unitTest:assertType(view.properties, "table")
		unitTest:assertEquals(getn(view.properties), 1)
		unitTest:assertEquals(view.properties[view.select], "n")
		unitTest:assertEquals(view.decimal, 5)

		view = app.view.use
		unitTest:assertType(view, "View")
		unitTest:assertType(view.select, "string")
		unitTest:assertNotNil(view.properties)
		unitTest:assertType(view.properties, "table")
		unitTest:assertEquals(getn(view.properties), 1)
		unitTest:assertEquals(view.properties[view.select], "u")
		unitTest:assertEquals(view.decimal, 2)

		if caraguaDir:exists() then caraguaDir:delete() end
		file:deleteIfExists()

		local arapiunsDir = Directory("ArapiunsWebMap")
		if arapiunsDir:exists() then arapiunsDir:delete() end

		file = File("arapiuns-simplify-test.tview")
		file:deleteIfExists()

		proj = gis.Project{
			title = "The riverine settlements at Arapiuns (PA)",
			author = "Carneiro, H.",
			file = file,
			clean = true,
			villages = filePath("AllCmmTab_210316OK.shp", "publish")
		}

		app = Application{
			key = "AIzaSyCFXMRJlfDoDK7Hk8KkJ9R9bWpNauoLVuA",
			project = proj,
			output = arapiunsDir,
			progress = false,
			simplify = true,
			villages = View{
				description = "abc.",
				select = {"Nome", "UC"},
				report = function(cell)
					local mreport = Report{title = cell.Nome}
					mreport:addImage(packageInfo("publish").data.."arapiuns/"..cell.Nome..".jpg")
					return mreport
				end
			}
		}

		unitTest:assertType(app, "Application")
		unitTest:assertNotNil(app.key)
		unitTest:assertEquals(app.key, "AIzaSyCFXMRJlfDoDK7Hk8KkJ9R9bWpNauoLVuA")
		unitTest:assert(app.clean)
		unitTest:assert(not app.progress)
		unitTest:assert(app.simplify)

		view = app.view.villages
		unitTest:assertType(view, "View")
		unitTest:assertType(view.select, "table")
		unitTest:assertNotNil(view.properties)
		unitTest:assertType(view.properties, "table")
		unitTest:assertEquals(getn(view.properties), 2)
		unitTest:assertEquals(view.properties[view.select[1]], "n")
		unitTest:assertEquals(view.properties[view.select[2]], "u")
		unitTest:assertEquals(view.decimal, 5)

		do
			local minifiedGeoJSON = File(arapiunsDir.."villages.geojson")
			unitTest:assert(minifiedGeoJSON:exists())

			local line1 = minifiedGeoJSON:readLine()
			unitTest:assertNotNil(line1)

			local line2 = minifiedGeoJSON:readLine()
			minifiedGeoJSON:close()
			unitTest:assertNil(line2)

			local json = require "json"
			local jsonData = json.decode(line1)
			unitTest:assertType(jsonData, "table")

			local features = jsonData.features
			local patternDecimal = "%.(%d+)"

			local coordinates = features[1].geometry.coordinates[1]
			unitTest:assertType(coordinates, "table")
			unitTest:assertEquals(#coordinates, 2)

			local numberOfDecimals = #tostring(coordinates[1]):match(patternDecimal)
			unitTest:assertEquals(numberOfDecimals, 5)

			numberOfDecimals = #tostring(coordinates[2]):match(patternDecimal)
			unitTest:assertEquals(numberOfDecimals, 5)

			coordinates = features[#features].geometry.coordinates[1]
			unitTest:assertType(coordinates, "table")
			unitTest:assertEquals(#coordinates, 2)

			numberOfDecimals = #tostring(coordinates[1]):match(patternDecimal)
			unitTest:assertEquals(numberOfDecimals, 5)

			numberOfDecimals = #tostring(coordinates[2]):match(patternDecimal)
			unitTest:assertEquals(numberOfDecimals, 5)
		end

		if arapiunsDir:exists() then arapiunsDir:delete() end
		file:deleteIfExists()

		file = File("temporal.tview")
		file:deleteIfExists()

		local temporalDir = Directory("temporal-test")
		if temporalDir:exists() then temporalDir:delete() end

		proj = gis.Project{
			title = "Testing temporal View",
			author = "Carneiro, H.",
			file = file,
			clean = true,
			uc_2001 = filePath("uc_federais_2001.shp", "publish"),
			uc_2009 = filePath("uc_federais_2009.shp", "publish"),
			uc_2016 = filePath("uc_federais_2016.shp", "publish")
		}

		app = Application{
			base = "roadmap",
			project = proj,
			output = temporalDir,
			progress = false,
			uc = View {
				title = "UC",
				description = "UC Federais.",
				select = "anoCriacao",
				color = "Spectral",
				slices = 10,
				time = "snapshot"
			}
		}

		unitTest:assertType(app, "Application")

		view = app.view.uc
		unitTest:assertType(view, "View")
		unitTest:assertType(view.select, "string")
		unitTest:assertType(view.timeline, "table")

		unitTest:assertEquals(view.select, "anoCriacao")
		unitTest:assertEquals(view.time, "snapshot")

		unitTest:assertEquals(#view.name, 3)
		unitTest:assertEquals(view.name[1], "uc_2001")
		unitTest:assertEquals(view.name[2], "uc_2009")
		unitTest:assertEquals(view.name[3], "uc_2016")

		unitTest:assertEquals(#view.timeline, 3)
		unitTest:assertEquals(view.timeline[1], 2001)
		unitTest:assertEquals(view.timeline[2], 2009)
		unitTest:assertEquals(view.timeline[3], 2016)
		if temporalDir:exists() then temporalDir:delete() end

		app = Application{
			base = "roadmap",
			project = proj,
			output = temporalDir,
			progress = false,
			uc_2016 = View {
				title = "UC",
				description = "UC Federais.",
				select = "anoCriacao",
				color = "Spectral",
				slices = 10,
				name = "anoCriacao",
				time = "creation"
			}
		}

		unitTest:assertType(app, "Application")

		view = app.view.uc_2016
		unitTest:assertType(view, "View")
		unitTest:assertType(view.select, "string")
		unitTest:assertType(view.name, "string")
		unitTest:assertType(view.timeline, "table")

		unitTest:assertEquals(view.select, "anoCriacao")
		unitTest:assertEquals(view.name, "anoCriacao")
		unitTest:assertEquals(view.time, "creation")

		unitTest:assertEquals(#view.timeline, 28)
		unitTest:assertEquals(view.timeline[1], 1959)
		unitTest:assertEquals(view.timeline[#view.timeline], 2016)
		if temporalDir:exists() then temporalDir:delete() end

		file:deleteIfExists()
		proj = gis.Project{
			title = "Testing temporal View",
			author = "Carneiro, H.",
			file = file,
			clean = true,
			uc_2001 = filePath("uc_federais_2001.shp", "publish"),
			uc_2009 = filePath("uc_federais_2009.shp", "publish"),
			uc_2016 = filePath("uc_federais_2016.shp", "publish"),
			uc_creation = filePath("uc_federais_2016.shp", "publish")
		}

		app = Application{
			base = "roadmap",
			project = proj,
			output = temporalDir,
			progress = false,
			uc = View {
				title = "UC",
				description = "UC Federais.",
				select = "anoCriacao",
				color = "Spectral",
				slices =  10,
				time = "snapshot"
			},
			uc_creation = View {
				title = "UC",
				description = "UC Federais.",
				select = "anoCriacao",
				color = "Spectral",
				slices =  10,
				name = "anoCriacao",
				time = "creation"
			}
		}

		unitTest:assertType(app, "Application")

		view = app.view.uc
		unitTest:assertType(view, "View")
		unitTest:assertType(view.select, "string")
		unitTest:assertType(view.name, "table")
		unitTest:assertType(view.timeline, "table")

		unitTest:assertEquals(view.select, "anoCriacao")
		unitTest:assertEquals(view.time, "snapshot")

		unitTest:assertEquals(#view.name, 3)
		unitTest:assertEquals(view.name[1], "uc_2001")
		unitTest:assertEquals(view.name[2], "uc_2009")
		unitTest:assertEquals(view.name[3], "uc_2016")

		unitTest:assertEquals(#view.timeline, 3)
		unitTest:assertEquals(view.timeline[1], 2001)
		unitTest:assertEquals(view.timeline[2], 2009)
		unitTest:assertEquals(view.timeline[3], 2016)

		view = app.view.uc_creation
		unitTest:assertType(view, "View")
		unitTest:assertType(view.select, "string")
		unitTest:assertType(view.name, "string")
		unitTest:assertType(view.timeline, "table")

		unitTest:assertEquals(view.select, "anoCriacao")
		unitTest:assertEquals(view.name, "anoCriacao")
		unitTest:assertEquals(view.time, "creation")

		unitTest:assertEquals(#view.timeline, 28)
		unitTest:assertEquals(view.timeline[1], 1959)
		unitTest:assertEquals(view.timeline[#view.timeline], 2016)
		if temporalDir:exists() then temporalDir:delete() end
		file:deleteIfExists()

		if caraguaDir:exists() then caraguaDir:delete() end

		file = File("scenario.tview")
		proj = gis.Project{
			title = "Future Scenarios",
			author = "Carneiro, H.",
			file = file,
			clean = true,
			classes_2010 = filePath("caragua_classes2010_regioes.shp", "publish"),
			classes_baseline_2025 = filePath("simulation2025_baseline.shp", "publish"),
			classes_lessgrowth_2025 = filePath("simulation2025_lessgrowth.shp", "publish"),
			classes_plusgrowth_2025 = filePath("simulation2025_plusgrowth.shp", "publish")
		}

		app = Application{
			project = proj,
			progress = false,
			output = caraguaDir,
			scenario = {
				baseline = "Baseline simulation for 2025.",
				lessgrowth = "Less growth simulation in 2025.",
				plusgrowth = "Plus growth simulation in 2025."
			},
			classes = View{
				title = "Social Classes 2010",
				description = "This is the main endogenous variable of the model. It was obtained from a classification that "
						.."categorizes the social conditions of households in Caraguatatuba on 'condition A' (best), 'B' or 'C''.",
				width = 0,
				select = "classe",
				color = {"red", "orange", "yellow"},
				label = {"Condition C", "Condition B", "Condition A"},
				time = "snapshot"
			}
		}

		unitTest:assertType(app, "Application")
		unitTest:assertType(app.scenario, "table")

		unitTest:assertEquals(getn(app.scenario), 3)
		unitTest:assertEquals(app.scenario.baseline, "Baseline simulation for 2025.")
		unitTest:assertEquals(app.scenario.lessgrowth, "Less growth simulation in 2025.")
		unitTest:assertEquals(app.scenario.plusgrowth, "Plus growth simulation in 2025.")

		view = app.view.classes
		unitTest:assertType(view, "View")
		unitTest:assertEquals(view.time, "snapshot")

		unitTest:assertEquals(#view.name, 1)
		unitTest:assertEquals(view.name[1], "classes_2010")

		unitTest:assertEquals(#view.timeline, 1)
		unitTest:assertEquals(view.timeline[1], 2010)

		unitTest:assertNotNil(view.scenario)
		unitTest:assertEquals(#view.scenario.baseline.timeline, 1)
		unitTest:assertEquals(view.scenario.baseline.timeline[1], 2025)

		unitTest:assertEquals(#view.scenario.lessgrowth.timeline, 1)
		unitTest:assertEquals(view.scenario.lessgrowth.timeline[1], 2025)

		unitTest:assertEquals(#view.scenario.plusgrowth.timeline, 1)
		unitTest:assertEquals(view.scenario.plusgrowth.timeline[1], 2025)

		if caraguaDir:exists() then caraguaDir:delete() end
		file:deleteIfExists()

		file = File("file.tview")

		proj = gis.Project{
			title = "Testing missing data",
			file = file,
			clean = true,
			amaz = filePath("test/CellsAmaz.shp", "publish")
		}

		Application{
			base = "roadmap",
			project = proj,
			output = "myresult",
			progress = false,
			amaz = View {
				title = "Amaz",
				missing = 0,
				description = "Amazonia.",
			}
		}

		file:deleteIfExists()
		Directory("myresult"):delete()
	end,
	__tostring = function(unitTest)
		local brazil = filePath("brazil.tview", "publish")
		local brazilDir = Directory("functional-basic-tostring")

		if brazilDir:exists() then brazilDir:delete() end

		local app = Application{
			project = tostring(brazil),
			biomes = View{
				select = "name",
				value = {"Caatinga", "Cerrado", "Amazonia", "Pampa", "Mata Atlantica", "Pantanal"},
				color = {"brown", "purple", "green", "yellow", "blue", "orange"},
				description = "abc.",
			},
			progress = false,
			output = brazilDir,
			title = "Emas",
			zoom = 14,
			center = {lat = -18.106389, long = -52.927778}
		}

		unitTest:assertType(app, "Application")
		unitTest:assert(app.clean)
		unitTest:assert(not app.progress)
		unitTest:assertEquals(tostring(app), [[assets      Directory
base        string [satellite]
center      named table of size 2
clean       boolean [true]
code        boolean [true]
datasource  Directory
display     boolean [true]
layers      string [Layers]
legend      string [Legend]
loading     string [default.gif]
maxZoom     number [20]
minZoom     number [0]
output      Directory
progress    boolean [false]
project     Project
simplify    boolean [false]
template    named table of size 2
temporal    vector of size 0
title       string [Emas]
view        named table of size 1
zoom        number [14]
]])

		if brazilDir:exists() then brazilDir:delete() end
	end
}
