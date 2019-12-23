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

-- @example Implementation of a simple Application using URBIS-Caraguá.
-- The data of this application were extracted from Feitosa et. al (2014) URBIS-Caraguá: Um Modelo
-- de Simulação Computacional para a Investigação de Dinâmicas de Ocupação Urbana em Caraguatatuba, SP.

import("publish")

local report = Report{
	title = "URBIS-Caraguá",
	author = "Feitosa et. al (2014)"
}

report:addHeading("Social Classes 2010")
report:addImage("urbis_2010_real.PNG", "publish")
report:addText("This is the main endogenous variable of the model. It was obtained from a classification that categorizes the social conditions of households in Caraguatatuba on \"condition A\" (best), \"B\" or \"C\". This classification was carried out through satellite imagery interpretation and a cluster analysis (k-means method) on a set of indicators build from census data of income, education, dependency ratio, householder gender, and occupation condition of households. More details on this classification were presented in Feitosa et al. (2012) Vulnerabilidade e Modelos de Simulação como Estratégias Mediadoras: contribuição ao debate das mudanças climáticas e ambientais.")

report:addSeparator()

report:addHeading("Occupational Classes (IBGE, 2010)")
report:addImage("urbis_uso_2010.PNG", "publish")
report:addText("The occupational class describes the percentage of houses and apartments inside such areas that have occasional use. The dwelling is typically used in summer vacations and holidays.")

report:addSeparator()

report:addHeading("Social Classes 2025")
report:addImage("urbis_simulation_2025_baseline.PNG", "publish")
report:addText("The base scenario considers the zoning proposed by the new master plan of Caraguatatuba. This scenario shows how the new master plan consolidates existing patterns and trends, not being able to force significant changes in relation to the risk distribution observed in 2010.")

import("gis")

local file = File("scenario-caragua.tview")
file:deleteIfExists()

local project = Project{
	title = "URBIS-Caraguá",
	author = "Carneiro, H.",
	file = file,
	clean = true,
	limit = filePath("caragua.shp", "publish"),
	regions = filePath("regions.shp", "publish"),
	use = filePath("occupational2010.shp", "publish"),
	classes_2010 = filePath("caragua_classes2010_regioes.shp", "publish"),
	classes_BaseLine_2025 = filePath("simulation2025_baseline.shp", "publish"),
	classes_LessGrowth_2025 = filePath("simulation2025_lessgrowth.shp", "publish"),
	classes_PlusGrowth_2025 = filePath("simulation2025_plusgrowth.shp", "publish")
}


Application{
	key = "AIzaSyCFXMRJlfDoDK7Hk8KkJ9R9bWpNauoLVuA",
	project = project,
	description = "The data of this application were extracted from Feitosa et. al (2014) URBIS-Caraguá: "
			.."Um Modelo de Simulação Computacional para a Investigação de Dinâmicas de Ocupação Urbana em Caraguatatuba, SP.",
	report = report,
	scenario = {
		BaseLine = "Baseline simulation for 2025.",
		LessGrowth = "Less growth simulation in 2025. Categorizes the social conditions of households in Caraguatatuba using classes A (3), B (2) or C (1).",
		PlusGrowth = "Plus growth simulation in 2025. Categorizes the social conditions of households in Caraguatatuba using classes A (3), B (2) or C (1)."
	},
	SocialClasses = List{
		classes = View{
			title = "Social Classes 2010",
			description = "This is the main endogenous variable of the model. It was obtained from a classification that "
					.."categorizes the social conditions of households in Caraguatatuba on 'condition A' (best), 'B' or 'C''.",
			width = 0,
			select = "classe",
			color = {"red", "orange", "yellow"},
			label = {"Condition C", "Condition B", "Condition A"},
			time = "snapshot"
		}
	},
	Border = List{
		limit = View{
			description = "Bounding box of Caraguatatuba.",
			color = "goldenrod"
		},
		regions = View{
			description = "Regions of Caraguatatuba.",
			select = "name",
			color = "Set2",
			label = {"North", "Central", "South"}
		}
	},
	OccupationalClasses = List{
		use = View{
			title = "Occupational Classes 2010",
			description = "The occupational class describes the percentage of houses and apartments inside such areas that "
					.."have occasional use. The dwelling is typically used in summer vacations and holidays.",
			width = 0,
			select = "uso",
			color = "RdPu",
			label = {"0.000000 - 0.200000", "0.200001 - 0.350000", "0.350001 - 0.500000", "0.500001 - 0.700000", "0.700001 - 0.930000"}
		}
	}
}

file:deleteIfExists()
