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
	project = filePath("temporal-data.tview", "publish"),
	--project = filePath("brazil.tview", "publish"),
	title = "Brazil Application",
	description = "Small application with some data related to Brazil.",
	template = {navbar = "darkblue", title = "white"},
	clean = false,
	output	= "simple-tableWebMap",


	data = View{
		color = "RdYlGn",
		select  = "id_1",
		description = "Dados de teste",
		report = function(cell)
			local report = Report{
				title = cell.id_1,
				print(cell.id_1),
			}

			------ Text block ---------
			report:addHeading("First Table application")

			------ Creat Table -----------
			local Table = {
				title = "Table of "..cell.id_1,
				columns = {
						"area01",
						"area02",
						"area03",
						"area04",
						"area05",
						"area06",
						"area07",
						"area08",
						"area09",
						"area10",
					}, --end columns
				values = {
						{
						cell.dg_darea06,
						cell.dg_darea07,
						cell.dg_darea08,
						cell.dg_darea09,
						cell.dg_darea10,
						cell.dg_darea11,
						cell.dg_darea12,
						cell.dg_darea13,
						cell.dg_darea14,
						cell.dg_darea15,
						},

						{
						cell.d_area02,
						cell.d_area03,
						cell.d_area04,
						cell.d_area05,
						cell.d_area06,
						cell.d_area07,
						cell.d_area08,
						cell.d_area09,
						cell.d_area10,
						cell.d_area11,
						},

						{
						cell.mcwd06,
						cell.mcwd07,
						cell.mcwd08,
						cell.mcwd09,
						cell.mcwd10,
						cell.mcwd11,
						cell.mcwd12,
						cell.mcwd13,
						cell.mcwd14,
						cell.mcwd15,
						},

					} -- end values
				} -- end table
			report:addMatrix(Table)

			return report
		end
	},

}