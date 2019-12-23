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

-- @example Creates a database that can be used by caraguaapp.
-- The data of this application were extracted from Feitosa et. al (2014) URBIS-Caraguá: Um Modelo
-- de Simulação Computacional para a Investigação de Dinâmicas de Ocupação Urbana em Caraguatatuba, SP.

import("gis")

project = Project{
	title = "URBIS-Caraguá",
	author = "Carneiro, H.",
	file = "caragua.tview",
	clean = true,
	limit = filePath("caragua.shp", "publish"),
	regions = filePath("regions.shp", "publish"),
	real = filePath("caragua_classes2010_regioes.shp", "publish"),
	baseline = filePath("simulation2025_baseline.shp", "publish"),
	less = filePath("simulation2025_lessgrowth.shp", "publish"),
	plus = filePath("simulation2025_plusgrowth.shp", "publish"),
	poorer = filePath("simulation2025_poorer.shp", "publish"),
	richer = filePath("simulation2025_richer_final.shp", "publish"),
	use = filePath("occupational2010.shp", "publish")
}

