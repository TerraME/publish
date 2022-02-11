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

-- @example Implementation of a simple Application with a video player.

import("publish")

Application{
    	key = "AIzaSyA1coAth-Bo7m99rnxOm2oOBB88AmaSbOk", 
	project = filePath("brazil.tview", "publish"),
	title = "Brazil Application",
	description = "Small application with a video player",
	output	= "videoWebMap",


	biomes = View{
		select = "name",
		value = {"Caatinga", "Cerrado", "Amazonia", "Pampa", "Mata Atlantica", "Pantanal"},
		color = {"brown", "purple", "green", "yellow", "blue", "orange"},
		description = "Brazilian Biomes, from IBGE.",
		report = function(cell)
			local mreport = Report{
				title = cell.name,
				author = "IBGE"
			}

			mreport:addText(cell.name.." covers approximately "..cell.cover.."% of Brazil.")
			mreport:addImage(filePath("biomes/"..cell.name..".jpg", "publish"))
			mreport:addText("For more information, please visit "..link(cell.link, "here")..".")

			mreport:addVideo{
			   width = 500,
			   heigh = 315,
			   url = "https://www.youtube.com/embed/q0_XODQ0GGg",
			}

			return mreport
		end
	},

}

