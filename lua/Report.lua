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

Report_ = {
	type_ = "Report",
	--- Add a new heading to the Report. A heading element briefly describes the topic of the section it introduces.
	-- @arg heading A mandatory string with the heading of the report.
	-- @usage import("publish")
	-- local report = Report()
	-- report:addHeading("My Heading", "publish")
	addHeading = function(self, heading)
		mandatoryArgument(1, "string", heading)
		self.heading[self.nextIdx_] = heading
	end,
	--- Add a new image to the Report.
	-- @arg image A mandatory string or base::File with the image of the report.
	-- The supported extensions are: bmp, gif, jpg, jpeg, png, and svg.
	-- @arg package An optional string with the name of the package.
	-- @usage import("publish")
	-- local report = Report()
	-- report:addImage("urbis_2010_real.PNG", "publish")
	addImage = function(self, image, package)
		if type(image) == "string" then
			if package then
				if type(package) == "string" then
					image = packageInfo(package).path.."images/"..image
				else
					incompatibleTypeError(2, "string", package)
				end
			end

			image = File(image)
		end

		mandatoryArgument(1, "File", image)

		if image:exists() then
			local extension = image:extension():lower()
			if belong(extension, {"bmp", "gif", "jpeg", "jpg", "png", "svg"}) then
				self.image[self.nextIdx_] = image
			else
				customError("'"..extension.."' is an invalid extension for argument 'image'. Valid extensions ['bmp', 'gif', 'jpeg', 'jpg', 'png', 'svg'].")
			end
		else
			local msg = "File '"..image.."' does not exist."
			if package then
				msg = "File '"..image:name().."' does not exist in package '"..package.."'."
			end

			local dir = image:path()
			local suggest = suggestion(image:name(), Directory(dir):list())
			local suggestMsg = suggestionMsg(suggest)

			msg = msg..suggestMsg

			customError(msg)
		end
	end,
	--- Add a line in the Report.
	-- @usage import("publish")
	-- local report = Report()
	-- report:addSeparator()
	addSeparator = function(self)
		self.separator[self.nextIdx_] = true
	end,
	--- Add a new text to the Report.
	-- @arg text A mandatory string with the text to the report.
	-- @usage import("publish")
	-- local report = Report()
	-- report:addText("My text")
	addText = function(self, text)
		mandatoryArgument(1, "string", text)
		self.text[self.nextIdx_] = text
	end,
	--- Add a new table to the Report.
	-- @arg table accept string and data to the report.
	-- @usage import("publish")
	-- local report = Report()
	-- report:addTable("My table")
	addTable = function(self, data)
		self.matrix[self.nextIdx_] = data
	end,
	--- Add a new graphic to the Report.
	-- @arg graphic/table accept string and data to the report.
	-- @usage import("publish")
	-- local report = Report()
	-- report:addGraphic("My graphic")
	addGraphic = function(self, data)
		self.graphic[self.nextIdx_] = data
	end,
	--- Add multiple data to the Report.
	-- @arg mult accept string and data with to the report.
	-- @usage import("publish")
	-- local report = Report()
	-- report:addMultiples("My multiples")
	addMult = function(self, data)
		self.mult[self.nextIdx_] = data
	end,

	--- Return the Report created.
	-- @usage import("publish")
	-- local report = Report()
	-- report:addText("My text")
	-- report:get()
	get = function(self)
		local template = {}
		for i = 1, self.nextIdx_ - 1 do
			table.insert(template, {
				text = self.text[i],
				separator = self.separator[i],
				image = self.image[i],
				heading = self.heading[i],
				matrix = self.matrix[i],
				mult = self.mult[i],
				graphic = self.graphic[i],
				 }
				)
		end

		return template
	end
}


metaTableReport_ = {
	__index = Report_,
	__tostring = _Gtme.tostring
}

--- Creates a page with data information.
-- @arg data.title An optional string with the Report's title.
-- @arg data.author An optional string with the Report's author.
-- @usage import("publish")
-- local report = Report{
--     title = "Social Classes 2010 Real",
--     author = "Feitosa et al. (2012)"
-- }
--
-- report:addImage("urbis_2010_real.PNG", "publish")
-- report:addText("This is the main endogenous variable of the model.")
function Report(data)
	data = data or {}
	mandatoryArgument(1, "table", data)
	verifyUnnecessaryArguments(data, {"title", "author"})
	optionalTableArgument(data, "title", "string")
	optionalTableArgument(data, "author", "string")

	local mdata = {
		nextIdx_ = 1,
		title = data.title,
		author = data.author,
		text = {},
		image = {},
		separator = {},
		heading = {},
		matrix = {},
		mult = {},
		graphic = {},
		}

	local metaTableIdxs = {
		__newindex = function(self, k, v)
			if v and not rawget(self, k) then
				mdata.nextIdx_ = mdata.nextIdx_ + 1
			end

			rawset(self, k, v)
		end
	}

	setmetatable(mdata.text, 		metaTableIdxs)
	setmetatable(mdata.image,	 	metaTableIdxs)
	setmetatable(mdata.separator, 	metaTableIdxs)
	setmetatable(mdata.heading, 	metaTableIdxs)
	setmetatable(mdata.matrix, 		metaTableIdxs)
	setmetatable(mdata.mult,		metaTableIdxs)
	setmetatable(mdata.graphic,		metaTableIdxs)
	setmetatable(mdata, metaTableReport_)

	return mdata
end