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

-- @example Implementation of a Application using Sao Paulo municipalities.
-- The data of this application were extracted from IBGE(2010).

import("publish")

Application {
	project = filePath("sp.tview", "publish"),
	base = "roadmap",
	municipalities = View {
		title = "GDP",
		description = "Gross Domestic Product (GDP) of Sao Paulo, Brazil.",
		select = "pib",
		color = "Spectral",
		label = {"1: 17147-8345791", "2: 8345791-12510113", "3: 12510113-4181469", "4: 4181469-16674435", "5: >=16674435"},
		slices = 5
	}
}
