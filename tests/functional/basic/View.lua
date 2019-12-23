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
	loadColors = function(unitTest)
		unitTest:assert(true)
	end,
	View = function(unitTest)
		local view = View{
			title = "Emas National Park",
			description = "A small example related to a fire spread model.",
			border = "blue",
			width = 2,
			color = "PuBu",
			select = "river",
			value = {0, 1, 2}
		}

		unitTest:assertType(view, "View")
		unitTest:assertEquals(view.title, "Emas National Park")
		unitTest:assertEquals(view.description, "A small example related to a fire spread model.")
		unitTest:assertEquals(view.width, 2)
		unitTest:assert(view.visible)
		unitTest:assertEquals(view.select, "river")
		unitTest:assertEquals(view.border, "rgba(0, 0, 255, 1)")

		unitTest:assertEquals(view.value[1], 0)
		unitTest:assertEquals(view.value[2], 1)
		unitTest:assertEquals(view.value[3], 2)

		unitTest:assertType(view.color, "table")
		unitTest:assertEquals(getn(view.color), 3)
		unitTest:assertEquals(view.transparency, 0)
		unitTest:assertEquals(view.color[tostring(view.value[1])], "rgba(236, 231, 242, 1)")
		unitTest:assertEquals(view.color[tostring(view.value[2])], "rgba(166, 189, 219, 1)")
		unitTest:assertEquals(view.color[tostring(view.value[3])], "rgba(43, 140, 190, 1)")

		view = View{
			title = "Emas National Park",
			description = "A small example related to a fire spread model.",
			border = "red",
			width = 2,
			color = "blue",
			transparency = 0.7,
			visible = false,
			select = "river"
		}

		unitTest:assertType(view, "View")
		unitTest:assertEquals(view.title, "Emas National Park")
		unitTest:assertEquals(view.description, "A small example related to a fire spread model.")
		unitTest:assertEquals(view.width, 2)
		unitTest:assert(not view.visible)
		unitTest:assertEquals(view.select, "river")
		unitTest:assertEquals(view.transparency, 0.7)
		unitTest:assertEquals(view.border, "rgba(255, 0, 0, 1)")
		unitTest:assertEquals(view.color, "rgba(0, 0, 255, 0.3)")

		view = View{
			color = "blue",
			description = "abc.",
			layer = tostring(filePath("emas-limit.shp", "gis")),
			transparency = 0.95,
		}

		unitTest:assertType(view, "View")
		unitTest:assertEquals(view.transparency, 0.95)
		unitTest:assertEquals(view.color, "rgba(0, 0, 255, 0.05)")
		unitTest:assertType(view.layer, "File")
		unitTest:assert(view.layer:exists())

		view = View{
			select = "classe",
			description = "abc.",
			color = {"red", "orange", "yellow"},
			value = {1, 2, 3}
		}

		unitTest:assertType(view, "View")
		unitTest:assertEquals(view.color["1"], "rgba(255, 0, 0, 1)")
		unitTest:assertEquals(view.color["2"], "rgba(255, 165, 0, 1)")
		unitTest:assertEquals(view.color["3"], "rgba(255, 255, 0, 1)")

		view = View{
			description = "abc.",
			select = "classe",
			color = "Blues"
		}

		unitTest:assertType(view, "View")
		unitTest:assertType(view.color, "string")
		unitTest:assertEquals(view.color, "Blues")

		view = View{
			description = "abc.",
			select = "classe",
			color = {"red", "orange", "yellow"}
		}

		unitTest:assertType(view, "View")
		unitTest:assertType(view.color, "table")
		unitTest:assertEquals(view.color[1], "red")
		unitTest:assertEquals(view.color[2], "orange")
		unitTest:assertEquals(view.color[3], "yellow")

		view = View{
			description = "abc.",
			select = "classe",
			color = {{10, 10, 10}, {11, 11, 11}, {12, 12, 12}}
		}

		unitTest:assertType(view, "View")
		unitTest:assertType(view.color, "table")
		unitTest:assertType(view.color[1], "table")
		unitTest:assertType(view.color[2], "table")
		unitTest:assertType(view.color[3], "table")

		unitTest:assertEquals(view.color[1][1], 10)
		unitTest:assertEquals(view.color[1][2], 10)
		unitTest:assertEquals(view.color[1][3], 10)

		unitTest:assertEquals(view.color[2][1], 11)
		unitTest:assertEquals(view.color[2][2], 11)
		unitTest:assertEquals(view.color[2][3], 11)

		unitTest:assertEquals(view.color[3][1], 12)
		unitTest:assertEquals(view.color[3][2], 12)
		unitTest:assertEquals(view.color[3][3], 12)

		local report = Report{
			title = "URBIS-Caraguá",
			author = "Feitosa et. al (2014)"
		}

		report:addImage("urbis_2010_real.PNG", "publish")
		report:addText("This is the main endogenous variable of the model. It was obtained from a classification that categorizes the social conditions of households in Caraguatatuba on \"condition A\" (best), \"B\" or \"C\". This classification was carried out through satellite imagery interpretation and a cluster analysis (k-means method) on a set of indicators build from census data of income, education, dependency ratio, householder gender, and occupation condition of households. More details on this classification were presented in Feitosa et al. (2012) Vulnerabilidade e Modelos de Simulação como Estratégias Mediadoras: contribuição ao debate das mudanças climáticas e ambientais.")

		view = View{
			description = "abc.",
			select = "classe",
			color = {"#088da5", "#0b7b47", "#7b0b3f"},
			value = {1, 2, 3},
			label = {"Condition C", "Condition B", "Condition A"},
			report = report
		}

		unitTest:assertType(view, "View")
		unitTest:assertEquals(view.color["1"], "#088da5")
		unitTest:assertEquals(view.color["2"], "#0b7b47")
		unitTest:assertEquals(view.color["3"], "#7b0b3f")
		unitTest:assertNotNil(view.label)
		unitTest:assertType(view.label, "table")
		unitTest:assertEquals(view.label["Condition C"], "#088da5")
		unitTest:assertEquals(view.label["Condition B"], "#0b7b47")
		unitTest:assertEquals(view.label["Condition A"], "#7b0b3f")

		unitTest:assertType(view.report, "Report")
		unitTest:assertEquals(view.report.title, "URBIS-Caraguá")
		unitTest:assertEquals(view.report.author, "Feitosa et. al (2014)")

		local reports = view.report:get()
		unitTest:assertType(reports, "table")
		unitTest:assertEquals(#reports, 2)

		view = View{
			description = "Riverine settlements corresponded to Indian tribes, villages, and communities that are inserted into public lands.",
			icon = "home"
		}

		unitTest:assertType(view, "View")
		unitTest:assertNil(view.color)
		unitTest:assertEquals(view.description, "Riverine settlements corresponded to Indian tribes, villages, and communities that are inserted into public lands.")
		unitTest:assertType(view.icon, "string")
		unitTest:assertEquals(view.icon, "home")
		unitTest:assert(not view.download)

		view = View{
			description = "Riverine settlements corresponded to Indian tribes, villages, and communities that are inserted into public lands.",
			download = true,
			icon = {
				path = "M-20,0a20,20 0 1,0 40,0a20,20 0 1,0 -40,0",
				color = "red",
				transparency = 0.6,
				time = 10
			}
		}

		unitTest:assertType(view, "View")
		unitTest:assertNil(view.color)
		unitTest:assertEquals(view.description, "Riverine settlements corresponded to Indian tribes, villages, and communities that are inserted into public lands.")
		unitTest:assertType(view.icon, "table")
		unitTest:assertEquals(view.icon.path, "M-20,0a20,20 0 1,0 40,0a20,20 0 1,0 -40,0")
		unitTest:assertEquals(view.icon.color, "rgba(255, 0, 0, 1)")
		unitTest:assertEquals(view.icon.transparency, 0.6)
		unitTest:assertEquals(view.icon.time, 10)
		unitTest:assert(view.download)

		view = View{
			description = "Riverine settlements corresponded to Indian tribes, villages, and communities that are inserted into public lands.",
			download = true,
			icon = "M-20,0a20,20 0 1,0 40,0a20,20 0 1,0 -40,0"
		}

		unitTest:assertType(view, "View")
		unitTest:assertNil(view.color)
		unitTest:assertEquals(view.description, "Riverine settlements corresponded to Indian tribes, villages, and communities that are inserted into public lands.")
		unitTest:assertType(view.icon, "table")
		unitTest:assertEquals(view.icon.path, "M-20,0a20,20 0 1,0 40,0a20,20 0 1,0 -40,0")
		unitTest:assertNotNil(view.icon.color)
		unitTest:assertNotNil(view.icon.transparency)
		unitTest:assertEquals(view.icon.time, 5)
		unitTest:assert(view.download)

		view = View{
			description = "abc.",
			select = "UC",
			icon = {"home", "forest"}
		}

		unitTest:assertType(view, "View")
		unitTest:assertNil(view.color)
		unitTest:assertEquals(view.description, "abc.")
		unitTest:assertType(view.icon, "table")
		unitTest:assertType(view.select, "string")
		unitTest:assertEquals(view.select, "UC")
		unitTest:assertEquals(view.icon[1], "home")
		unitTest:assertEquals(view.icon[2], "forest")

		view = View{
			description = "abc.",
			select = "UC",
			icon = {"home", "forest"},
			label = {"Absence of Conservation Unit", "Presence of Conservation Unit"},
			decimal = 3
		}

		unitTest:assertType(view, "View")
		unitTest:assertNil(view.color)
		unitTest:assertEquals(view.description, "abc.")
		unitTest:assertType(view.icon, "table")
		unitTest:assertType(view.select, "string")
		unitTest:assertEquals(view.select, "UC")
		unitTest:assertEquals(view.decimal, 3)
		unitTest:assertEquals(view.icon[1], "home")
		unitTest:assertEquals(view.icon[2], "forest")
		unitTest:assertEquals(view.label[1], "Absence of Conservation Unit")
		unitTest:assertEquals(view.label[2], "Presence of Conservation Unit")

		view = View{
			description = "abc.",
			select = {"Nome", "UC"},
			icon = {"home", "forest"},
			label = {"Absence of Conservation Unit", "Presence of Conservation Unit"},
			report = function(cell)
				local mreport = Report{title = cell.Nome}
				mreport:addImage(packageInfo("publish").data.."arapiuns/"..cell.Nome..".jpg")
				return mreport
			end
		}

		unitTest:assertType(view, "View")
		unitTest:assertNil(view.color)
		unitTest:assertEquals(view.description, "abc.")
		unitTest:assertType(view.icon, "table")
		unitTest:assertType(view.select, "table")
		unitTest:assertEquals(view.select[1], "Nome")
		unitTest:assertEquals(view.select[2], "UC")
		unitTest:assertEquals(view.decimal, 5)
		unitTest:assertEquals(view.icon[1], "home")
		unitTest:assertEquals(view.icon[2], "forest")
		unitTest:assertEquals(view.label[1], "Absence of Conservation Unit")
		unitTest:assertEquals(view.label[2], "Presence of Conservation Unit")

		view = View {
			description = "abc.",
			select = "pib",
			color = "PuBuGn",
			slices = 2,
			min = 1,
			max = 3,
			value = {0, 1, 2, 3}
		}

		unitTest:assertType(view, "View")
		unitTest:assertEquals(view.slices, 2)
		unitTest:assertEquals(view.min, 1)
		unitTest:assertEquals(view.max, 3)

		unitTest:assertNotNil(view.color)
		unitTest:assertEquals(view.color["1.0"], "rgba(236, 226, 240, 1)")
		unitTest:assertEquals(view.color["3.0"], "rgba(28, 144, 153, 1)")

		view = View {
			description = "abc.",
			time = "snapshot"
		}

		unitTest:assertType(view, "View")
		unitTest:assertEquals(view.time, "snapshot")

		view = View {
			description = "abc.",
			name = "anoCriacao",
			time = "creation"
		}

		unitTest:assertType(view, "View")
		unitTest:assertEquals(view.name, "anoCriacao")
		unitTest:assertEquals(view.time, "creation")
	end,
	__tostring = function(unitTest)
		local view = View{
			description = "abc.",
			title = "Emas National Park",
			border = "blue",
			width = 2,
			color = "PuBu",
			select = "river",
			value = {0, 1, 2}
		}

		unitTest:assertEquals(tostring(view), [[border        string [rgba(0, 0, 255, 1)]
color         named table of size 3
decimal       number [5]
description   string [abc.]
download      boolean [false]
label         named table of size 3
loadColors    function
select        string [river]
title         string [Emas National Park]
transparency  number [0]
value         vector of size 3
visible       boolean [true]
width         number [2]
]])
	end
}
