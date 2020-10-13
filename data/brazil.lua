
import("gis")

project = Project{
	file = "brazil.tview",
	clean = true,
	biomes = filePath("br_biomes.shp", "publish"),
	states = filePath("br_states.shp", "publish")
}
