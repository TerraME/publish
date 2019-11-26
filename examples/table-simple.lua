--[[ [previous](04-brazil-states.lua) | [contents](../00-contents.lua) | [next](../arapiuns/06-arapiuns-project.lua)

Finally, we now add a [Report](http://www.terrame.org/packages/doc/publish/doc/files/Report.html) to each biome. When a View has a report, it creates
a report to each of its geometries using the attributes of the respective
geometry. A report is then activated when one clicks on a given object in the
application. The code below adds an image to the report and use other attributes
as text. Open the shapefile in your favorite GIS to see the data.

]]

import("gis")
import("publish")


Project{
	file = "brazil.tview",
	clean = true,
	biomes = "../data/br_biomes.shp",
	states = "../data/br_states.shp"
}


Application{
	project = "brazil.tview",
	title = "Brazil Application", -- Manipulando o Title do Template
	description = "Small application with some data related to Brazil.", -- Manipulado o Description do Template
	template = {navbar = "darkblue", title = "white", row = "black"}, -- Manipulando a navbar diretamente no Template
	clean = false,
	output = 'Biomes-Simple-Table', -- Aplicativo de saída

   biomes = View{ --layer
		select = "name", --legend
		color = "Set2",
		description = "Brazilian Biomes, from IBGE.", --descriçao ex: Biomes (...)
		download = true,
		report = function(cell)
		local mreport = Report{ --
				title = cell.name,  -- "name" is an attribute of object
				author = "IBGE",
				print(cell.name, cell.link, cell.cover)
		}



        mreport:addImage(filePath("biomes/"..cell.name..".jpg", "publish"))
        mreport:addText("For more information, please visit "..link(cell.link, "here")..".")




        ------ Creat Table -----------

        local TABELA = {
                title = { "Dados de "..cell.name},
                th = {
                     Col1 = "coluna01",
                     Col2 = "coluna02",
                     Col3 = "coluna03",
                     Col4 = "coluna04",
                     Col5 = "coluna05",
                    },

                td = {

                      {Col1 = cell.name, Col2 = cell.name, Col3 = cell.name, Col4 = cell.name, Col5 = cell.name, },
                      {Col1 = cell.name, Col2 = cell.name, Col3 = cell.name, Col4 = cell.name, Col5 = cell.name, },
                      {Col1 = cell.name, Col2 = cell.name, Col3 = cell.name, Col4 = cell.name, Col5 = cell.name, },
                      {Col1 = cell.name, Col2 = cell.name, Col3 = cell.name, Col4 = cell.name, Col5 = cell.name, },



                     } -- end td
                } -- end table

           mreport:addTable(TABELA)


                ------ End Creat Table -----------


           -- Creat mult datas in line

           mreport:addMult{ cell.name, cell.cover, cell.link}


			return mreport

		end
	},


}