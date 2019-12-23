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
		local mcolor = color{color = "aqua"}
		unitTest:assertType(mcolor, "string")
		unitTest:assertEquals(mcolor, "rgba(0, 255, 255, 1)")

		mcolor = color{color = {10, 10 , 10}}
		unitTest:assertType(mcolor, "string")
		unitTest:assertEquals(mcolor, "rgba(10, 10, 10, 1)")

		mcolor = color{color = {{255, 255, 255}}}
		unitTest:assertType(mcolor, "table")
		unitTest:assertType(mcolor[1], "string")
		unitTest:assertEquals(mcolor[1], "rgba(255, 255, 255, 1)")

		mcolor = color{color = {{10, 10, 10}, {11, 11, 11}, {12, 12, 12, 0.5}}}
		unitTest:assertType(mcolor, "table")
		unitTest:assertType(mcolor[1], "string")
		unitTest:assertType(mcolor[2], "string")
		unitTest:assertType(mcolor[3], "string")
		unitTest:assertEquals(mcolor[1], "rgba(10, 10, 10, 1)")
		unitTest:assertEquals(mcolor[2], "rgba(11, 11, 11, 1)")
		unitTest:assertEquals(mcolor[3], "rgba(12, 12, 12, 0.5)")

		mcolor = color{color = {"red", "green", "yellow"}}
		unitTest:assertType(mcolor, "table")
		unitTest:assertType(mcolor[1], "string")
		unitTest:assertType(mcolor[2], "string")
		unitTest:assertType(mcolor[3], "string")
		unitTest:assertEquals(mcolor[1], "rgba(255, 0, 0, 1)")
		unitTest:assertEquals(mcolor[2], "rgba(0, 128, 0, 1)")
		unitTest:assertEquals(mcolor[3], "rgba(255, 255, 0, 1)")

		mcolor = color{color = {"#798174", "#261305", "#7c4c24"}}
		unitTest:assertType(mcolor, "table")
		unitTest:assertType(mcolor[1], "string")
		unitTest:assertType(mcolor[2], "string")
		unitTest:assertType(mcolor[3], "string")
		unitTest:assertEquals(mcolor[1], "#798174")
		unitTest:assertEquals(mcolor[2], "#261305")
		unitTest:assertEquals(mcolor[3], "#7c4c24")

		mcolor = color{color = "Reds", classes = 2}
		unitTest:assertType(mcolor, "table")
		unitTest:assertType(mcolor[1], "string")
		unitTest:assertType(mcolor[2], "string")
		unitTest:assertEquals(mcolor[1], "rgba(254, 224, 210, 1)")
		unitTest:assertEquals(mcolor[2], "rgba(222, 45, 38, 1)")

		mcolor = color{color = "aqua", alpha = 0.25}
		unitTest:assertEquals(mcolor, "rgba(0, 255, 255, 0.25)")

		mcolor = color{color = {10, 10 , 10}, alpha = 0.2}
		unitTest:assertEquals(mcolor, "rgba(10, 10, 10, 0.2)")

		mcolor = color{color = {{10, 10, 10}, {11, 11, 11}, {12, 12, 12, 0.5}}, alpha = 0.6}
		unitTest:assertEquals(mcolor[1], "rgba(10, 10, 10, 0.6)")
		unitTest:assertEquals(mcolor[2], "rgba(11, 11, 11, 0.6)")
		unitTest:assertEquals(mcolor[3], "rgba(12, 12, 12, 0.6)")

		mcolor = color{color = {"red", "green", "yellow"}, alpha = 0.3}
		unitTest:assertEquals(mcolor[1], "rgba(255, 0, 0, 0.3)")
		unitTest:assertEquals(mcolor[2], "rgba(0, 128, 0, 0.3)")
		unitTest:assertEquals(mcolor[3], "rgba(255, 255, 0, 0.3)")

		mcolor = color{color = {"#798174", "#261305", "#7c4c24"}, alpha = 0.1}
		unitTest:assertEquals(mcolor[1], "#798174")
		unitTest:assertEquals(mcolor[2], "#261305")
		unitTest:assertEquals(mcolor[3], "#7c4c24")

		mcolor = color{color = "Reds", classes = 2, alpha = 0.9}
		unitTest:assertEquals(mcolor[1], "rgba(254, 224, 210, 0.9)")
		unitTest:assertEquals(mcolor[2], "rgba(222, 45, 38, 0.9)")
	end
}

