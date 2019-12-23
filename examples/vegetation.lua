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

-- @example Implementation of a simple Application from INLAND model for Brazil.

import("publish")
import("gis")

proj = Project{
	file = "vegetation.tview",
	clean = true,
	vegtype = filePath("vegtype_2000_5880.tif", "publish")
}

app = Application {
	project = proj,
	description = "The data of this application were extracted from INLAND project (http://www.ccst.inpe.br/projetos/inland/).",
	title = "Vegetation scenario",
	vegtype = View {
		title = "Vegetation Type 2000",
		description = "Vegetation type Inland.",
		value = {-127, 1, 2, 3, 9, 10, 12},
		color = {"red", "blue", "green", "yellow", "brown", "cyan", "orange"}
	}
}

File("vegetation.tview"):delete()

