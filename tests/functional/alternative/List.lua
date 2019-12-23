-------------------------------------------------------------------------------------------
-- TerraME - a software platform for multiple scale spatially-explicit dynamic modeling.
-- Copyright (C) 2001-2017 INPE and TerraLAB/UFOP -- www.terrame.org

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
	List = function(unitTest)
		local error_func = function()
			List()
		end
		unitTest:assertError(error_func, mandatoryArgumentMsg(1))

		error_func = function()
			List(1)
		end
		unitTest:assertError(error_func, incompatibleTypeMsg(1, "table", 1))

		error_func = function()
			List{}
		end
		unitTest:assertError(error_func, "List is empty. A List must be initialized with Views elements.")

		error_func = function()
			List{1, 2, 3}
		end
		unitTest:assertError(error_func, "All elements of the argument must be named.")

		error_func = function()
			List{arg = "void"}
		end
		unitTest:assertError(error_func, incompatibleTypeMsg("arg", "View", "void"))
	end
}
