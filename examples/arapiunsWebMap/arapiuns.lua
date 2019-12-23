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

-- @example Implementation of a simple Application using Arapiuns.
-- The data of this application were extracted from Escada et. al (2013) Infraestrutura,
-- Serviços e Conectividade das Comunidades Ribeirinhas do Arapiuns, PA. Relatório técnico, INPE.

import("publish")

local description = [[
	This report presents the methodology and the initial results obtained at the fieldwork along riverine settlements at
	Arapiuns River, tributary of Tapajós River, municipality of Santarém, Pará state, from June 4 th to 15 th , 2012.
	This research reproduces and extends the data collection accomplished for Tapajós communities in 2009, regarding the
	infrastructure and network relations of riverine human settlements. The main objective was to characterize the
	organization and interdependence between settlements concerning to:infrastructure, health and education services,
	land use, ecosystem services provision and perception of welfare.
	Source: Escada et. al (2013) Infraestrutura, Serviços e Conectividade das Comunidades Ribeirinhas do Arapiuns, PA.
	Relatório Técnico de Atividade de Campo - Projeto UrbisAmazônia e Projeto Cenários para a Amazônia: Uso da terra,
	Biodiversidade e Clima, INPE.
]]

Application{
	project = filePath("arapiuns.tview", "publish"),
	description = description,
	base = "roadmap",
	template = {navbar = "darkblue", title = "white"},
	trajectory = View{
		description = "Route on the Arapiuns River.",
		width = 2,
		border = "blue",
		icon = {
			time = 100
		}
	},
	villages = View{
		download = true,
		description = "Riverine settlements corresponded to Indian tribes, villages, and communities that are inserted into public lands.",
		select = {"Nome", "UC"},
		icon = {"home", "forest"},
		label = {"PAE Lago Grande", "Conservation Unit"},
		report = function(cell)
			local mreport = Report{
				title = cell.Nome,
				author = "Escada et. al (2013)"
			}

			mreport:addImage(packageInfo("publish").data.."arapiuns/"..cell.Nome..".jpg")

			local age = math.ceil(130 * cell.IDDCM / 0.77)
			local pop = math.ceil(350 * cell.NPES / 0.8)

			local text = "The community "..cell.Nome.." was founded "..age.." years ago and has around "..pop.." inhabitants."

			if cell.UC == 1 then
				text = text.." It belongs to a Conservation Unit."
			else
				text = text.." It belongs to PAE Lago Grande."
			end

			local health, water
			if cell.PSAU > 0 then health = "has" else health = "hasn't" end
			if cell.AGUA > 0 then water  = "has" else water  = "hasn't" end

			text = text..string.format(" The community %s health center and %s access to water.", health, water)

			if cell.BFAM == 0 then
				text = text.." It has no Bolsa Familia."
			elseif cell.BFAM <= 0.3 then
				text = text.." Few of its inhabitants have Bolsa Familia."
			elseif cell.BFAM <= 0.6 then
				text = text.." Many of its inhabitants have Bolsa Familia."
			elseif cell.BFAM <= 0.8 then
				text = text.." Most of its inhabitants have Bolsa Familia."
			else
				text = text.." All inhabitants have Bolsa Familia."
			end

			mreport:addText(text)

			local infrastructure = {}

			if cell.IGREJAS > 0 then
				if cell.IGREJAS > 0.6 then
					table.insert(infrastructure, "churches")
				else
					table.insert(infrastructure, "church")
				end
			end

			if cell.CFUT    == 1 then table.insert(infrastructure, "soccer field")     end
			if cell.ORELHAO == 1 then table.insert(infrastructure, "public telephone") end
			if cell.ENERGIA  > 0 then table.insert(infrastructure, "oil generator")    end

			local school = {}
			if cell.ENSINF > 0   then table.insert(school, "Early Childhood Education")     end
			if cell.ENSFUND2 > 0 then table.insert(school, "Elementary School")             end
			if cell.EJA > 0      then table.insert(school, "Education of Young and Adults") end

			if #school > 0 then
				table.insert(infrastructure, "school")
			end

			if #infrastructure > 0 then
				text = string.format(cell.Nome.." has the following infrastructure: %s.", table.concat(infrastructure, ", "))

				if #school > 0 then
					text = text..string.format(" The school offers %s.", table.concat(school, ", "))
				end

				mreport:addText(text)
			end

			local production = {}

			if cell.ACAI     == 1 then table.insert(production, "acai")     end
			if cell.GADO     == 1 then table.insert(production, "cattle")   end
			if cell.CASTANHA == 1 then table.insert(production, "chestnut") end
			if cell.FRUTAS   == 1 then table.insert(production, "fruits")   end
			if cell.MAND     == 1 then table.insert(production, "mandioc")  end
			if cell.ARROZ    == 1 then table.insert(production, "rice")     end

			if #production > 0 then
				mreport:addText(string.format("The community produces the following commodities: %s.", table.concat(production, ", ")))
			end

			return mreport
		end
	}
}
