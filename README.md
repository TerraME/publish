# Publish
## Overview
This is a [TerraME](http://terrame.org) package that allows one to export the outputs of different Model scenarios to a web server.

## License
Publish is distributed under the GNU Lesser General Public License as published by the Free Software Foundation. See [publish-license-lgpl-3.0.txt](https://github.com/pedro-andrade-inpe/publish/blob/master/license.txt) for details.

## Instructions
Publish automatically reprojects data to the <b>“EPSG:4326”</b> projection (i.e. GCS_WGS_1984). If the final visualization does not work, please reproject the input data to this projection before creating the application.

## Examples
```lua
import("publish")

Application{
    project = filePath("brazil.tview", "publish"),
    title = "Brazil Application",
    description = "Small application with some data related to Brazil.",
    biomes = View{
        select = "name",
        color = "Set2",
        description = "Brazilian Biomes, from IBGE."
    },
    states  = View{
        color = "yellow",
        description = "Brazilian states."
    }
}
```
You can see the result in [Brazil](https://rawgit.com/TerraME/publish/master/examples/brazilWebMap/index.html).

```lua
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
```
You can see the result in [Caragua](https://rawgit.com/TerraME/publish/master/examples/caraguaWebMap/index.html).

```lua
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
        width = 3,
        border = "blue",
        icon = {
            path = "M150 0 L75 200 L225 200 Z",
            transparency = 0.2,
            time = 35
        }
    },
    villages = View{
        download = true,
        description = "Riverine settlements corresponded to Indian tribes, villages, and communities that are inserted into public lands.",
        icon = "ICON",
        select = "Nome",
        report = function(cell)
            local mreport = Report{
                title = cell.Nome,
                author = "Escada et. al (2013)"
            }

            mreport:addImage(packageInfo("publish").data.."arapiuns/"..cell.Nome..".jpg")

            local health, water
            if cell.PSAU > 0 then health = "has" else health = "hasn't" end
            if cell.AGUA > 0 then water  = "has" else water  = "hasn't" end

            mreport:addText(string.format("The community %s health center and %s access to water.", health, water))

            local school = {}
            if cell.ENSINF > 0   then table.insert(school, "Early Childhood Education")     end
            if cell.ENSFUND2 > 0 then table.insert(school, "Elementary School")             end
            if cell.EJA > 0      then table.insert(school, "Education of Young and Adults") end

            if #school > 0 then
                mreport:addText(string.format("The schools offers %s.", table.concat(school, ", ")))
            end

            return mreport
        end
    }
}
```
You can see the result in [Arapiuns](https://rawgit.com/TerraME/publish/master/examples/arapiunsWebMap/index.html).

## Reporting Bugs
If you have found a bug, open an entry in the [issues](https://github.com/TerraME/publish/issues).

## Code Status
<b> Current status of Publish package </b>

| check | doc | test |
|---|---|---|---|
[<img src="http://www.dpi.inpe.br/jenkins/buildStatus/icon?job=terrame-ci-publish-code-analysis-linux-ubuntu-14.04">](http://www.dpi.inpe.br/jenkins/job/terrame-ci-publish-code-analysis-linux-ubuntu-14.04/lastBuild/consoleFull) | [<img src="http://www.dpi.inpe.br/jenkins/buildStatus/icon?job=terrame-ci-publish-doc-linux-ubuntu-14.04">](http://www.dpi.inpe.br/jenkins/job/terrame-ci-publish-doc-linux-ubuntu-14.04/lastBuild/consoleFull) | [<img src="http://www.dpi.inpe.br/jenkins/buildStatus/icon?job=terrame-ci-publish-unittest-linux-ubuntu-14.04">](http://www.dpi.inpe.br/jenkins/job/terrame-ci-publish-unittest-linux-ubuntu-14.04/lastBuild/consoleFull)|
