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
		local emasDir = Directory("view-basic-app")

		local function assertFiles(dir, files)
			local count = 0
			forEachFile(dir, function(file)
				unitTest:assert(files[file:name()])

				count = count + 1
			end)

			unitTest:assertEquals(count, getn(files))
		end

		if emasDir:exists() then emasDir:delete() end

		-- Testing Application: project = nil, layers = {firebreak_lin, accumulation_Nov94May00, River_lin, Limit_pol} and package = nil.
		local app = Application{
			title = "app",
			description = "Creates a database that can be used by the example fire-spread of base package.",
			zoom = 14,
			center = {lat = -18.106389, long = -52.927778},
			progress = false,
			output = emasDir,
			logo = packageInfo("luadoc").path.."/logo/logo.png",
			order = {"river", "firebreak", "limit"},
			river = View{
				description = "abc.",
				color = {0, 0, 255},
				layer = filePath("emas-river.shp", "gis")
			},
			firebreak = View{
				description = "abc.",
				color = "black",
				layer = filePath("emas-firebreak.shp", "gis")
			},
			limit = View{
				description = "abc.",
				border = "blue",
				color = "goldenrod",
				width = 2,
				layer = filePath("emas-limit.shp", "gis")
			}
		}

		unitTest:assertType(app, "Application")
		unitTest:assertType(app.project, "Project")
		unitTest:assertType(app.output, "Directory")
		unitTest:assert(app.output:exists())
		unitTest:assert(app.clean)
		unitTest:assert(not app.progress)
		unitTest:assertEquals(getn(app.view), getn(app.project.layers)) -- TODO #14. Raster layers are not counted.
		--unitTest:assertEquals(getn(app.view), getn(appData)) -- SKIP TODO #14. Raster layers are not counted.

		unitTest:assertEquals(app.view.river.width, 1)
		unitTest:assertEquals(app.view.limit.width, 2)
		unitTest:assert(app.view.limit.visible)

		unitTest:assertEquals(app.view.river.order, 3)
		unitTest:assertEquals(app.view.firebreak.order, 2)
		unitTest:assertEquals(app.view.limit.order, 1)

		local appRoot = {
			["index.html"] = true,
			["default.gif"] = true,
			["config.js"] = true,
			["limit.geojson"] = true,
			["firebreak.geojson"] = true,
			["river.geojson"] = true,
			["jquery-1.9.1.min.js"] = true,
			["publish.min.css"] = true,
			["publish.min.js"] = true,
			["logo.png"] = true
		}

		assertFiles(app.output, appRoot)
		--assertFiles(app.assets, appAssets)
		--assertFiles(app.datasource, appData)

		unitTest:assert(not isFile(app.title..".tview"))
		if emasDir:exists() then emasDir:delete() end

		-- Testing Application: project = Project, view = {firebreak, river} and package = nil.
		app = Application{
			title = "Emas",
			description = "Creates a database that can be used by the example fire-spread of base package.",
			zoom = 14,
			center = {lat = -18.106389, long = -52.927778},
			project = filePath("emas.tview", "publish"),
			progress = false,
			output = emasDir,
			order = {"river"},
			river = View{
				description = "abc.",
				color = "blue",
				transparency = 0.6
			},
			firebreak = View{
				description = "abc.",
				color = "black",
				transparency = 0.5
			}
		}

		unitTest:assertType(app, "Application")
		unitTest:assertType(app.project, "Project")
		unitTest:assertType(app.output, "Directory")
		unitTest:assert(app.output:exists())
		unitTest:assert(app.clean)
		unitTest:assert(not app.progress)
		unitTest:assertEquals(getn(app.view), getn(app.project.layers) - 2)
		--unitTest:assertEquals(getn(app.view), getn(appData)) -- SKIP

		unitTest:assertEquals(app.view.river.order, 2)
		unitTest:assertEquals(app.view.firebreak.order, 1)

		unitTest:assertEquals(app.view.river.color, "rgba(0, 0, 255, 0.4)")
		unitTest:assertEquals(app.view.firebreak.color, "rgba(0, 0, 0, 0.5)")

		appRoot = {
			["index.html"] = true,
			["config.js"] = true,
			["firebreak.geojson"] = true,
			["default.gif"] = true,
			["jquery-1.9.1.min.js"] = true,
			["publish.min.css"] = true,
			["publish.min.js"] = true,
			["river.geojson"] = true
		}

		assertFiles(app.output, appRoot)
		--assertFiles(app.assets, appAssets)
		--assertFiles(app.datasource, appData)

		if emasDir:exists() then emasDir:delete() end

		app = Application{
			title = "Emas",
			description = "Creates a database that can be used by the example fire-spread of base package.",
			project = filePath("emas.tview", "publish"),
			progress = false,
			output = emasDir,
			river = View{
				description = "abc.",
				color = "blue"
			},
			firebreak = View{
				description = "abc.",
				color = "black"
			}
		}

		unitTest:assertType(app, "Application")
		unitTest:assertType(app.project, "Project")
		unitTest:assertType(app.output, "Directory")
		unitTest:assert(app.output:exists())
		unitTest:assertEquals(getn(app.view), getn(app.project.layers) - 2)

		unitTest:assertEquals(app.view.firebreak.order, 2)
		unitTest:assertEquals(app.view.river.order, 1)

		app = Application{
			title = "Emas",
			description = "Creates a database that can be used by the example fire-spread of base package.",
			project = filePath("emas.tview", "publish"),
			progress = false,
			output = emasDir,
		}

		unitTest:assertEquals(app.view.cells.order, 4)
		unitTest:assertEquals(app.view.firebreak.order, 3)
		unitTest:assertEquals(app.view.limit.order, 2)
		unitTest:assertEquals(app.view.river.order, 1)

		if emasDir:exists() then emasDir:delete() end

		local caraguaDir = Directory("CaraguaWebMap")

		local report = Report{title = "URBIS-Caraguá"}
		report:addImage("urbis_2010_real.PNG", "publish")
		report:addText("This is the main endogenous variable of the model. It was obtained from a classification that categorizes the social conditions of households in Caraguatatuba on \"condition A\" (best), \"B\" or \"C\". This classification was carried out through satellite imagery interpretation and a cluster analysis (k-means method) on a set of indicators build from census data of income, education, dependency ratio, householder gender, and occupation condition of households. More details on this classification were presented in Feitosa et al. (2012) Vulnerabilidade e Modelos de Simulação como Estratégias Mediadoras: contribuiçãoo ao debate das mudanças climáticas e ambientais.")

		app = Application{
			project = filePath("caragua.tview", "publish"),
			progress = false,
			output = caraguaDir,
			report = report,
			limit = View{
				description = "Bounding box of Caraguatatuba",
				color = "goldenrod"
			},
			real = View{
				title = "Social Classes 2010 Real",
				description = "This is the main endogenous variable of the model. It was obtained from a classification that"
							.." categorizes the social conditions of households in Caraguatatuba on 'condition A' (best), 'B' or 'C''.",
				width = 0,
				visible = false,
				select = "classe",
				color = {"red", "orange", "yellow"}
			}
		}

		unitTest:assertType(app, "Application")
		unitTest:assertType(app.project, "Project")
		unitTest:assertType(app.output, "Directory")
		unitTest:assert(app.output:exists())
		unitTest:assertType(app.images, "Directory")
		unitTest:assert(app.images:exists())

		unitTest:assertType(app.report, "table")
		unitTest:assertEquals(app.report.title, "URBIS-Caraguá")
		unitTest:assertType(app.report.reports, "table")
		unitTest:assertEquals(#app.report.reports, 2)
		unitTest:assertNil(app.report.layer)

		unitTest:assertEquals(app.view.real.color["1"], "rgba(255, 0, 0, 1)")
		unitTest:assertEquals(app.view.real.color["2"], "rgba(255, 165, 0, 1)")
		unitTest:assertEquals(app.view.real.color["3"], "rgba(255, 255, 0, 1)")

		local reportUse = Report{title = "Occupational Classes"}
		reportUse:addText("The percentage of houses and apartments inside such areas that is typically used in summer vacations and holidays.")

		app = Application{
			project = filePath("caragua.tview", "publish"),
			progress = false,
			output = caraguaDir,
			limit = View{
				description = "Bounding box of Caraguatatuba",
				color = "goldenrod",
				report = report
			},
			real = View{
				title = "Social Classes 2010 Real",
				description = "This is the main endogenous variable of the model. It was obtained from a classification that"
						.." categorizes the social conditions of households in Caraguatatuba on 'condition A' (best), 'B' or 'C''.",
				width = 0,
				select = "classe",
				color = {"red", "orange", "yellow"},
				transparency = 0.1,
				report = report
			},
			use = View{
				title = "Occupational Classes (IBGE, 2010)",
				description = "The occupational class describes the percentage of houses and apartments inside such areas that have occasional use.",
				width = 0,
				select = "uso",
				transparency = 0.6,
				color = {{255, 204, 255}, {242, 160, 241}, {230, 117, 228}, {214, 71, 212}, {199, 0, 199}},
				value = {1, 2, 3, 4, 5},
				report = reportUse
			}
		}

		unitTest:assertType(app, "Application")
		unitTest:assertType(app.project, "Project")
		unitTest:assertType(app.output, "Directory")
		unitTest:assert(app.output:exists())
		unitTest:assertType(app.images, "Directory")
		unitTest:assert(app.images:exists())
		unitTest:assertNil(app.report)

		local view = app.view.limit
		unitTest:assertType(view, "View")
		unitTest:assertType(view.color, "string")
		unitTest:assertType(view.report, "Report")

		unitTest:assertEquals(view.color, "rgba(218, 165, 32, 1)")
		unitTest:assertEquals(view.transparency, 1)
		unitTest:assertEquals(view.report.title, "URBIS-Caraguá")

		local reports = view.report:get()
		unitTest:assertType(reports, "table")
		unitTest:assertEquals(#reports, 2)

		view = app.view.real
		unitTest:assertType(view, "View")
		unitTest:assertType(view.color, "table")
		unitTest:assertType(view.report, "Report")

		unitTest:assertEquals(getn(view.color), 3)
		unitTest:assertEquals(view.color["1"], "rgba(255, 0, 0, 0.9)")
		unitTest:assertEquals(view.color["2"], "rgba(255, 165, 0, 0.9)")
		unitTest:assertEquals(view.color["3"], "rgba(255, 255, 0, 0.9)")
		unitTest:assertEquals(view.transparency, 0.9)
		unitTest:assertEquals(view.report.title, "URBIS-Caraguá")

		reports = view.report:get()
		unitTest:assertType(reports, "table")
		unitTest:assertEquals(#reports, 2)

		view = app.view.use
		unitTest:assertType(view, "View")
		unitTest:assertType(view.color, "table")
		unitTest:assertType(view.report, "Report")

		unitTest:assertEquals(getn(view.color), 5)
		unitTest:assertEquals(view.color["1"], "rgba(255, 204, 255, 0.4)")
		unitTest:assertEquals(view.color["2"], "rgba(242, 160, 241, 0.4)")
		unitTest:assertEquals(view.color["3"], "rgba(230, 117, 228, 0.4)")
		unitTest:assertEquals(view.color["4"], "rgba(214, 71, 212, 0.4)")
		unitTest:assertEquals(view.color["5"], "rgba(199, 0, 199, 0.4)")
		unitTest:assertEquals(view.transparency, 0.4)
		unitTest:assertEquals(view.report.title, "Occupational Classes")

		reports = view.report:get()
		unitTest:assertType(reports, "table")
		unitTest:assertEquals(#reports, 1)

		appRoot = {
			["index.html"] = true,
			["config.js"] = true,
			["default.gif"] = true,
			["jquery-1.9.1.min.js"] = true,
			["publish.min.css"] = true,
			["publish.min.js"] = true,
			["limit.geojson"] = true,
			["real.geojson"] = true,
			["use.geojson"] = true,
			["urbis_2010_real.PNG"] = true
		}

		assertFiles(app.output, appRoot)
		--assertFiles(app.assets, appAssets)
		--assertFiles(app.datasource, appData)
		--assertFiles(app.images, appImages)

		if caraguaDir:exists() then caraguaDir:delete() end
		local projRaster = File("raster.tview")
		projRaster:deleteIfExists()

		local gis = getPackage("gis")
		local proj = gis.Project{
			title = "Urbis",
			author = "Carneiro, H.",
			file = projRaster,
			clean = true,
			real = filePath("caragua_classes2010_regioes.tif", "publish")
		}

		app = Application{
			project = proj,
			description = "The data of this application were extracted from Feitosa et. al (2014) URBIS-Caraguá: "
					.. "Um Modelo de Simulação Computacional para a Investigação de Dinâmicas de Ocupação Urbana em Caraguatatuba, SP.",
			output = caraguaDir,
			progress = false,
			real = View {
				title = "Social Classes 2010",
				description = "This is the main endogenous variable of the model. It was obtained from a classification that "
						.. "categorizes the social conditions of households in Caraguatatuba on 'condition A' (best), 'B' or 'C''.",
				color = "Reds",
				slices = 3
			}
		}

		unitTest:assertType(app, "Application")

		view = app.view.real
		unitTest:assertType(view, "View")
		unitTest:assertType(view.color, "table")

		unitTest:assertEquals(view.slices, 3)
		unitTest:assertEquals(getn(view.color), 3)
		unitTest:assertEquals(view.color["1.0"], "rgba(254, 224, 210, 1)")
		unitTest:assertEquals(view.color["2.0"], "rgba(252, 146, 114, 1)")
		unitTest:assertEquals(view.color["3.0"], "rgba(222, 45, 38, 1)")

		appRoot = {
			["index.html"] = true,
			["config.js"] = true,
			["default.gif"] = true,
			["jquery-1.9.1.min.js"] = true,
			["publish.min.css"] = true,
			["publish.min.js"] = true,
			["real.geojson"] = true
		}

		assertFiles(app.output, appRoot)

		projRaster:deleteIfExists()
		if caraguaDir:exists() then caraguaDir:delete() end

		local vegDir = Directory("raster-with-no-srid")
		proj = gis.Project{
			title = "Vegtype",
			author = "Carneiro, H.",
			file = projRaster,
			clean = true,
			vegtype = filePath("vegtype_2000_5880.tif", "publish")
		}

		app = Application{
			project = proj,
			description = "The data of this application were extracted from Feitosa et. al (2014) URBIS-Caraguá: "
					.. "Um Modelo de Simulação Computacional para a Investigação de Dinâmicas de Ocupação Urbana em Caraguatatuba, SP.",
			output = vegDir,
			progress = false,
			vegtype = View {
				title = "Vegetation Type 2000",
				description = "Vegetation type Inland.",
				color = "BuGn"
			}
		}

		unitTest:assertType(app, "Application")

		view = app.view.vegtype
		unitTest:assertType(view, "View")
		unitTest:assertType(view.color, "table")

		unitTest:assertEquals(getn(view.color), 7)

		appRoot = {
			["index.html"] = true,
			["config.js"] = true,
			["default.gif"] = true,
			["jquery-1.9.1.min.js"] = true,
			["publish.min.css"] = true,
			["publish.min.js"] = true,
			["vegtype.geojson"] = true
		}

		assertFiles(app.output, appRoot)

		if vegDir:exists() then vegDir:delete() end
		app = Application{
			project = proj,
			description = "The data of this application were extracted from INLAND project (http://www.ccst.inpe.br/projetos/inland/).",
			output = vegDir,
			progress = false,
			title = "Vegetation scenario",
			vegtype = View {
				title = "Vegetation Type 2000",
				description = "Vegetation type Inland.",
				value = {-127, 1, 2, 3, 9, 10, 12},
				color = {"red", "blue", "green", "yellow", "brown", "cyan", "orange"}
			}
		}

		unitTest:assertType(app, "Application")

		view = app.view.vegtype
		unitTest:assertType(view, "View")
		unitTest:assertType(view.color, "table")
		unitTest:assertType(view.value, "table")

		unitTest:assertEquals(getn(view.value), 7)
		projRaster:deleteIfExists()
		if vegDir:exists() then vegDir:delete() end

		if caraguaDir:exists() then caraguaDir:delete() end
		app = Application{
			project = filePath("caragua.tview", "publish"),
			description = "The data of this application were extracted from Feitosa et. al (2014) URBIS-Caraguá: "
					.. "Um Modelo de Simulação Computacional para a Investigação de Dinâmicas de Ocupação Urbana em Caraguatatuba, SP.",
			output = caraguaDir,
			progress = false,
			limit = View{
				description = "Bounding box of Caraguatatuba.",
				color = "goldenrod"
			}
		}

		unitTest:assertType(app, "Application")

		view = app.view.limit
		unitTest:assertType(view, "View")
		unitTest:assertType(view.color, "string")
		unitTest:assertEquals(view.color, "rgba(218, 165, 32, 1)")

		if caraguaDir:exists() then caraguaDir:delete() end

		local arapiunsDir = Directory("ArapiunsWebMap")
		if arapiunsDir:exists() then arapiunsDir:delete() end

		app = Application{
			project = filePath("arapiuns.tview", "publish"),
			base = "roadmap",
			progress = false,
			output = arapiunsDir,
			villages = View{
				description = "Riverine settlements corresponded to Indian tribes, villages, and communities that are inserted into public lands.",
				icon = "home"
			}
		}

		unitTest:assertType(app, "Application")
		unitTest:assertType(app.project, "Project")
		unitTest:assertType(app.output, "Directory")
		unitTest:assert(app.output:exists())
		unitTest:assertNil(app.report)

		view = app.view.villages
		unitTest:assertType(view, "View")
		unitTest:assertType(view.description, "string")
		unitTest:assertEquals(view.description, "Riverine settlements corresponded to Indian tribes, villages, and communities that are inserted into public lands.")

		-- unitTest:assert(File(app.output.."home.png"):exists()) -- SKIP TODO: FIXME this file should exist

		if arapiunsDir:exists() then arapiunsDir:delete() end

		app = Application{
			project = filePath("arapiuns.tview", "publish"),
			base = "roadmap",
			progress = false,
			output = arapiunsDir,
			villages = View{
				description = "Riverine settlements corresponded to Indian tribes, villages, and communities that are inserted into public lands.",
				download = true,
				select = "Nome",
				report = function(cell)
					local mreport = Report{title = cell.Nome}
					mreport:addImage(packageInfo("publish").data.."arapiuns/"..cell.Nome..".jpg")
					return mreport
				end
			}
		}

		unitTest:assertType(app, "Application")
		unitTest:assertType(app.project, "Project")
		unitTest:assertType(app.output, "Directory")
		unitTest:assert(app.output:exists())
		unitTest:assertNil(app.report)

		view = app.view.villages
		unitTest:assertType(view, "View")
		unitTest:assertType(view.description, "string")
		unitTest:assertEquals(view.description, "Riverine settlements corresponded to Indian tribes, villages, and communities that are inserted into public lands.")
		unitTest:assertEquals(view.select, "Nome")
		unitTest:assertType(view.report, "function")
		unitTest:assertType(view.geom, "string")
		unitTest:assertEquals(view.geom, "MultiPoint")
		unitTest:assert(view.download)
		unitTest:assert(isFile(arapiunsDir.."villages.zip"))

		if arapiunsDir:exists() then arapiunsDir:delete() end

		app = Application{
			project = filePath("arapiuns.tview", "publish"),
			base = "roadmap",
			progress = false,
			output = arapiunsDir,
			villages = View{
				description = "Riverine settlements corresponded to Indian tribes, villages, and communities that are inserted into public lands.",
				download = true,
				select = "Nome",
				icon = "home",
				report = function(cell)
					local mreport = Report{title = cell.Nome}
					mreport:addImage(packageInfo("publish").data.."arapiuns/"..cell.Nome..".jpg")
					return mreport
				end
			}
		}

		unitTest:assertType(app, "Application")
		unitTest:assertType(app.project, "Project")
		unitTest:assertType(app.output, "Directory")
		unitTest:assert(app.output:exists())
		unitTest:assertNil(app.report)

		view = app.view.villages
		unitTest:assertType(view, "View")
		unitTest:assertEquals(view.icon.path, "home.png")
		unitTest:assert(File(app.output..view.icon.path):exists())
		unitTest:assertNil(view.icon.time)

		app = Application{
			project = filePath("arapiuns.tview", "publish"),
			base = "roadmap",
			progress = false,
			output = arapiunsDir,
			trajectory = View{
				description = "Route on the Arapiuns River.",
				width = 3,
				border = "blue",
			}
		}

		unitTest:assertType(app, "Application")
		unitTest:assertType(app.project, "Project")
		unitTest:assertType(app.output, "Directory")
		unitTest:assert(app.output:exists())
		unitTest:assertNil(app.report)

		view = app.view.trajectory
		unitTest:assertType(view, "View")
		--unitTest:assertEquals(view.icon.options.path, "M150 0 L75 200 L225 200 Z") -- SKIP
		--unitTest:assertEquals(view.icon.options.fillColor, "rgba(0, 0, 0, 1)") -- SKIP
		--unitTest:assertEquals(view.icon.options.fillOpacity, 0.8) -- SKIP
		--unitTest:assertEquals(view.icon.options.strokeWeight, 2) -- SKIP
		--unitTest:assertEquals(view.icon.time, 25) -- SKIP

		app = Application{
			project = filePath("arapiuns.tview", "publish"),
			base = "roadmap",
			progress = false,
			output = arapiunsDir,
			trajectory = View{
				description = "Route on the Arapiuns River.",
				width = 3,
				border = "blue",
			}
		}

		unitTest:assertType(app, "Application")
		unitTest:assertType(app.project, "Project")
		unitTest:assertType(app.output, "Directory")
		unitTest:assert(app.output:exists())
		unitTest:assertNil(app.report)

		view = app.view.trajectory
		unitTest:assertType(view, "View")
		--unitTest:assertEquals(view.icon.options.path, "M150 0 L75 200 L225 200 Z") -- SKIP
		--unitTest:assertEquals(view.icon.options.fillColor, "rgba(0, 0, 0, 1)") -- SKIP
		--unitTest:assertEquals(view.icon.options.fillOpacity, 1) -- SKIP
		--unitTest:assertEquals(view.icon.options.strokeWeight, 2) -- SKIP
		--unitTest:assertEquals(view.icon.time, 25) -- SKIP

		if arapiunsDir:exists() then arapiunsDir:delete() end

		app = Application{
			project = filePath("arapiuns.tview", "publish"),
			base = "roadmap",
			progress = false,
			output = arapiunsDir,
			villages = View{
				description = "Riverine settlements corresponded to Indian tribes, villages, and communities that are inserted into public lands.",
				download = true,
				select = "UC",
				icon = {"home", "forest"}
			}
		}

		unitTest:assertType(app, "Application")
		unitTest:assertType(app.project, "Project")
		unitTest:assertType(app.output, "Directory")
		unitTest:assert(app.output:exists())
		unitTest:assertNil(app.report)

		view = app.view.villages
		unitTest:assertType(view, "View")
		--unitTest:assertNil(view.icon.path) -- SKIP
		--unitTest:assertNil(view.icon.time) -- SKIP

		unitTest:assertEquals(view.select, "UC")
		--unitTest:assertEquals(view.icon.options["0"], "home.png") -- SKIP
		--unitTest:assertEquals(view.icon.options["1"], "forest.png") -- SKIP

		--unitTest:assertEquals(view.label["UC 0"], "home.png") -- SKIP
		--unitTest:assertEquals(view.label["UC 1"], "forest.png") -- SKIP

		--unitTest:assert(isFile(app.output..view.icon.options["0"])) -- SKIP
		--unitTest:assert(isFile(app.output..view.icon.options["1"])) -- SKIP

		if arapiunsDir:exists() then arapiunsDir:delete() end

		app = Application{
			project = filePath("arapiuns.tview", "publish"),
			base = "roadmap",
			progress = false,
			output = arapiunsDir,
			villages = View{
				description = "Riverine settlements corresponded to Indian tribes, villages, and communities that are inserted into public lands.",
				download = true,
				select = "UC",
				icon = {"home", "forest"},
				label = {"Absence of Conservation Unit", "Presence of Conservation Unit"}
			}
		}

		unitTest:assertType(app, "Application")
		unitTest:assertType(app.project, "Project")
		unitTest:assertType(app.output, "Directory")
		unitTest:assert(app.output:exists())
		unitTest:assertNil(app.report)

		view = app.view.villages
		unitTest:assertType(view, "View")
		unitTest:assertNil(view.icon.options.path)
		unitTest:assertNil(view.icon.time)

		unitTest:assertEquals(view.select, "UC")
		unitTest:assertEquals(view.icon.options["0"], "home.png")
		unitTest:assertEquals(view.icon.options["1"], "forest.png")

		unitTest:assertEquals(view.label["Absence of Conservation Unit"], "home.png")
		unitTest:assertEquals(view.label["Presence of Conservation Unit"], "forest.png")

		unitTest:assert(isFile(app.output..view.icon.options["0"]))
		unitTest:assert(isFile(app.output..view.icon.options["1"]))

		if arapiunsDir:exists() then arapiunsDir:delete() end

		local ncells = 0
		app = Application{
			project = filePath("arapiuns.tview", "publish"),
			base = "roadmap",
			progress = false,
			output = arapiunsDir,
			villages = View{
				description = "Riverine settlements corresponded to Indian tribes, villages, and communities that are inserted into public lands.",
				download = true,
				select = {"Nome", "UC"},
				icon = {"home", "forest"},
				report = function(cell)
					local mreport = Report{title = cell.Nome}
					ncells = ncells + 1
					return mreport
				end
			}
		}

		unitTest:assertType(app, "Application")
		unitTest:assertType(app.project, "Project")
		unitTest:assertType(app.output, "Directory")
		unitTest:assert(app.output:exists())
		unitTest:assertNil(app.report)

		view = app.view.villages
		unitTest:assertType(view, "View")
		unitTest:assertNil(view.icon.options.path)
		unitTest:assertNil(view.icon.time)

		unitTest:assertEquals(view.select[1], "Nome")
		unitTest:assertEquals(view.select[2], "UC")
		unitTest:assertEquals(view.icon.options["0"], "home.png")
		unitTest:assertEquals(view.icon.options["1"], "forest.png")

		unitTest:assertEquals(view.label["0"], "home.png")
		unitTest:assertEquals(view.label["1"], "forest.png")

		unitTest:assert(isFile(app.output..view.icon.options["0"]))
		unitTest:assert(isFile(app.output..view.icon.options["1"]))

		unitTest:assertEquals(ncells, 49)

		if arapiunsDir:exists() then arapiunsDir:delete() end
	end
}
