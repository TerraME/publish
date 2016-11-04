# Publish

## Overview
This is a [TerraME](http://terrame.org) package that allows one to export the outputs of different Model scenarios to a web server.

## License
Publish is distributed under the GNU Lesser General Public License as published by the Free Software Foundation. See [publish-license-lgpl-3.0.txt](https://github.com/pedro-andrade-inpe/publish/blob/master/license.txt) for details. 

## Example
(The example below will work after release 0.1)

```lua
import("publish")

Application{
	project = filePath("emas.tview", "terralib"),
	description = "A small example related to a fire spread model.",
	clean = true,
	river = View{
		color = "blue"
	},
	limit = View{
		border = "blue",
		width = 2,
		active = false
	}
	cells = View{
		title = "Emas National Park",
		select = "coverage",
		color = "PuBu",
		value = {0, 1, 2}
	}
}
```
You can see the result in [Emas](https://rawgit.com/hguerra/publish/master/examples/EmasWebMap/index.html).

## Reporting Bugs
If you have found a bug, open an entry in the [issues](https://github.com/pedro-andrade-inpe/publish/issues).
