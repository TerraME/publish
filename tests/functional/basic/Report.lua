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
	Report = function(unitTest)
		local report = Report()
		unitTest:assertType(report, "Report")
		unitTest:assertNil(report.title)
		unitTest:assertEquals(getn(report.text), 0)
		unitTest:assertEquals(getn(report.image), 0)

		local image = packageInfo("publish").path.."images/urbis_2010_real.PNG"
		report = Report{title = "My Report"}

		report:addHeading("My Heading")
		report:addImage(image)
		report:addText("Some text")

		unitTest:assertType(report, "Report")
		unitTest:assertEquals(report.title, "My Report")
		unitTest:assertEquals(report.heading[1], "My Heading")
		unitTest:assertEquals(tostring(report.image[2]), image)
		unitTest:assertEquals(report.text[3], "Some text")
		unitTest:assertEquals(report.nextIdx_, 4)

		report.image["fake"] = nil
		unitTest:assertEquals(report.nextIdx_, 4)
	end,
	addHeading = function(unitTest)
		local report = Report()

		unitTest:assertType(report, "Report")
		unitTest:assertNil(report.title)
		unitTest:assertEquals(getn(report.text), 0)
		unitTest:assertEquals(getn(report.image), 0)
		unitTest:assertEquals(getn(report.separator), 0)
		unitTest:assertEquals(getn(report.heading), 0)

		report:addHeading("Social Classes 2010 Real")
		report:addText("This is the main endogenous variable of the model.")

		unitTest:assertEquals(getn(report.image), 0)
		unitTest:assertEquals(getn(report.heading), 1)
		unitTest:assertEquals(getn(report.text), 1)
		unitTest:assertEquals(report.heading[1], "Social Classes 2010 Real")
		unitTest:assertEquals(report.text[2], "This is the main endogenous variable of the model.")
	end,
	addImage = function(unitTest)
		local report = Report()

		unitTest:assertType(report, "Report")
		unitTest:assertNil(report.title)
		unitTest:assertEquals(getn(report.text), 0)
		unitTest:assertEquals(getn(report.image), 0)

		report:addImage("urbis_2010_real.PNG", "publish")

		unitTest:assertNil(report.title)
		unitTest:assertEquals(getn(report.text), 0)
		unitTest:assertEquals(getn(report.image), 1)
		unitTest:assertEquals(tostring(report.image[1]), packageInfo("publish").path.."images/urbis_2010_real.PNG")
	end,
	addSeparator = function(unitTest)
		local report = Report()

		unitTest:assertType(report, "Report")
		unitTest:assertNil(report.title)
		unitTest:assertEquals(getn(report.text), 0)
		unitTest:assertEquals(getn(report.image), 0)
		unitTest:assertEquals(getn(report.separator), 0)

		report:addSeparator()

		unitTest:assertEquals(getn(report.separator), 1)
		unitTest:assert(report.separator[1])

		report:addText("My text 1")
		report:addText("My text 2")
		report:addSeparator()

		unitTest:assertEquals(getn(report.separator), 2)
		unitTest:assertEquals(getn(report.text), 2)
		unitTest:assert(report.separator[1])
		unitTest:assert(report.separator[4])
	end,
	addText = function(unitTest)
		local report = Report()
		local text = "This is the main endogenous variable of the model."

		unitTest:assertType(report, "Report")
		unitTest:assertNil(report.title)
		unitTest:assertEquals(getn(report.text), 0)
		unitTest:assertEquals(getn(report.image), 0)

		report:addText(text)

		unitTest:assertEquals(getn(report.text), 1)
		unitTest:assertEquals(getn(report.image), 0)
		unitTest:assertEquals(report.text[1], text)
	end,
	addMatrix = function(unitTest)
		local report = Report()
		local TABLE = {
			title = { "Data of name"},
			columns = {
				 "Label Column",
				 "Title Column02",
				 "Title Column03",
				 "Title Column04",
				 "Title Column5",
			},
			values = {
				 {math.random(), math.random(), math.random(),},
				 {math.random(), math.random(), math.random(),},
				 {math.random(), math.random(), math.random(),},
				 {math.random(), math.random(), math.random(),},
				 }
			}

		unitTest:assertType(report, "Report")
		unitTest:assertNil(report.title)
		unitTest:assertEquals(getn(report.text), 0)
		unitTest:assertEquals(getn(report.image), 0)
		unitTest:assertEquals(getn(report.matrix), 0)
		unitTest:assertEquals(getn(report.graphic), 0)
		unitTest:assertEquals(getn(report.mult), 0)

		report:addMatrix(TABLE)

		unitTest:assertEquals(getn(report.text), 0)
		unitTest:assertEquals(getn(report.image), 0)
		unitTest:assertEquals(getn(report.matrix), 1)
		unitTest:assertEquals(getn(report.graphic), 0)
		unitTest:assertEquals(getn(report.mult), 0)
		unitTest:assertEquals(report.matrix[1], matrix)
	end,
	addGraphic = function(unitTest)
		local report = Report()
			local GRAPHIC = {
				id = 0,
				title = { "Name of graphic"},
				columns = {
						"area01",
						"area02",
						"area03",
					},
				values = {
						{
						"label of graphic",
						math.random(),
						math.random(),
						math.random(),
						},
						{
						"label of graphic",
						math.random(),
						math.random(),
						math.random(),
						},
					}
				}

		unitTest:assertType(report, "Report")
		unitTest:assertNil(report.title)
		unitTest:assertEquals(getn(report.text), 0)
		unitTest:assertEquals(getn(report.image), 0)
		unitTest:assertEquals(getn(report.matrix), 0)
		unitTest:assertEquals(getn(report.graphic), 0)
		unitTest:assertEquals(getn(report.mult), 0)

		report:addGraphic(GRAPHIC)

		unitTest:assertEquals(getn(report.text), 0)
		unitTest:assertEquals(getn(report.image), 0)
		unitTest:assertEquals(getn(report.matrix), 0)
		unitTest:assertEquals(getn(report.graphic), 1)
		unitTest:assertEquals(getn(report.mult), 0)
		unitTest:assertEquals(report.graphic[1], graphic)
	end,
	addMult = function(unitTest)
		local report = Report()
		local mult = "This is the main endogenous variable of the model."

		unitTest:assertType(report, "Report")
		unitTest:assertNil(report.title)
		unitTest:assertEquals(getn(report.text), 0)
		unitTest:assertEquals(getn(report.image), 0)
		unitTest:assertEquals(getn(report.matrix), 0)
		unitTest:assertEquals(getn(report.graphic), 0)
		unitTest:assertEquals(getn(report.mult), 0)

		report:addMult(mult)

		unitTest:assertEquals(getn(report.text), 0)
		unitTest:assertEquals(getn(report.image), 0)
		unitTest:assertEquals(getn(report.matrix), 0)
		unitTest:assertEquals(getn(report.graphic), 0)
		unitTest:assertEquals(getn(report.mult), 1)
		unitTest:assertEquals(report.mult[1], mult)
	end,
	addVideo = function(unitTest)
		local report = Report()

		unitTest:assertType(report, "Report")
		unitTest:assertNil(report.title)
		unitTest:assertEquals(getn(report.text), 0)
		unitTest:assertEquals(getn(report.image), 0)
		unitTest:assertEquals(getn(report.matrix), 0)
		unitTest:assertEquals(getn(report.graphic), 0)
		unitTest:assertEquals(getn(report.mult), 0)
		unitTest:assertEquals(getn(report.video), 0)

		report:addVideo{
			width = 500,
			heigh = 315,
			url = "https://www.youtube.com/embed/q0_XODQ0GGg",
		}

		unitTest:assertEquals(getn(report.text), 0)
		unitTest:assertEquals(getn(report.image), 0)
		unitTest:assertEquals(getn(report.matrix), 0)
		unitTest:assertEquals(getn(report.graphic), 0)
		unitTest:assertEquals(getn(report.mult), 0)
		unitTest:assertEquals(getn(report.video), 1)
		unitTest:assertEquals(report.video[1], video)
	end,

	get = function(unitTest)
		local report = Report()

		unitTest:assertType(report, "Report")
		unitTest:assertNil(report.title)
		unitTest:assertNil(report.author)

		report = Report{
			title = "URBIS"
		}

		unitTest:assertEquals(getn(report.text), 0)
		unitTest:assertEquals(getn(report.image), 0)
		unitTest:assertEquals(getn(report.separator), 0)

		local template = report:get()
		unitTest:assertType(template, "table")
		unitTest:assertEquals(getn(template), 0)

		report:addSeparator()
		report:addHeading("Social Classes 2010")
		report:addImage("urbis_2010_real.PNG", "publish")
		report:addText("This is the main endogenous variable of the model.")
		report:addText("It was obtained from a classification that categorizes the social conditions of households in Caraguatatuba on 'condition A' (best), 'B' or 'C''.")

		unitTest:assertEquals(report.title, "URBIS")
		unitTest:assert(report.separator[1])
		unitTest:assertEquals(report.heading[2], "Social Classes 2010")
		unitTest:assertEquals(tostring(report.image[3]), packageInfo("publish").path.."images/urbis_2010_real.PNG")
		unitTest:assertEquals(report.text[4], "This is the main endogenous variable of the model.")
		unitTest:assertEquals(report.text[5], "It was obtained from a classification that categorizes the social conditions of households in Caraguatatuba on 'condition A' (best), 'B' or 'C''.")

		template = report:get()
		unitTest:assertType(template, "table")
		unitTest:assertEquals(getn(template), 5)

		unitTest:assertNil(template[1].text)
		unitTest:assertNotNil(template[1].separator)
		unitTest:assertNil(template[1].image)
		unitTest:assertNil(template[1].heading)

		unitTest:assertNil(template[2].text)
		unitTest:assertNil(template[2].separator)
		unitTest:assertNil(template[2].image)
		unitTest:assertNotNil(template[2].heading)

		unitTest:assertNil(template[3].text)
		unitTest:assertNil(template[3].separator)
		unitTest:assertNotNil(template[3].image)
		unitTest:assertNil(template[3].heading)

		unitTest:assertNotNil(template[4].text)
		unitTest:assertNil(template[4].separator)
		unitTest:assertNil(template[4].image)
		unitTest:assertNil(template[4].heading)

		unitTest:assertNotNil(template[5].text)
		unitTest:assertNil(template[5].separator)
		unitTest:assertNil(template[5].image)
		unitTest:assertNil(template[5].heading)
	end,
	__tostring = function(unitTest)
		local report = Report{
			title = "My Report",
			author = "Carneiro, Heitor"
		}

		report:addText("My text")

		unitTest:assertType(report, "Report")
		unitTest:assertEquals(tostring(report), [[author     string [Carneiro, Heitor]
graphic    vector of size 0
heading    vector of size 0
image      vector of size 0
matrix     vector of size 0
mult       vector of size 0
nextIdx_   number [2]
separator  vector of size 0
text       vector of size 1
title      string [My Report]
video      vector of size 0
]])
	end
}
