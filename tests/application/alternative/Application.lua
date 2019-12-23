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
		local emasDir = Directory("view-alternative-app")
		if emasDir:exists() then emasDir:delete() end

		local gis = getPackage("gis")
		gis.Project{
			file = "emas.tview",
			clean = true,
			firebreak = filePath("emas-firebreak.shp", "gis"),
			river = filePath("emas-river.shp", "gis"),
			limit = filePath("emas-limit.shp", "gis")
		}

		local error_func = function()
			Application{
				title = "Emas",
				description = "Creates a database that can be used by the example fire-spread of base package.",
				zoom = 14,
				center = {lat = -18.106389, long = -52.927778},
				project = "emas.tview",
				progress = false,
				output = emasDir,
				order = 1,
				cover = View{
					description = "abc.",
					color = "green"
				}
			}
		end
		unitTest:assertError(error_func, incompatibleTypeMsg("order", "table", 1))

		error_func = function()
			Application{
				title = "Emas",
				description = "Creates a database that can be used by the example fire-spread of base package.",
				zoom = 14,
				center = {lat = -18.106389, long = -52.927778},
				project = "emas.tview",
				progress = false,
				output = emasDir,
				order = {1},
				limit = View{
					description = "abc.",
					color = "green"
				}
			}
		end
		unitTest:assertError(error_func, "All elements of 'order' must be a string. View '1' (1) got 'number'.")

		error_func = function()
			Application{
				title = "Emas",
				description = "Creates a database that can be used by the example fire-spread of base package.",
				zoom = 14,
				center = {lat = -18.106389, long = -52.927778},
				project = "emas.tview",
				progress = false,
				output = emasDir,
				order = {"limit", "cells"},
				limit = View{
					description = "abc.",
					color = "green"
				}
			}
		end
		unitTest:assertError(error_func, "Argument 'order' must be a table with size greater > 0 and <= '1', got '2'.")

		error_func = function()
			Application{
				title = "Emas",
				description = "Creates a database that can be used by the example fire-spread of base package.",
				zoom = 14,
				center = {lat = -18.106389, long = -52.927778},
				project = "emas.tview",
				progress = false,
				output = emasDir,
				order = {"limi"},
				limit = View{
					description = "abc.",
					color = "green"
				}
			}
		end
		unitTest:assertError(error_func, "View 'limi' in argument 'order' (1) does not exist.")

		if emasDir:exists() then emasDir:delete() end

		local arapiunsDir = Directory("ArapiunsWebMap")
		if arapiunsDir:exists() then arapiunsDir:delete() end

		gis.Project{
			title = "The riverine settlements at Arapiuns (PA)",
			file = "arapiuns.tview",
			clean = true,
			trajectory = filePath("arapiuns_traj.shp", "publish"),
			villages = filePath("AllCmmTab_210316OK.shp", "publish")
		}

		error_func = function()
			Application{
				project = "arapiuns.tview",
				base = "roadmap",
				progress = false,
				output = arapiunsDir,
				villages = View{
					description = "Riverine settlements corresponded to Indian tribes, villages, and communities that are inserted into public lands.",
					icon = {
						path = "M-20,0a20,20 0 1,0 40,0a20,20 0 1,0 -40,0",
						color = "red",
						transparency = 0.6
					},
					report = function() return 1 end
				}
			}
		end
		unitTest:assertError(error_func, mandatoryArgumentMsg("select"))

		error_func = function()
			Application{
				project = "arapiuns.tview",
				base = "roadmap",
				progress = false,
				output = arapiunsDir,
				villages = View{
					description = "Riverine settlements corresponded to Indian tribes, villages, and communities that are inserted into public lands.",
					select = "Nome",
					icon = {
						path = "M-20,0a20,20 0 1,0 40,0a20,20 0 1,0 -40,0",
						color = "red",
						transparency = 0.6
					},
					report = function() return 1 end
				}
			}
		end
		unitTest:assertError(error_func, "Argument report of View 'villages' must be a function that returns a Report, got number.")

		if arapiunsDir:exists() then arapiunsDir:delete() end

		error_func = function()
			Application{
				project = "arapiuns.tview",
				base = "roadmap",
				progress = false,
				output = arapiunsDir,
				villages = View{
					description = "Riverine settlements corresponded to Indian tribes, villages, and communities that are inserted into public lands.",
					icon = {
						path = "M-20,0a20,20 0 1,0 40,0a20,20 0 1,0 -40,0",
						color = "red",
						transparency = 0.6,
						time = 0
					}
				}
			}
		end
		unitTest:assertError(error_func, "Argument 'time' of icon must be a number greater than 0, got 0.")

		if arapiunsDir:exists() then arapiunsDir:delete() end

		error_func = function()
			Application{
				project = "emas.tview",
				base = "roadmap",
				progress = false,
				output = emasDir,
				limit = View{
					description = "abc.",
					icon = {path = "M-20,0a20,20 0 1,0 40,0a20,20 0 1,0 -40,0"}
				}
			}
		end
		unitTest:assertError(error_func, "Argument 'icon' of View must be used only with the following geometries: 'Point', 'MultiPoint', 'LineString' and 'MultiLineString'.")

		if emasDir:exists() then emasDir:delete() end

		error_func = function()
			Application{
				project = "arapiuns.tview",
				base = "roadmap",
				progress = false,
				output = arapiunsDir,
				trajectory = View{
					description = "Route on the Arapiuns River.",
					width = 3,
					border = "blue",
					icon = "home"
				}
			}
		end
		unitTest:assertError(error_func, incompatibleTypeMsg("icon", "table", "home"))

		error_func = function()
			Application{
				project = "arapiuns.tview",
				base = "roadmap",
				progress = false,
				output = arapiunsDir,
				villages = View{
					description = "Riverine settlements corresponded to Indian tribes, villages, and communities that are inserted into public lands.",
					select = "VOID",
					icon = {"home", "forest"}
				}
			}
		end
		unitTest:assertError(error_func, "Column 'VOID' does not exist in View 'villages'.")

		error_func = function()
			Application{
				project = "arapiuns.tview",
				base = "roadmap",
				progress = false,
				output = arapiunsDir,
				trajectory = View{
					select = "abc",
					description = "Riverine settlements corresponded to Indian tribes, villages, and communities that are inserted into public lands.",
					icon = {"home"}
				}
			}
		end
		unitTest:assertError(error_func, "All the elements of data.icon should be named.")

		error_func = function()
			Application{
				project = "arapiuns.tview",
				base = "roadmap",
				progress = false,
				output = arapiunsDir,
				villages = View{
					description = "Riverine settlements corresponded to Indian tribes, villages, and communities that are inserted into public lands.",
					select = "UC",
					icon = {"home", "fores"}
				}
			}
		end
		unitTest:assertError(error_func, "'fores' is an invalid value for argument 'icon'. Do you mean 'forest'?")

		error_func = function()
			Application{
				project = "arapiuns.tview",
				base = "roadmap",
				progress = false,
				output = arapiunsDir,
				villages = View{
					description = "Riverine settlements corresponded to Indian tribes, villages, and communities that are inserted into public lands.",
					select = "UC",
					icon = {"home", "fores" },
					label = {1, 2}
				}
			}
		end
		unitTest:assertError(error_func, incompatibleTypeMsg("label", "string", 1))

		if arapiunsDir:exists() then arapiunsDir:delete() end
		File("arapiuns.tview"):deleteIfExists()
		File("emas.tview"):deleteIfExists()

		local projRaster = File("raster.tview")
		projRaster:deleteIfExists()
		local proj = gis.Project{
			file = projRaster,
			clean = true,
			vegtype = filePath("vegtype_2000_5880.tif", "publish")
		}

		local vegDir = Directory("raster-with-no-srid")
		if vegDir:exists() then vegDir:delete() end
		error_func = function()
			Application {
				project = proj,
				description = "The data of this application were extracted from INLAND project (http://www.ccst.inpe.br/projetos/inland/).",
				output = vegDir,
				progress = false,
				title = "Vegetation scenario",
				vegtype = View {
					title = "Vegetation Type 2000",
					description = "Vegetation type Inland.",
					select = "value",
					color = {"red", "blue", "green", "yellow", "brown", "cyan", "orange"}
				}
			}
		end
		unitTest:assertError(error_func, "Argument 'select' for View 'vegtype' is not valid for raster data.")
		if vegDir:exists() then vegDir:delete() end
		projRaster:deleteIfExists()

		local caraguaDir = Directory("CaraguaWebMap")
		if caraguaDir:exists() then caraguaDir:delete() end
		error_func = function()
			Application {
				project = filePath("caragua.tview", "publish"),
				output = caraguaDir,
				progress = false,
				real = View{
					title = "Social Classes 2010 Real",
					description = "This is the main endogenous variable of the model. It was obtained from a classification that"
								.." categorizes the social conditions of households in Caraguatatuba on 'condition A' (best), 'B' or 'C''.",
					value = {1, 2, 3},
					color = {"red", "orange", "yellow"}
				}
			}
		end
		unitTest:assertError(error_func, mandatoryArgumentMsg("select"))
		if caraguaDir:exists() then caraguaDir:delete() end
	end
}
