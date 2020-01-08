--[[ [previous](04-brazil-states.lua) | [contents](../00-contents.lua) | [next](../arapiuns/06-arapiuns-project.lua)

Finally, we now add a [Report](http://www.terrame.org/packages/doc/publish/doc/files/Report.html) to each biome. When a View has a report, it creates
a report to each of its geometries using the attributes of the respective
geometry. A report is then activated when one clicks on a given object in the
application. The code below adds an image to the report and use other attributes
as text. Open the shapefile in your favorite GIS to see the data.

]]


import("publish")


Application{
	project = filePath("brazil.tview", "publish"),
	title = "Brazil Application",
	description = "Small application with some data related to Brazil.",
	template = {navbar = "darkblue", title = "white"},
	clean = false,
	output = 'simple_table_01',

	biomes = View{
		select = "name",
		color = "Set2",
		description = "Brazilian Biomes, from IBGE.",
		download = true,
		report = function(cell)
		local mreport = Report{
				title = cell.name,
				author = "IBGE",
				print(cell.name, cell.link, cell.cover)
		}


           mreport:addImage(filePath("biomes/"..cell.name..".jpg", "publish"))
           mreport:addText("For more information, please visit "..link(cell.link, "here")..".")

           ------ Creat Table -----------
           local TABLE = {
					title = { "Data of "..cell.name},
					th = {
                         Col1 = "Title Column01",
                         Col2 = "Title Column02",
                         Col3 = "Title Column03",
                         Col4 = "Title Column04",
                         Col5 = "Title Column05",
                     }, --end th
					td = {
                         {Col1 = cell.name, Col2 = cell.name, Col3 = cell.name, Col4 = cell.name, Col5 = cell.name, },
                         {Col1 = cell.name, Col2 = cell.name, Col3 = cell.name, Col4 = cell.name, Col5 = cell.name, },
                         {Col1 = cell.name, Col2 = cell.name, Col3 = cell.name, Col4 = cell.name, Col5 = cell.name, },
                         {Col1 = cell.name, Col2 = cell.name, Col3 = cell.name, Col4 = cell.name, Col5 = cell.name, },
                     } -- end td
                  } -- end table

            mreport:addTable(TABLE)
            ------ End Creat Table -----------
            -- Creat mult datas in line
            mreport:addMult{ cell.name, cell.cover, cell.link}

            return mreport
		end
	},

}