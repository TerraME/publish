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

View_ = {
	type_ = "View"
}

metaTableView_ = {
	__index = View_,
	__tostring = _Gtme.tostring
}

--- View is an object that contains the information of the data to be visualized.
-- One Application is composed by a set of Views.
-- @arg data.select An optional string with the name of the attribute to be visualized.
-- @arg data.value An optional table with the possible values for the selected attributes. This argument is mandatory when using color.
-- @arg data.visible An optional boolean whether the layer is visible. Defaults to false.
-- @arg data.width An optional argument with the stroke width in pixels.
-- @arg data.transparency An optional argument with the opacity of color attribute. The transparency parameter is a number between 0.0 (fully opaque) and 1.0 (fully transparent).
-- The default value is 0.
-- @arg data.border An optional string or table with the stroke color. Colors can be described as strings using
-- a color name, an RGB value (Ex. {0, 0, 0}), or a HEX value (see https://www.w3.org/wiki/CSS/Properties/color/keywords).
-- @arg data.color An optional table with the colors for the attributes. Colors can be described as strings using
-- a color name, an RGB value, a HEX value, or even as a string with a ColorBrewer format (see http://www.colorbrewer2.org).
-- The available color names are:
-- <br><img src="../../lib/color_keyword_names.svg" alt="Color keywords name"> <br>
-- These colors are defined by www.w3.org (see https://www.w3.org/TR/SVG/types.html#ColorKeywords).
-- The colors available in ColorBrewer format and the maximum number of slices for each of them are:
-- @tabular color
-- Name & Max \
-- Accent, Dark, Set2 & 7 \
-- Pastel2, Set1 & 8 \
-- Pastel1 & 9 \
-- PRGn, RdYlGn, Spectral & 10 \
-- BrBG, Paired, PiYG, PuOr, RdBu, RdGy, RdYlBu, Set3 & 11 \
-- BuGn, BuPu, OrRd, PuBu & 19 \
-- Blues, GnBu, Greens, Greys, Oranges, PuBuGn, PuRd, Purples, RdPu, Reds, YlGn, YlGnBu, YlOrBr, YlOrRd & 20 \
-- @usage import("publish")
--
-- local view = View{
--     title = "Emas National Park",
--     description = "A small example related to a fire spread model.",
--     border = "blue",
--     width = 2,
--     color = "PuBu",
--     select = "river",
--     value = {0, 1, 2}
-- }
--
-- print(vardump(view))
function View(data)
	verifyNamedTable(data)
	optionalTableArgument(data, "title", "string")
	optionalTableArgument(data, "description", "string")
	optionalTableArgument(data, "value", "table")
	optionalTableArgument(data, "select", "string")
	optionalTableArgument(data, "report", "Report")

	defaultTableValue(data, "width", 1)
	defaultTableValue(data, "transparency", 0)
	defaultTableValue(data, "visible", true)

	verifyUnnecessaryArguments(data, {"title", "description", "border", "width", "color", "visible", "select", "value", "layer", "report", "transparency"})

	if data.transparency < 0 or data.transparency > 1 then
		customError("Argument 'transparency' should be a number between 0.0 (fully opaque) and 1.0 (fully transparent), got "..data.transparency..".")
	end

	if data.color then
		local realTransparency = 1 - data.transparency
		if data.value then
			mandatoryTableArgument(data, "select", "string")

			local classes = #data.value
			if classes <= 0 then
				customError("Argument 'value' must be a table with size greater than 0, got "..classes..".")
			end

			local mcolor
			if type(data.color) == "string" then
				mcolor = color{color = data.color, classes = classes, alpha = realTransparency}
			else
				mcolor = color{color = data.color, alpha = realTransparency}
			end

			local nColors = #mcolor
			if classes ~= nColors then
				customError("The number of colors ("..nColors..") must be equal to number of data classes ("..classes..").")
			end

			local colors = {}
			for i = 1, classes do
				colors[tostring(data.value[i])] = mcolor[i]
			end

			data.color = colors
		else
			if data.select then
				local brewerNames = {"Accent", "Blues", "BrBG", "BuGn", "BuPu", "Dark", "GnBu", "Greens", "Greys", "OrRd",
					"Oranges", "PRGn", "Paired", "Pastel1", "Pastel2", "PiYG", "PuBu", "PuBuGn", "PuOr", "PuRd", "Purples",
					"RdBu", "RdGy", "RdPu", "RdYlBu", "RdYlGn", "Reds", "Set1", "Set2", "Set3", "Spectral", "YlGn", "YlGnBu",
					"YlOrBr", "YlOrRd" }

				local isColorBrewer = type(data.color) == "string" and belong(data.color, brewerNames)
				local isTableColors = type(data.color) == "table" and #data.color > 1 and (type(data.color[1]) == "string" or type(data.color[1]) == "table")

				if not (isColorBrewer or isTableColors) then
					data.color = color{color = data.color, alpha = realTransparency}
				end
			else
				data.color = color{color = data.color, alpha = realTransparency}
			end
		end
	end

	if data.border then
		data.border = color{border = data.border}
	end

	if data.layer then
		if type(data.layer) == "string" then
			data.layer = File(data.layer)
		end

		mandatoryTableArgument(data, "layer", "File")
	end

	setmetatable(data, metaTableView_)
	return data
end
