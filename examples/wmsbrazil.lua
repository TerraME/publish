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

-- @example Implementation of a simple Application using Brazil data
-- from a WMS.

import("gis")
import("publish")

proj = Project {
	title = "WMS",
	file = "wms.tview",
	clean = true
}

Layer {
	project = proj,
	source = "wms",
	name = "wmsLayer",
	service = "http://www.geoservicos.inde.gov.br:80/geoserver/ows",
	map = "MPOG:BASE_SPI_pol"
}

Application {
	project = proj,
	base = "terrain",
	wmsLayer = View {
		title = "WMS",
		description = "Municipality data from a WMS.",
		transparency = 0.5,
		color = { "#F4C87F", "#CB8969", "#885944"},
		label = { "Class 1", "Class 2", "Class 3"},
	}
}

File("wms.tview"):delete()
