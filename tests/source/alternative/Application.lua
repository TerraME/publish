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
	Application = function(unitTest)
		local gis = getPackage("gis")
		local sourceDir = Directory("SourceErrorAPP")
		if sourceDir:exists() then sourceDir:delete() end

		local projFile = File("source.tview")
		projFile:deleteIfExists()

		local error_func = function()
			Application{
				title = "Testing layer with the wrong source.",
				output = sourceDir,
				progress = false,
				wfsLayer = View {
					title = "Wrong File",
					description = "Loading a view from WFS.",
					layer = filePath("biomes/Amazonia.jpg", "publish");
				}
			}
		end
		unitTest:assertError(error_func, "Application 'view' does not have any valid Layer.")
		if sourceDir:exists() then sourceDir:delete() end

		local service = "http://terrabrasilis.info/redd-pac/wfs"
		if gis.TerraLib().isValidWfsUrl(service) then
			local proj = gis.Project {
				title = "WFS",
				author = "Carneiro, H.",
				file = projFile,
				clean = true
			}

			local feature = "reddpac:wfs_biomes"
			gis.Layer{
				project = proj,
				name = "wfsLayer",
				service = service,
				feature = feature
			}

			error_func = function()
				Application{
					project = proj,
					output = sourceDir,
					progress = false,
					wfsLayer = View {
						title = "WFS",
						description = "Loading a view from WFS."
					}
				}
			end
			unitTest:assertError(error_func, "Layer 'wfsLayer' with source 'wfs' is not supported by publish.")
			if sourceDir:exists() then sourceDir:delete() end
		end
		projFile:deleteIfExists()
	end
}
