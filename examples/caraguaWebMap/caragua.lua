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

Application{
	project = filePath("caragua.tview", "publish"),
	description = "The data of this application were extracted from Feitosa et. al (2014) URBIS-Caraguá: "
			.."Um Modelo de Simulação Computacional para a Investigação de Dinâmicas de Ocupação Urbana em Caraguatatuba, SP.",
	report = report,
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
	SocialClasses = List{
		real = View{
			title = "Social Classes 2010",
			description = "This is the main endogenous variable of the model. It was obtained from a classification that "
					.."categorizes the social conditions of households in Caraguatatuba on 'condition A' (best), 'B' or 'C''.",
			width = 0,
			select = "classe",
			color = {"red", "orange", "yellow"},
			label = {"Condition C", "Condition B", "Condition A"}
		},
		baseline = View{
			title = "Social Classes 2025",
			description = "The base scenario considers the zoning proposed by the new master plan of Caraguatatuba.",
			width = 0,
			select = "classe",
			color = {"red", "orange", "yellow"},
			label = {"Condition C", "Condition B", "Condition A"}
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
