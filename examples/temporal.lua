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

-- @example Implementation of a simple Application using Brazil Conservation Unit.

import("publish")

local gis = getPackage("gis")
local file = File("temporal.tview")
file:deleteIfExists()

local proj = gis.Project{
	title = "Testing temporal View",
	author = "Carneiro, H.",
	file = file,
	clean = true,
	uc_2001 = filePath("uc_federais_2001.shp", "publish"),
	uc_2009 = filePath("uc_federais_2009.shp", "publish"),
	uc_2016 = filePath("uc_federais_2016.shp", "publish")
}

Application{
	base = "roadmap",
	project = proj,
	uc = View{
		title = "UC",
		description = "UC Federais.",
		select = "anoCriacao",
		color = "Spectral",
		slices = 10,
		time = "snapshot"
	}
}

file:deleteIfExists()

