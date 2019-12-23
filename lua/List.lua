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

List_ = {
	type_ = "List"
}

metaTableList_ = {
	__index = List_,
	__tostring = _Gtme.tostring,
	__len = function(self)
		return self.size
	end
}

--- A list of View objects.
-- @arg data A table with the views.
-- @usage import("publish")
-- local list = List{
--     limit = View{
--          description = "Bounding box of Caraguatatuba.",
--          color = "goldenrod"
--     },
--     regions = View{
--          description = "Regions of Caraguatatuba.",
--          select = "name",
--          color = "Set2"
--     }
-- }
--
-- print(list)
-- print(#list)
function List(data)
	mandatoryArgument(1, "table", data)
	verifyNamedTable(data)

	local mdata = {
		size = 0,
		views = {}
	}

	setmetatable(mdata, metaTableList_)

	forEachOrderedElement(data, function(idx, value, mtype)
		if mtype == "View" then
			mdata.views[idx] = value
			mdata.size = mdata.size + 1
		else
			incompatibleTypeError(idx, "View", value)
		end
	end)

	if #mdata == 0 then
		customError("List is empty. A List must be initialized with Views elements.")
	end

	return mdata
end
