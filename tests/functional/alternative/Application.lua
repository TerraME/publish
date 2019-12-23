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
		local brazil = filePath("brazil.tview", "publish")
		local brazilDir = Directory("functional-alternative-tostring")

		if brazilDir:exists() then brazilDir:delete() end

		local error_func = function()
			Application()
		end
		unitTest:assertError(error_func, tableArgumentMsg())

		error_func = function()
			Application(1)
		end
		unitTest:assertError(error_func, namedArgumentsMsg())

		error_func = function()
			Application{
				arg = "void",
				progress = false,
				project = brazil,
				output = brazilDir,
				biomes = View{
					select = "name",
					value = {"Caatinga", "Cerrado", "Amazonia", "Pampa", "Mata Atlantica", "Pantanal"},
					color = {"brown", "purple", "green", "yellow", "blue", "orange"},
					description = "abc.",
				}
			}
		end
		unitTest:assertWarning(error_func, unnecessaryArgumentMsg("arg"))

		if brazilDir:exists() then brazilDir:delete() end

		error_func = function()
			Application{
				progress = false,
				project = brazil,
				output = brazilDir,
				biomes = View{
					select = "name",
					value = {"Catinga", "Cerrado", "Amazonia", "Pampa", "Mata Atlantica", "Pantanal"},
					color = {"brown", "purple", "green", "yellow", "blue", "orange"},
					description = "abc.",
				}
			}
		end
		unitTest:assertError(error_func, "Value 'Caatinga' belongs to the data but not to the values in the View. Did you write 'Catinga' wrongly?")

		if brazilDir:exists() then brazilDir:delete() end

		local data = {
			select = "river",
			color = "BuGn",
			value = {0, 1, 2},
			progress = false,
			output = brazilDir,
			title = "Emas",
			description = "Creates a database that can be used by the example fire-spread of base package.",
			zoom = 14,
			center = {lat = -18.106389, long = -52.927778}
		}

		error_func = function()
			Application(clone(data))
		end
		unitTest:assertError(error_func, "Argument 'project' or a View with argument 'layer' is mandatory to publish your data.")

		data.project = brazil
		data.key = 1
		error_func = function()
			Application(clone(data))
		end
		unitTest:assertError(error_func, incompatibleTypeMsg("key", "string", 1))

		data.key = "AIzaSyCFXMRJlfDoDK7H"
		error_func = function()
			Application(clone(data))
		end
		unitTest:assertError(error_func, "Argument 'key' must be a string with size equals to 39, got 20.")

		data.key = nil
		data.clean = 1
		error_func = function()
			Application(clone(data))
		end
		unitTest:assertError(error_func, incompatibleTypeMsg("clean", "boolean", 1))

		data.clean = false
		data.progress = 1
		error_func = function()
			Application(clone(data))
		end
		unitTest:assertError(error_func, incompatibleTypeMsg("progress", "boolean", 1))

		data.progress = false
		data.legend = 1
		error_func = function()
			Application(clone(data))
		end
		unitTest:assertError(error_func, incompatibleTypeMsg("legend", "string", 1))

		data.legend = "River values"
		data.output = 1
		error_func = function()
			Application(clone(data))
		end
		unitTest:assertError(error_func, incompatibleTypeMsg("output", "string", 1))

		data.output = brazilDir
		data.color = 123456
		error_func = function()
			Application(clone(data))
		end
		unitTest:assertError(error_func, incompatibleTypeMsg("color", "string or table", 123456))

		data.color = {"#afafah", "#afafah", "#afafah"}
		error_func = function()
			Application(clone(data))
		end
		unitTest:assertError(error_func, "Argument 'color' (#afafah) is not a valid hex color. Please run 'terrame -package publish -showdoc' for more details.")

		data.color = "Redss"
		error_func = function()
			Application(clone(data))
		end
		unitTest:assertError(error_func, "Argument 'color' (Redss) does not exist in ColorBrewer. Please run 'terrame -package publish -showdoc' for more details.")

		data.color = {"Reds", "Blues", "PuRd"}
		error_func = function()
			Application(clone(data))
		end
		unitTest:assertError(error_func, "Argument 'color' (Reds) is not a valid color name. Please run 'terrame -package publish -showdoc' for more details.")

		data.color = {true, true, true}
		error_func = function()
			Application(clone(data))
		end
		unitTest:assertError(error_func, "Argument 'color' has an invalid description for color in position '#1'. It should be a string, number or table, got boolean.")

		data.color = {{-1, 1, 1}, {256, 255, 255}, {1, 1, 1, 2}}
		error_func = function()
			Application(clone(data))
		end
		unitTest:assertError(error_func, "Element '#1' in color '#1' must be an integer between 0 and 255, got -1.")

		data.color = {{0, 0, 0}, {1, 1, 1}, {255, 255, 255, 2}}
		error_func = function()
			Application(clone(data))
		end
		unitTest:assertError(error_func, "The alpha parameter of color '#3' should be a number between 0.0 (fully transparent) and 1.0 (fully opaque), got 2.")

		data.color = {{0, 0, 0, 0.5}, {1, 1, 1, 1}, {255, 255, 255, 1.00001}}
		error_func = function()
			Application(clone(data))
		end
		unitTest:assertError(error_func, "The alpha parameter of color '#3' should be a number between 0.0 (fully transparent) and 1.0 (fully opaque), got 1.00001.")

		data.color = {"#edf8fb", "#b2e2e2"}
		data.value = {}
		error_func = function()
			Application(clone(data))
		end
		unitTest:assertError(error_func, "Argument 'value' must be a table with size greater than 0, got 0.")

		data.value = {0, 1, 2}
		error_func = function()
			Application(clone(data))
		end
		unitTest:assertError(error_func, "The number of colors (2) must be equal to number of data classes (3).")

		data.color = "BuGn"
		data.select = 1
		error_func = function()
			Application(clone(data))
		end
		unitTest:assertError(error_func, incompatibleTypeMsg("select", "string", 1))

		data.select = "river"
		data.loading = "square"
		error_func = function()
			Application(clone(data))
		end
		unitTest:assertError(error_func, "'square' is an invalid value for argument 'loading'. Do you mean 'squares'?")

		data.loading = "xx"
		error_func = function()
			Application(clone(data))
		end
		unitTest:assertError(error_func, "'xx' is an invalid value for argument 'loading'. It must be a string from the"
			.." set ['balls', 'box', 'default', 'ellipsis', 'hourglass', 'poi', 'reload', 'ring', 'ringAlt', 'ripple',"
			.." 'rolling', 'spin', 'squares', 'triangle', 'wheel'].")

		if brazilDir:exists() then brazilDir:delete() end

		local caraguaDir = Directory("CaraguaWebMap")
		if caraguaDir:exists() then caraguaDir:delete() end

		error_func = function()
			Application{
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
				real = View{
					description = "abc.",
					title = "Social Classes 2010",
					select = "classe",
					color = {"red", "orange", "yellow"},
					label = {"Condition C", "Condition B", "Condition A"}
				}
			}
		end
		unitTest:assertError(error_func, "The application must be created using only 'List', got 1 View(s).")

		if caraguaDir:exists() then caraguaDir:delete() end

		data.loading = nil
		data.simplify = 1
		error_func = function()
			Application(clone(data))
		end
		unitTest:assertError(error_func, incompatibleTypeMsg("simplify", "boolean", 1))
		if brazilDir:exists() then brazilDir:delete() end

		local arapiunsDir = Directory("ArapiunsWebMap")
		if arapiunsDir:exists() then arapiunsDir:delete() end

		local file = File("arapiuns-test.tview")
		file:deleteIfExists()

		local warning_func = function()
			local gis = getPackage("gis")
			local proj = gis.Project{
				title = "The riverine settlements at Arapiuns (PA)",
				author = "Carneiro, H.",
				file = file,
				clean = true,
				villages = filePath("AllCmmTab_210316OK.shp", "publish")
			}

			Application{
				project = proj,
				output = arapiunsDir,
				simplify = false,
				villages = View{
					description = "Riverine settlements corresponded to Indian tribes, villages, and communities that are inserted into public lands.",
				}
			}
		end
		unitTest:assertWarning(warning_func, defaultValueMsg("simplify", false))
		if arapiunsDir:exists() then arapiunsDir:delete() end
		file:deleteIfExists()

		file = File("temporal.tview")
		file:deleteIfExists()

		local temporalDir = Directory("temporal-test")
		if temporalDir:exists() then temporalDir:delete() end

		local gis = getPackage("gis")
		local proj = gis.Project{
			title = "Testing temporal View",
			author = "Carneiro, H.",
			file = file,
			clean = true,
			uc = filePath("uc_federais_2016.shp", "publish")
		}

		error_func = function()
			Application{
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
				}
			}
		end
		unitTest:assertError(error_func, "Temporal View of mode 'snapshot' declared, but no Layer was found.")

		error_func = function()
			Application{
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
					name = "nome",
					time = "creation"
				}
			}
		end
		unitTest:assertError(error_func, "Argument 'name' of View 'uc' must be a column with integers that represent years, got string in row 1.")

		error_func = function()
			Application{
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
					name = "areaHa",
					time = "creation"
				}
			}
		end
		unitTest:assertError(error_func, "Argument 'name' of View 'uc' must be a column with integers that represent years, got float in row 1.")

		error_func = function()
			Application{
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
					name = "codUso",
					time = "creation"
				}
			}
		end
		unitTest:assertError(error_func, "Argument 'name' of View 'uc' with invalid pattern for year (YYYY), got 1 in row 1.")

		error_func = function()
			Application{
				base = "roadmap",
				project = proj,
				output = temporalDir,
				progress = false,
				a = View {
					title = "UC",
					description = "UC Federais.",
					select = "anoCriacao",
					color = "Spectral",
					slices = 10,
					name = "anoCriacao",
					time = "creation"
				}
			}
		end
		unitTest:assertError(error_func, "The application does not have any View related to a Layer.")

		proj = gis.Project{
			title = "Testing temporal View",
			file = file,
			clean = true,
			amaz = filePath("test/CellsAmaz.shp", "publish")
		}

		error_func = function()
			Application{
				base = "roadmap",
				project = proj,
				output = temporalDir,
				progress = false,
				amaz = View {
					title = "Amaz",
					description = "Amazonia.",
				}
			}
		end
		unitTest:assertError(error_func, "Data has a missing value in attribute 'pointcount'. Use argument 'missing' to set its value.")

		error_func = function()
			file:deleteIfExists()
			proj = gis.Project{
				title = "Testing temporal View",
				author = "Carneiro, H.",
				file = file,
				clean = true,
				snapshot1_2001 = filePath("uc_federais_2001.shp", "publish"),
				snapshot2_2001 = filePath("uc_federais_2001.shp", "publish")
			}

			Application{
				base = "roadmap",
				project = proj,
				output = temporalDir,
				progress = false,
				snapshot1 = View {
					title = "UC",
					description = "UC Federais.",
					select = "anoCriacao",
					color = "Spectral",
					slices = 10,
					time = "snapshot"
				}
			}
		end
		unitTest:assertError(error_func, "Layer 'snapshot2_2001' is not a temporal View of mode 'snapshot'.")

		file:deleteIfExists()
		if temporalDir:exists() then temporalDir:delete() end

		if caraguaDir:exists() then caraguaDir:delete() end
		file = File("scenario.tview")

		error_func = function()
			file:deleteIfExists()
			proj = gis.Project{
				title = "Future Scenarios",
				author = "Carneiro, H.",
				file = file,
				clean = true,
				classes_2010 = filePath("caragua_classes2010_regioes.shp", "publish"),
				classes_baseline_2025 = filePath("simulation2025_baseline.shp", "publish")
			}

			Application{
				project = proj,
				progress = false,
				output = caraguaDir,
				scenario = {},
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
		end
		unitTest:assertError(error_func, "Argument 'scenario' must be named table whose indexes are the names of the scenarios and whose values are strings with the descriptions of the scenarios.")

		error_func = function()
			file:deleteIfExists()
			proj = gis.Project{
				title = "Future Scenarios",
				author = "Carneiro, H.",
				file = file,
				clean = true,
				classes_2010 = filePath("caragua_classes2010_regioes.shp", "publish"),
				classes_baseline_2025 = filePath("simulation2025_baseline.shp", "publish")
			}

			Application{
				project = proj,
				progress = false,
				output = caraguaDir,
				scenario = {"Baseline simulation for 2025."},
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
		end
		unitTest:assertError(error_func, "Argument 'scenario' must be named table whose indexes are the names of the scenarios and whose values are strings with the descriptions of the scenarios.")

		error_func = function()
			file:deleteIfExists()
			proj = gis.Project{
				title = "Future Scenarios",
				author = "Carneiro, H.",
				file = file,
				clean = true,
				classes_2010 = filePath("caragua_classes2010_regioes.shp", "publish"),
				classes_baseline_2025 = filePath("simulation2025_baseline.shp", "publish")
			}

			Application{
				project = proj,
				progress = false,
				output = caraguaDir,
				scenario = {
					baseline = 1,
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
		end
		unitTest:assertError(error_func, "Argument 'scenario' must have strings values with the descriptions, got number in the scenario 'baseline'.")

		error_func = function()
			file:deleteIfExists()
			proj = gis.Project{
				title = "Future Scenarios",
				author = "Carneiro, H.",
				file = file,
				clean = true,
				classes_2010 = filePath("caragua_classes2010_regioes.shp", "publish"),
				classes_baseline_2025 = filePath("simulation2025_baseline.shp", "publish")
			}

			Application{
				project = proj,
				progress = false,
				output = caraguaDir,
				scenario = {
					void = "Baseline simulation for 2025.",
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
		end
		unitTest:assertError(error_func, "Scenario 'void' does not exist in project 'Future Scenarios'.")

		error_func = function()
			file:deleteIfExists()
			proj = gis.Project{
				title = "Future Scenarios",
				author = "Carneiro, H.",
				file = file,
				clean = true,
				classes_2010 = filePath("caragua_classes2010_regioes.shp", "publish"),
				classes_baseline_20255 = filePath("simulation2025_baseline.shp", "publish")
			}

			Application{
				project = proj,
				progress = false,
				output = caraguaDir,
				scenario = {
					baseline = "Baseline simulation for 2025.",
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
		end
		unitTest:assertError(error_func, "Layer 'classes_baseline_20255' has an invalid pattern for temporal View [Ex. name_2017].")

		error_func = function()
			file:deleteIfExists()
			proj = gis.Project{
				title = "Future Scenarios",
				author = "Carneiro, H.",
				file = file,
				clean = true,
				classes_2010 = filePath("caragua_classes2010_regioes.shp", "publish"),
				classes_baseline_2025 = filePath("simulation2025_baseline.shp", "publish")
			}

			Application{
				project = proj,
				progress = false,
				output = caraguaDir,
				scenario = {
					baseline = "Baseline simulation for 2025.",
				},
				classes = View{
					title = "Social Classes 2010",
					description = "This is the main endogenous variable of the model. It was obtained from a classification that "
							.."categorizes the social conditions of households in Caraguatatuba on 'condition A' (best), 'B' or 'C''.",
					width = 0,
					select = "classe",
					color = {"red", "orange", "yellow"},
					label = {"Condition C", "Condition B", "Condition A"},
					name = "classe",
					time = "creation"
				}
			}
		end
		unitTest:assertError(error_func, "View temporal of mode 'snapshot' is mandatory when using argument 'scenario'.")

		error_func = function()
			file:deleteIfExists()
			proj = gis.Project{
				title = "Future Scenarios",
				author = "Carneiro, H.",
				file = file,
				clean = true,
				classes_baseline_2025 = filePath("simulation2025_baseline.shp", "publish")
			}

			Application{
				project = proj,
				progress = false,
				output = caraguaDir,
				scenario = {
					baseline = "Baseline simulation for 2025.",
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
		end
		unitTest:assertError(error_func, "View 'classes' has only future scenarios.")

		file:deleteIfExists()
		if caraguaDir:exists() then caraguaDir:delete() end
	end
}
