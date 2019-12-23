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
		local brazilDir = Directory("Application-alternative-app")
		if brazilDir:exists() then brazilDir:delete() end

		local data = {
			project = brazil,
			biomes = View{
				select = "name",
				value = {"Caatinga", "Cerrado", "Amazonia", "Pampa", "Mata Atlantica", "Pantanal"},
				color = {"brown", "purple", "green", "yellow", "blue", "orange"},
				description = "abc.",
			},
			progress = false,
			output = brazilDir,
			title = 1,
			base = "roadmap",
			zoom = 10,
			minZoom = 5,
			maxZoom = 17,
			center = {lat = -23.179017, long = -45.889188}
		}

		local error_func = function()
			Application(clone(data))
		end

		unitTest:assertError(error_func, incompatibleTypeMsg("title", "string", 1))
		data.title = "Testing Application Application"

		data.description = "Alternative Test"
		data.base = 1
		error_func = function()
			Application(clone(data))
		end

		unitTest:assertError(error_func, incompatibleTypeMsg("base", "string", 1))

		data.base = "normal"
		error_func = function()
			Application(clone(data))
		end

		unitTest:assertError(error_func, "Basemap 'normal' is not supported.")

		data.base = "hybrid"
		data.zoom = "1"
		error_func = function()
			Application(clone(data))
		end

		unitTest:assertError(error_func, incompatibleTypeMsg("zoom", "number", "1"))

		data.zoom = -1
		error_func = function()
			Application(clone(data))
		end

		unitTest:assertError(error_func, "Argument 'zoom' must be a number >= 0 and <= 20, got '-1'.")

		data.zoom = 21
		error_func = function()
			Application(clone(data))
		end

		unitTest:assertError(error_func, "Argument 'zoom' must be a number >= 0 and <= 20, got '21'.")

		data.zoom = 13
		data.minZoom = "1"
		error_func = function()
			Application(clone(data))
		end

		unitTest:assertError(error_func, incompatibleTypeMsg("minZoom", "number", "1"))

		data.minZoom = -1
		error_func = function()
			Application(clone(data))
		end

		unitTest:assertError(error_func, "Argument 'minZoom' must be a number >= 0 and <= 20, got '-1'.")

		data.minZoom = 21
		error_func = function()
			Application(clone(data))
		end

		unitTest:assertError(error_func, "Argument 'minZoom' must be a number >= 0 and <= 20, got '21'.")

		data.minZoom = 5
		data.maxZoom = 4
		error_func = function()
			Application(clone(data))
		end

		unitTest:assertError(error_func, "Argument 'minZoom' (5) should be less than 'maxZoom' (4).")

		data.maxZoom = "1"
		error_func = function()
			Application(clone(data))
		end

		unitTest:assertError(error_func, incompatibleTypeMsg("maxZoom", "number", "1"))

		data.maxZoom = -1
		error_func = function()
			Application(clone(data))
		end

		unitTest:assertError(error_func, "Argument 'maxZoom' must be a number >= 0 and <= 20, got '-1'.")

		data.maxZoom = 21
		error_func = function()
			Application(clone(data))
		end

		unitTest:assertError(error_func, "Argument 'maxZoom' must be a number >= 0 and <= 20, got '21'.")

		data.maxZoom = 19
		data.center = {-23.179017, -45.889188}
		error_func = function()
			Application(clone(data))
		end

		unitTest:assertError(error_func, "All elements of the argument must be named.")

		data.center = {lat = -23.179017, long = -45.889188, x = 2}
		local warning_func = function()
			Application(clone(data))
		end

		unitTest:assertWarning(warning_func, unnecessaryArgumentMsg("x"))

		data.center = {long = -45.889188}
		error_func = function()
			Application(clone(data))
		end

		unitTest:assertError(error_func, mandatoryArgumentMsg("lat"))

		data.center = {lat = -23.179017}
		error_func = function()
			Application(clone(data))
		end

		unitTest:assertError(error_func, mandatoryArgumentMsg("long"))

		data.center = {lat = -91, long = 91}
		error_func = function()
			Application(clone(data))
		end

		unitTest:assertError(error_func, "Center 'lat' must be a number >= -90 and <= 90, got '-91'.")

		data.center = {lat = 91, long = 91}
		error_func = function()
			Application(clone(data))
		end

		unitTest:assertError(error_func, "Center 'lat' must be a number >= -90 and <= 90, got '91'.")

		data.center = {lat = 90, long = -181}
		error_func = function()
			Application(clone(data))
		end

		unitTest:assertError(error_func, "Center 'long' must be a number >= -180 and <= 180, got '-181'.")

		data.center = {lat = 90, long = 181}
		error_func = function()
			Application(clone(data))
		end

		unitTest:assertError(error_func, "Center 'long' must be a number >= -180 and <= 180, got '181'.")

		data.center = {lat = 90, long = 180}
		data.template = 1
		error_func = function()
			Application(clone(data))
		end

		unitTest:assertError(error_func, incompatibleTypeMsg("template", "table", 1))

		data.template = {1, 2, 3}
		error_func = function()
			Application(clone(data))
		end

		unitTest:assertError(error_func, "All elements of the argument must be named.")

		data.template = {navbar = 1}
		error_func = function()
			Application(clone(data))
		end

		unitTest:assertError(error_func, "Incompatible types. Argument 'navbar' expected string or table, got number.")

		data.template = {navbar = "dodgerblue"}
		error_func = function()
			Application(clone(data))
		end

		unitTest:assertError(error_func, "Argument 'template' should contain the field 'title'.")

		data.template = {title = "dodgerblue"}
		error_func = function()
			Application(clone(data))
		end

		unitTest:assertError(error_func, "Argument 'template' should contain the field 'navbar'.")

		data.template = {navbar = "dodgerblue", title = 1}
		error_func = function()
			Application(clone(data))
		end

		unitTest:assertError(error_func, "Incompatible types. Argument 'title' expected string or table, got number.")

		data.template = {navbar = 1, title = "dodgerblue"}
		error_func = function()
			Application(clone(data))
		end

		unitTest:assertError(error_func, "Incompatible types. Argument 'navbar' expected string or table, got number.")

		data.template = {navbar = "#afafah", title = "dodgerblue"}
		error_func = function()
			Application(clone(data))
		end

		unitTest:assertError(error_func, "Argument 'navbar' (#afafah) is not a valid hex color. Please run 'terrame -package publish -showdoc' for more details.")

		data.template = {navbar = "dodgerblue", title = {256, 256, 256}}
		error_func = function()
			Application(clone(data))
		end

		unitTest:assertError(error_func, "Element '#1' in color '#1' must be an integer between 0 and 255, got 256.")

		data.template = nil
		data.fontSize = "a"
		error_func = function()
			Application(clone(data))
		end

		unitTest:assertError(error_func, incompatibleTypeMsg("fontSize", "number", "a"))

		data.fontSize = 0
		error_func = function()
			Application(clone(data))
		end

		unitTest:assertError(error_func, "Argument 'fontSize' must be a number greater than 0, got 0.")

		data.fontSize = -1
		error_func = function()
			Application(clone(data))
		end

		unitTest:assertError(error_func, "Argument 'fontSize' must be a number greater than 0, got -1.")

		data.fontSize = nil
		data.logo = 1
		error_func = function()
			Application(clone(data))
		end

		unitTest:assertError(error_func, incompatibleTypeMsg("logo", "string", 1))

		local logo = File("logo.png")
		data.logo = tostring(logo)
		error_func = function()
			Application(clone(data))
		end

		unitTest:assertError(error_func, "Logo '"..tostring(logo).."' does not exist.")

		logo = tostring(brazil)
		data.logo = tostring(logo)
		error_func = function()
			Application(clone(data))
		end

		unitTest:assertError(error_func, "'tview' is an invalid extension for argument 'logo'. Valid extensions ['bmp', 'gif', 'jpeg', 'jpg', 'png', 'svg'].")

		if brazilDir:exists() then brazilDir:delete() end

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

		warning_func = function()
			 Application {
				project = proj,
				output = municipalitiesir,
				progress = false,
				municipalities = View {
					description = "abc.",
					select = "pib",
					color = "Spectral",
					slices = 5,
					min = 17148
				}
			 }
		end
		unitTest:assertWarning(warning_func, "Value 17147 out of range [min: 17148] and will not be drawn.")
		if municipalitiesir:exists() then municipalitiesir:delete() end

		warning_func = function()
			 Application {
				project = proj,
				output = municipalitiesir,
				progress = false,
				municipalities = View {
					description = "abc.",
					select = "pib",
					color = "Spectral",
					slices = 5,
					max = 443600101
				}
			 }
		end
		unitTest:assertWarning(warning_func, "Value 443600102 out of range [max: 443600101] and will not be drawn.")
		if municipalitiesir:exists() then municipalitiesir:delete() end

		error_func = function()
			 Application {
				project = proj,
				output = municipalitiesir,
				progress = false,
				municipalities = View {
					description = "abc.",
					select = "uf",
					color = "Spectral",
					slices = 5
				}
			 }
		end
		unitTest:assertError(error_func, "Selected element should be number, got string in row 1.")

		if municipalitiesir:exists() then municipalitiesir:delete() end
		municipalitiesProj:deleteIfExists()
	end

}
