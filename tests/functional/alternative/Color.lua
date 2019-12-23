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
	color = function(unitTest)
		local error_func = function()
			color()
		end
		unitTest:assertError(error_func, tableArgumentMsg())

		error_func = function()
			color{}
		end
		unitTest:assertError(error_func, mandatoryArgumentMsg("arg"))

		error_func = function()
			color{classes = 1}
		end
		unitTest:assertError(error_func, mandatoryArgumentMsg("arg"))

		error_func = function()
			color{color = 1}
		end
		unitTest:assertError(error_func, incompatibleTypeMsg("color", "string or table", 1))

		error_func = function()
			color{arg = 1}
		end
		unitTest:assertError(error_func, incompatibleTypeMsg("arg", "string or table", 1))

		error_func = function()
			color{color = "Reds", classes = 1}
		end
		unitTest:assertError(error_func, "The number of data classes must be >= 2 and <= 20, got 1.")

		error_func = function()
			color{color = "Reds", classes = 21}
		end
		unitTest:assertError(error_func, "The number of data classes must be >= 2 and <= 20, got 21.")

		error_func = function()
			color{color = "Reds", classes = 2.5}
		end
		unitTest:assertError(error_func, "The number of data classes must be an integer, got 2.5.")

		error_func = function()
			color{color = "123456"}
		end
		unitTest:assertError(error_func, "Argument 'color' (123456) is not a valid color name. Please run 'terrame -package publish -showdoc' for more details.")

		error_func = function()
			color{color = "#afafah"}
		end
		unitTest:assertError(error_func, "Argument 'color' (#afafah) is not a valid hex color. Please run 'terrame -package publish -showdoc' for more details.")

		error_func = function()
			color{color = "#123abce"}
		end
		unitTest:assertError(error_func,"Argument 'color' (#123abce) is not a valid hex color. Please run 'terrame -package publish -showdoc' for more details.")

		error_func = function()
			color{color = "aFaE3f"}
		end
		unitTest:assertError(error_func, "Argument 'color' (aFaE3f) is not a valid color name. Please run 'terrame -package publish -showdoc' for more details.")

		error_func = function()
			color{color = "F00"}
		end
		unitTest:assertError(error_func, "Argument 'color' (F00) is not a valid color name. Please run 'terrame -package publish -showdoc' for more details.")

		error_func = function()
			color{color = "#afaf"}
		end
		unitTest:assertError(error_func, "Argument 'color' (#afaf) is not a valid hex color. Please run 'terrame -package publish -showdoc' for more details.")

		error_func = function()
			color{color = "#F0h"}
		end
		unitTest:assertError(error_func, "Argument 'color' (#F0h) is not a valid hex color. Please run 'terrame -package publish -showdoc' for more details.")

		error_func = function()
			color{color = "Redss"}
		end
		unitTest:assertError(error_func, "Argument 'color' (Redss) is not a valid color name. Please run 'terrame -package publish -showdoc' for more details.")

		error_func = function()
			color{color = "Dark", classes = 10}
		end
		unitTest:assertError(error_func, "Argument 'color' (Dark) does not exist in ColorBrewer with (10) data classes.")

		error_func = function()
			color{color = "Dark"}
		end
		unitTest:assertError(error_func, "Argument 'color' (Dark) is not a valid color name. Please run 'terrame -package publish -showdoc' for more details.")

		error_func = function()
			color{color = {1.5, 1, 1}}
		end
		unitTest:assertError(error_func, "Element '#1' in color '#1' must be an integer, got 1.5.")

		error_func = function()
			color{color = {-1, 1, 1}}
		end
		unitTest:assertError(error_func, "Element '#1' in color '#1' must be an integer between 0 and 255, got -1.")

		error_func = function()
			color{color = {256, 255, 255}}
		end
		unitTest:assertError(error_func, "Element '#1' in color '#1' must be an integer between 0 and 255, got 256.")

		error_func = function()
			color{color = {1, 1, 1, 2}}
		end
		unitTest:assertError(error_func, "The alpha parameter of color '#1' should be a number between 0.0 (fully transparent) and 1.0 (fully opaque), got 2.")

		error_func = function()
			color{color = {1, 1, 1, 1, 1, 1}}
		end
		unitTest:assertError(error_func, "Argument 'color' (1) must be a table with 3 or 4 arguments (red, green, blue and alpha), got 6.")

		local warning_func = function()
			color{color = {10, 10, 10}, classes = 3}
		end
		unitTest:assertWarning(warning_func, unnecessaryArgumentMsg("classes"))

		error_func = function()
			color{color = {true, true, true}}
		end
		unitTest:assertError(error_func, "Argument 'color' has an invalid description for color in position '#1'. It should be a string, number or table, got boolean.")

		error_func = function()
			color{color = {"aqua", {10, 10, 10}, "#798174"}}
		end
		unitTest:assertError(error_func, "All elements of argument 'color' must have the same type, got at least 2 different types.")

		error_func = function()
			color{color = {}}
		end
		unitTest:assertError(error_func, "Argument 'color' must be a table with 3 or 4 arguments (red, green, blue and alpha), got 0.")
	end
}

