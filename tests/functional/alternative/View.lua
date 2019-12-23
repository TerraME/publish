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
	View = function(unitTest)
		local error_func = function()
			View()
		end

		unitTest:assertError(error_func, tableArgumentMsg())

		error_func = function()
			View(1)
		end

		unitTest:assertError(error_func, namedArgumentsMsg())

		error_func = function()
			View{1, 2, 3}
		end

		unitTest:assertError(error_func, "All elements of the argument must be named.")

		local warning_func = function()
			View{description = "abc.", arg = "void"}
		end

		unitTest:assertWarning(warning_func, unnecessaryArgumentMsg("arg"))

		error_func = function()
			View{description = "abc.", title = 1}
		end

		unitTest:assertError(error_func, incompatibleTypeMsg("title", "string", 1))

		error_func = function()
			View{description = 1}
		end

		unitTest:assertError(error_func, incompatibleTypeMsg("description", "string", 1))

		error_func = function()
			View{description = "abc.", border = 1}
		end

		unitTest:assertError(error_func, incompatibleTypeMsg("border", "string or table", 1))

		error_func = function()
			View{description = "abc.", border = {}}
		end

		unitTest:assertError(error_func, "Argument 'border' must be a table with 3 or 4 arguments (red, green, blue and alpha), got 0.")

		error_func = function()
			View{description = "abc.", width = "mwidth"}
		end

		unitTest:assertError(error_func, incompatibleTypeMsg("width", "number", "mwidth"))

		warning_func = function()
			View{description = "abc.", width = 1}
		end

		unitTest:assertWarning(warning_func, defaultValueMsg("width", 1))

		error_func = function()
			View{description = "abc.", value = {0, 1, 2}, color = 1, select = "river"}
		end
		unitTest:assertError(error_func, incompatibleTypeMsg("color", "string or table", 1))

		error_func = function()
			View{description = "abc.", value = {0, 1, 2}, color = {}, select = "river"}
		end
		unitTest:assertError(error_func, "Argument 'color' must be a table with 3 or 4 arguments (red, green, blue and alpha), got 0.")

		error_func = function()
			View{description = "abc.", value = {0, 1, 2}, color = {"red", "orange", "yellow"}, select = "classe", label = {}}
		end
		unitTest:assertError(error_func, "Argument 'label' must be a table of strings with size greater than 0, got 0.")

		error_func = function()
			View{description = "abc.", value = {0, 1, 2}, color = {"red", "orange", "yellow"}, select = "classe", label = {1}}
		end
		unitTest:assertError(error_func, "The number of labels (1) must be equal to number of data classes (3).")

		error_func = function()
			View{description = "abc.", value = {0, 1, 2}, color = {"red", "orange", "yellow"}, select = "classe", label = {"Condition C", true, 2}}
		end

		unitTest:assertError(error_func, "Argument 'label' must be a table of strings, element 2 (true) got boolean.")

		error_func = function()
			View{description = "abc.", value = {0, 1, 2}, color = "mcolor", select = "river"}
		end

		unitTest:assertError(error_func, "Argument 'color' (mcolor) does not exist in ColorBrewer. Please run 'terrame -package publish -showdoc' for more details.")

		error_func = function()
			View{description = "abc.", visible = 1}
		end

		unitTest:assertError(error_func, incompatibleTypeMsg("visible", "boolean", 1))

		warning_func = function()
			View{description = "abc.", visible = true}
		end

		unitTest:assertWarning(warning_func, defaultValueMsg("visible", true))

		error_func = function()
			View{description = "abc.", select = 1}
		end

		unitTest:assertError(error_func, incompatibleTypeMsg("select", "string or table", 1))

		error_func = function()
			View{description = "abc.", value = "mvalue", select = "river"}
		end

		unitTest:assertError(error_func, incompatibleTypeMsg("value", "table", "mvalue"))

		error_func = function()
			View{description = "abc.", report = "myreport"}
		end
		unitTest:assertError(error_func, incompatibleTypeMsg("report", "Report or function", "myreport"))

		error_func = function()
			View{description = "abc.", border = "PuBu"}
		end
		unitTest:assertError(error_func, "Argument 'border' (PuBu) is not a valid color name. Please run 'terrame -package publish -showdoc' for more details.")

		error_func = function()
			View{description = "abc.", color = "red", value = {}, select = "river"}
		end
		unitTest:assertError(error_func, "Argument 'value' must be a table with size greater than 0, got 0.")

		error_func = function()
			View{description = "abc.", color = {"#afafah", "#afafah", "#afafah"}, value = {1, 2, 3}, select = "river"}
		end
		unitTest:assertError(error_func, "Argument 'color' (#afafah) is not a valid hex color. Please run 'terrame -package publish -showdoc' for more details.")

		error_func = function()
			View{description = "abc.", color = "Redss", value = {1, 2, 3}, select = "river"}
		end
		unitTest:assertError(error_func, "Argument 'color' (Redss) does not exist in ColorBrewer. Please run 'terrame -package publish -showdoc' for more details.")

		error_func = function()
			View{description = "abc.", color = {"Reds", "Blues", "PuRd"}, value = {1, 2, 3}, select = "river"}
		end
		unitTest:assertError(error_func, "Argument 'color' (Reds) is not a valid color name. Please run 'terrame -package publish -showdoc' for more details.")

		error_func = function()
			View{description = "abc.", color = {"Reds", "Blues", "PuRd"}}
		end
		unitTest:assertError(error_func, "ColorBrewer 'Reds' is not allowed to be used in a table of colors.")

		error_func = function()
			View{description = "abc.", color = {"red", "green", 1}}
		end
		unitTest:assertError(error_func, "Incompatible types. Argument 'color[3]' expected string or table, got number.")

		error_func = function()
			View{description = "abc.", color = {true, true, true}, value = {1, 2, 3}, select = "river"}
		end
		unitTest:assertError(error_func, "Argument 'color' has an invalid description for color in position '#1'. It should be a string, number or table, got boolean.")

		error_func = function()
			View{description = "abc.", color = {{-1, 1, 1}, {256, 255, 255}, {1, 1, 1, 2}}, value = {1, 2, 3}, select = "river"}
		end
		unitTest:assertError(error_func, "Element '#1' in color '#1' must be an integer between 0 and 255, got -1.")

		error_func = function()
			View{description = "abc.", color = {{0, 0, 0}, {1, 1, 1}, {255, 255, 255, 2}}, value = {1, 2, 3}, select = "river"}
		end
		unitTest:assertError(error_func, "The alpha parameter of color '#3' should be a number between 0.0 (fully transparent) and 1.0 (fully opaque), got 2.")

		error_func = function()
			View{description = "abc.", color = {{0, 0, 0, 0.5}, {1, 1, 1, 1}, {255, 255, 255, 1.00001}}, value = {1, 2, 3}, select = "river"}
		end

		unitTest:assertError(error_func, "The alpha parameter of color '#3' should be a number between 0.0 (fully transparent) and 1.0 (fully opaque), got 1.00001.")

		error_func = function()
			View{description = "abc.", color = {"red", "blue"}, value = {1}, select = "river"}
		end

		unitTest:assertError(error_func, "The number of colors (2) must be equal to number of data classes (1).")

		error_func = function()
			View{description = "abc.", color = "red", transparency = "a"}
		end

		unitTest:assertError(error_func, incompatibleTypeMsg("transparency", "number", "a"))

		warning_func = function()
			View{description = "abc.", color = "red", transparency = 0}
		end

		unitTest:assertWarning(warning_func, defaultValueMsg("transparency", 0))

		error_func = function()
			View{description = "abc.", color = "red", transparency = -1}
		end

		unitTest:assertError(error_func, "Argument 'transparency' should be a number between 0.0 (fully opaque) and 1.0 (fully transparent), got -1.")

		error_func = function()
			View{description = "abc.", color = "red", transparency = 1.1}
		end

		unitTest:assertError(error_func, "Argument 'transparency' should be a number between 0.0 (fully opaque) and 1.0 (fully transparent), got 1.1.")

		error_func = function()
			View{description = "abc.", icon = 1}
		end
		unitTest:assertError(error_func, incompatibleTypeMsg("icon", "string or table", 1))

		error_func = function()
			View{description = "abc.", icon = {path = "K7Y"}}
		end
		unitTest:assertError(error_func, "The icon path 'K7Y' contains no valid commands. The following commands are available for path: M, L, H, V, C, S, Q, T, A, Z")

		error_func = function()
			View{
				description = "abc.",
				icon = {
					path = "M-20,0a20,20 0 1,0 40,0a20,20 0 1,0 -40,0",
					color = 1
				}
			}
		end
		unitTest:assertError(error_func, incompatibleTypeMsg("color", "string", 1))

		error_func = function()
			View{
				description = "abc.",
				icon = {
					path = "M-20,0a20,20 0 1,0 40,0a20,20 0 1,0 -40,0",
					transparency = "a"
				}
			}
		end
		unitTest:assertError(error_func, incompatibleTypeMsg("transparency", "number", "a"))

		error_func = function()
			View{
				description = "abc.",
				icon = {
					path = "M-20,0a20,20 0 1,0 40,0a20,20 0 1,0 -40,0",
					transparency = 2
				}
			}
		end
		unitTest:assertError(error_func, "The icon transparency is a number between 0.0 (fully opaque) and 1.0 (fully transparent), got 2.")

		error_func = function()
			View{
				description = "abc.",
				icon = {
					path = "M-20,0a20,20 0 1,0 40,0a20,20 0 1,0 -40,0",
					time = "a"
				}
			}
		end
		unitTest:assertError(error_func, incompatibleTypeMsg("time", "number", "a"))

		error_func = function()
			View{
				description = "abc.",
				icon = {
					path = "M-20,0a20,20 0 1,0 40,0a20,20 0 1,0 -40,0",
					time = 0
				}
			}
		end
		unitTest:assertError(error_func, "Argument 'time' of icon must be a number greater than 0, got 0.")

		error_func = function()
			View{
				description = "abc.",
				icon = {
					path = "M-20,0a20,20 0 1,0 40,0a20,20 0 1,0 -40,0",
					time = -1
				}
			}
		end

		unitTest:assertError(error_func, "Argument 'time' of icon must be a number greater than 0, got -1.")

		warning_func = function()
			View{
				description = "abc.",
				icon = {
					path = "M-20,0a20,20 0 1,0 40,0a20,20 0 1,0 -40,0",
					time = 5
				}
			}
		end

		unitTest:assertWarning(warning_func, defaultValueMsg("time", 5))

		error_func = function()
			View{description = "abc", report = function() end}
		end

		unitTest:assertError(error_func, mandatoryArgumentMsg("select"))

		warning_func = function()
			View{
				description = "abc.",
				icon = {
					path = "M-20,0a20,20 0 1,0 40,0a20,20 0 1,0 -40,0",
					transparency = 0
				}
			}
		end

		unitTest:assertWarning(warning_func, defaultValueMsg("transparency", 0))

		warning_func = function()
			View{
				description = "abc.",
				icon = {
					path = "M-20,0a20,20 0 1,0 40,0a20,20 0 1,0 -40,0",
					color = "black"
				}
			}
		end

		unitTest:assertWarning(warning_func, defaultValueMsg("color", "black"))

		error_func = function()
			View{
				description = "abc.",
				icon = {path = "1234"}
			}
		end

		unitTest:assertError(error_func, "The icon path '1234' contains no valid commands. The following commands are available for path: M, L, H, V, C, S, Q, T, A, Z")

		error_func = function()
			View{description = "abc.", download = 1}
		end
		unitTest:assertError(error_func, incompatibleTypeMsg("download", "boolean", 1))

		warning_func = function()
			View{description = "abc.", download = false}
		end

		unitTest:assertWarning(warning_func, defaultValueMsg("download", false))

		error_func = function()
			View{
				description = "abc.",
				icon = {"forest"}
			}
		end

		unitTest:assertError(error_func, mandatoryArgumentMsg("select"))

		warning_func = function()
			View{
				description = "abc.",
				select = "UC",
				icon = {"forest"},
				border = "red"
			}
		end

		unitTest:assertWarning(warning_func, unnecessaryArgumentMsg("border"))

		error_func = function()
			View{
				description = "abc.",
				select = "UC",
				icon = {"forest"},
				label = {"Absence of Conservation Unit", "Presence of Conservation Unit"}
			}
		end

		unitTest:assertError(error_func, "The number of icons (1) must be equal to number of labels (2).")

		warning_func = function()
			View{
				description = "abc.",
				select = "UC",
				icon = {"forest"},
				color = "PuBu"
			}
		end

		unitTest:assertWarning(warning_func, unnecessaryArgumentMsg("icon"))

		error_func = function()
			View{
				description = "abc.",
				decimal = "a"
			}
		end
		unitTest:assertError(error_func, incompatibleTypeMsg("decimal", "number", "a"))

		error_func = function()
			View{
				description = "abc.",
				decimal = -3
			}
		end
		unitTest:assertError(error_func, "Argument 'decimal' should be an integer greater than 0, got -3.")

		error_func = function()
			View{
				description = "abc.",
				select = {"Nome"},
				icon = {"home", "forest"},
				report = function(cell)
					local mreport = Report{title = cell.Nome}
					mreport:addImage(packageInfo("publish").data.."arapiuns/"..cell.Nome..".jpg")
					return mreport
				end
			}
		end
		unitTest:assertError(error_func, "Argument 'select' must be a table with size equals to 2, got 1.")

		error_func = function()
			View{
				description = "abc.",
				select = {"Nome"},
				color = {"red", "blue"},
				report = function(cell)
					local mreport = Report{title = cell.Nome}
					mreport:addImage(packageInfo("publish").data.."arapiuns/"..cell.Nome..".jpg")
					return mreport
				end
			}
		end
		unitTest:assertError(error_func, "Argument 'select' must be a table with size equals to 2, got 1.")

		error_func = function()
			View{
				description = "abc.",
				slices = "a",
				color = "Spectral"
			}
		end
		unitTest:assertError(error_func, incompatibleTypeMsg("slices", "number", "a"))

		error_func = function()
			View{
				description = "abc.",
				slices = 5,
				min = "a",
				color = "Spectral"
			}
		end
		unitTest:assertError(error_func, incompatibleTypeMsg("min", "number", "a"))

		error_func = function()
			View{
				description = "abc.",
				slices = 5,
				max = "a",
				color = "Spectral"
			}
		end
		unitTest:assertError(error_func, incompatibleTypeMsg("max", "number", "a"))

		error_func = function()
			View{
				description = "abc.",
				min = 1
			}
		end
		unitTest:assertError(error_func, mandatoryArgumentMsg("slices"))

		error_func = function()
			View{
				description = "abc.",
				max = 1
			}
		end
		unitTest:assertError(error_func, mandatoryArgumentMsg("slices"))

		error_func = function()
			View{
				description = "abc.",
				slices = 5,
				min = 2,
				max = 1,
				color = "Spectral"
			}
		end
		unitTest:assertError(error_func, "Argument 'min' (2) should be less than 'max' (1).")

		error_func = function()
			View{
				description = "abc.",
				slices = 1,
				color = "Spectral"
			}
		end
		unitTest:assertError(error_func, "Argument 'slices' (1) should be greater than one.")

		error_func = function()
			View{
				description = "abc.",
				slices = -2,
				color = "Spectral"
			}
		end
		unitTest:assertError(error_func, positiveArgumentMsg("slices", -2))

		error_func = function()
			View{
				description = "abc.",
				slices = 2.1,
				color = "Spectral"
			}
		end
		unitTest:assertError(error_func, integerArgumentMsg("slices", 2.1))

		error_func = function()
			View{
				description = "abc.",
				time = "creation"
			}
		end
		unitTest:assertError(error_func, mandatoryArgumentMsg("name"))

		error_func = function()
			View{
				description = "abc.",
				name = "anoCriacao"
			}
		end
		unitTest:assertError(error_func, mandatoryArgumentMsg("time"))

		error_func = function()
			View{
				description = "abc.",
				name = "anoCriacao",
				time = 1
			}
		end
		unitTest:assertError(error_func, incompatibleTypeMsg("time", "string", 1))

		error_func = function()
			View{
				description = "abc.",
				name = 1,
				time = "snapshot"
			}
		end
		unitTest:assertError(error_func, incompatibleTypeMsg("name", "string", 1))

		error_func = function()
			View{
				description = "abc.",
				name = "anoCriacao",
				time = "snapshot"
			}
		end
		unitTest:assertError(error_func, "Argument 'name' is valid only when time is equals to 'creation', got 'snapshot'.")

		error_func = function()
			View{
				description = "abc.",
				time = "a"
			}
		end
		unitTest:assertError(error_func, "Argument 'time' must be 'snapshot' or 'creation', got 'a'.")

		error_func = function()
			View{
				description = "abc.",
				time = "snapshot",
				select = "a",
				report = function() end
			}
		end
		unitTest:assertError(error_func, "Argument 'report' is invalid in temporal views.")
	end
}
