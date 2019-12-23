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
		local classes = List{
			real = View{
				title = "Social Classes 2010",
				description = "This is the main endogenous variable of the model. It was obtained from a classification that "
						.."categorizes the social conditions of households in Caraguatatuba on 'condition A' (best), 'B' or 'C''.",
				width = 0,
				select = "classe",
				color = {"red", "orange", "yellow"},
				label = {"Condition C", "Condition B", "Condition A"}
			},
			baseline = View{
				title = "Social Classes 2025",
				description = "The base scenario considers the zoning proposed by the new master plan of Caraguatatuba.",
				width = 0,
				select = "classe",
				color = {"red", "orange", "yellow"},
				label = {"Condition C", "Condition B", "Condition A"}
			}
		}

		unitTest:assertType(classes, "List")
		unitTest:assertType(classes.views, "table")
		unitTest:assertType(classes.size, "number")
		unitTest:assertEquals(#classes, 2)

		local view = classes.views.real
		unitTest:assertType(view, "View")
		unitTest:assertEquals(view.title, "Social Classes 2010")

		view = classes.views.baseline
		unitTest:assertType(view, "View")
		unitTest:assertEquals(view.title, "Social Classes 2025")
	end,
	__len = function(unitTest)
		local list = List{
			use = View{
				title = "Occupational Classes 2010",
				description = "The occupational class describes the percentage of houses and apartments inside such areas that "
						.."have occasional use. The dwelling is typically used in summer vacations and holidays.",
				width = 0,
				select = "uso",
				color = "RdPu"
			}
		}

		unitTest:assertType(list, "List")
		unitTest:assertType(list.views, "table")
		unitTest:assertType(list.size, "number")
		unitTest:assertEquals(#list, 1)

		list = List{
			limit = View{
				description = "Bounding box of Caraguatatuba.",
				color = "goldenrod"
			},
			regions = View{
				description = "Regions of Caraguatatuba.",
				select = "name",
				color = "Set2"
			}
		}

		unitTest:assertType(list, "List")
		unitTest:assertType(list.views, "table")
		unitTest:assertType(list.size, "number")
		unitTest:assertEquals(#list, 2)
	end,
	__tostring = function(unitTest)
		local list = List{
			limit = View{
				description = "Bounding box of Caraguatatuba.",
				color = "goldenrod"
			},
			regions = View{
				description = "Regions of Caraguatatuba.",
				select = "name",
				color = "Set2"
			}
		}

		unitTest:assertType(list, "List")
		unitTest:assertType(list.views, "table")
		unitTest:assertType(list.size, "number")
		unitTest:assertEquals(#list, 2)
		unitTest:assertEquals(tostring(list), [[size   number [2]
views  named table of size 2
]])
	end
}
