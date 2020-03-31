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

-- @example Implementation of a simple Table Application using Brazil Conservation Unit.


import("publish")


Application{
	project = filePath("brazil.tview", "publish"),
	title = "Brazil Application",
	description = "Small application with some data related to Brazil.",
	template = {navbar = "darkblue", title = "white"},
	clean = false,

	biomes = View{
		select = "name",
		color = "Set2",
		description = "Brazilian Biomes, from IBGE.",
		download = true,
		report = function(cell)
		local mreport = Report{
				title = cell.name,
				author = "IBGE",
				print(cell.name, cell.link, cell.cover)
		}


           mreport:addImage(filePath("biomes/"..cell.name..".jpg", "publish"))
           mreport:addText("For more information, please visit "..link(cell.link, "here")..".")

           ------ Creat Table -----------
           local TABLE = {
					title = { "Data of "..cell.name},
					th = {
                         "Title Column01",
                         "Title Column02",
                         "Title Column03",
                         "Title Column04",
                         "Title Column05",
                     }, --end th
					td = {
                         {cell.name, cell.name, cell.name, cell.name, cell.name, },
                         {cell.name, cell.name, cell.name, cell.name, cell.name, },
                         {cell.name, cell.name, cell.name, cell.name, cell.name, },
                         {cell.name, cell.name, cell.name, cell.name, cell.name, },
                     } -- end td
                  } -- end table

            mreport:addTable(TABLE)
            ------ End Creat Table -----------

		   -- Creat mult datas in line
            mreport:addMult{ cell.name, cell.cover, cell.link}

            return mreport
		end
	},

}