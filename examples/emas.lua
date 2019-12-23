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

-- @example Implementation of a simple Application using emas.
-- It uses the data from a tview file (terralib/emas.tview).
-- There is a layout with the web page properties.
-- Each polygon is drawn using the attribute 'select'.

import("publish")

Application{
	project = filePath("emas.tview", "publish"),
	description = "A small example related to a fire spread model.",
	order = {"cells", "river", "firebreak", "limit"},
	river = View{
		description = "Rivers.",
		color = "blue"
	},
	firebreak = View{
		description = "Fire breaks.",
		color = "black"
	},
	limit = View{
		description = "Bounding box of Emas National Park",
		border = "blue",
		color = "goldenrod",
		width = 2
	},
	cells = View{
		title = "Emas National Park",
		description = "Cellular layer",
		select = "river",
		color = {"gray", "blue"},
		width = 0,
		value = {0, 1},
		label = {"No", "Yes"},
		visible = false
	}
}

