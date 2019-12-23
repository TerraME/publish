data{
	file = "caragua.shp",
	summary = "Caragua municipality, in Sao Paulo State, Brazil.",
	source = "IBGE (http://www.ibge.gov.br)",
	attributes = {
		population = "Population of Caraguatatuba.",
		pib = "Gross Domestic Product (GDP) of Caraguatatuba.",
		name = "Data name.",
		idh = "HDI indicators of Caraguatatuba."
	}
}

data{
	file = "regions.shp",
	summary = "Caragua municipality divided into three regions.",
	source = "H. Guerra and P. Andrade",
	image = "urbis_regions.png",
	attributes = {
		name = "Regions of Caraguatatuba, North (1), Central (2) and South (3).",
	}
}

data{
	file = "caragua_classes2010_regioes.shp",
	summary = "Social Classe 2010 Real.",
	source = "Feitosa et. al (2014) URBIS-Caraguá: Um Modelo de Simulação Computacional para a Investigação de Dinâmicas de Ocupação Urbana em Caraguatatuba, SP.",
	image = "urbis_2010_real.PNG",
	attributes = {
		classe = "Categorizes the social conditions of households in Caraguatatuba using classes A (3), B (2) or C (1).",
	}
}

data{
	file = "occupational2010.shp",
	summary = "Occupational Classes (IBGE, 2010).",
	source = "Feitosa et. al (2014) URBIS-Caraguá: Um Modelo de Simulação Computacional para a Investigação de Dinâmicas de Ocupação Urbana em Caraguatatuba, SP.",
	image = "urbis_uso_2010.PNG",
	attributes = {
		uso = "The percentage of houses and apartments inside such areas that is typically used in summer vacations and holidays.",
	}
}

data{
	file = "simulation2025_baseline.shp",
	summary = "Baseline simulation for 2025.",
	source = "Feitosa et. al (2014) URBIS-Caraguá: Um Modelo de Simulação Computacional para a Investigação de Dinâmicas de Ocupação Urbana em Caraguatatuba, SP.",
	image = "urbis_simulation_2025_baseline.PNG",
	attributes = {
		classe = "Categorizes the social conditions of households in Caraguatatuba using classes A (3), B (2) or C (1).",
	}
}

data{
	file = "simulation2025_lessgrowth.shp",
	summary = "Less growth simulation in 2025.",
	source = "Feitosa et. al (2014) URBIS-Caraguá: Um Modelo de Simulação Computacional para a Investigação de Dinâmicas de Ocupação Urbana em Caraguatatuba, SP.",
	image = "urbis_simulation_2025_lessgrowth.PNG",
	attributes = {
		classe = "Categorizes the social conditions of households in Caraguatatuba using classes A (3), B (2) or C (1).",
	}
}

data{
	file = "simulation2025_plusgrowth.shp",
	summary = "Plus growth simulation in 2025.",
	source = "Feitosa et. al (2014) URBIS-Caraguá: Um Modelo de Simulação Computacional para a Investigação de Dinâmicas de Ocupação Urbana em Caraguatatuba, SP.",
	image = "urbis_simulation_2025_plusgrowth.PNG",
	attributes = {
		classe = "Categorizes the social conditions of households in Caraguatatuba using classes A (3), B (2) or C (1).",
	}
}

data{
	file = "simulation2025_poorer.shp",
	summary = "Poorer people in Caragua in 2025.",
	source = "Feitosa et. al (2014) URBIS-Caraguá: Um Modelo de Simulação Computacional para a Investigação de Dinâmicas de Ocupação Urbana em Caraguatatuba, SP.",
	image = "urbis_simulation_2025_poorer.PNG",
	attributes = {
		classe = "Categorizes the social conditions of households in Caraguatatuba using classes A (3), B (2) or C (1).",
	}
}

data{
	file = "simulation2025_richer_final.shp",
	summary = "Richer people in Caragua in 2025.",
	source = "Feitosa et. al (2014) URBIS-Caraguá: Um Modelo de Simulação Computacional para a Investigação de Dinâmicas de Ocupação Urbana em Caraguatatuba, SP.",
	image = "urbis_simulation_2025_richer.PNG",
	attributes = {
		classe = "Categorizes the social conditions of households in Caraguatatuba using classes A (3), B (2) or C (1).",
	}
}

data{
	file = "arapiuns_traj.shp",
	summary = "Route on the Arapiuns River.",
	source = "Escada et. al (2013) Infraestrutura, Serviços e Conectividade das Comunidades Ribeirinhas do Arapiuns, PA. Technical report, INPE."
}

data{
	file = "AllCmmTab_210316OK.shp",
	summary = "The riverine communities at Arapiuns (PA).",
	source = "Escada et. al (2013) Infraestrutura, Serviços e Conectividade das Comunidades Ribeirinhas do Arapiuns, PA. Technical report, INPE.",
	attributes = {
		Nome = "Name of riverine community.",
		CMM2 = "Name of riverine community.",
		UC = "Conservation Unit.",
		IDDCM = "Age of the community.",
		NPES = "Population of the community.",
		BFAM = "Bolsa Familia.",
		SALE = "Saude e Alegria NGO.",
		INST = "Governmental institutions.",
		NASSOC = "Local institutions.",
		ENERGIA = "Energy.",
		AGUA = "Water.",
		LIXO = "Garbage collection.",
		ORELHAO = "Telephone.",
		CFUT = "Soccer field.",
		IGREJAS = "Church.",
		PSAU = "Health center of riverine settlements at Arapiuns.",
		ENSINF = "The schools of riverine settlements at Arapiuns.",
		ENSFUND2 = "The schools of riverine settlements at Arapiuns.",
		MERENDA = "Lunch at schools.",
		EJA = "The schools of riverine settlements at Arapiuns.",
		ARROZ = "Rice.",
		MAND = "Manioc.",
		FRUTAS = "Fruits.",
		CASTANHA = "Chestnut.",
		ACAI = "Acai.",
		PESCA = "Fischery.",
		CACA = "Hunting.",
		GADO = "Cattle.",
		MINERACAO = "Mining.",
		MANT = "Where people usually buy food.",
		ICON = "The name of marker icon."
	}
}

data{
	file = "br_biomes.shp",
	summary = "Brazilian biomes.",
	source = "IBGE",
	attributes = {
		name = "Name of the biome.",
		link = "Link to a Wikipedia page with the description of the biome.",
		cover = "Percentage of Brazil's area covered by the biome."
	}
}

data{
	file = "br_states.shp",
	summary = "Brazilian states.",
	source = "IBGE",
	attributes = {
		NOMEUF2 = "Name of the state.",
		SIGLAUF3 = "An acronym for the state.",
	}
}

data{
	file = "sp_municipalities.shp",
	summary = "Sao Paulo municipalities.",
	source = "IBGE",
	attributes = {
		id = "Unique identifier.",
		nome = "Name of the city.",
		uf = "States of Brazil.",
		pib = "Gross Domestic Product (GDP).",
		populacao = "Population size.",
	}
}

directory{
	name = "arapiuns",
	summary = "Photos of several riverine settlements.",
	source = "Escada et. al (2013) Infraestrutura, Serviços e Conectividade das Comunidades Ribeirinhas do Arapiuns, PA. Technical report, INPE.",
}

directory{
	name = "biomes",
	summary = "A set of images related to Brazilian biomes collected from the Internet.",
	source = "Google and Wikipedia",
}

data{
	file = "caragua_classes2010_regioes.tif",
	summary = "Social Classe 2010 Real.",
	source = "Feitosa et. al (2014) URBIS-Caraguá: Um Modelo de Simulação Computacional para a Investigação de Dinâmicas de Ocupação Urbana em Caraguatatuba, SP.",
	image = "urbis_2010_real.PNG",
	attributes = {
		["0"] = "Categorizes the social conditions of households in Caraguatatuba using classes A (3), B (2) or C (1)."
	}
}

data{
	file = "vegtype_2000_5880.tif",
	summary = "Vegetation Type 2000.",
	source = "Inland, INPE.",
	attributes = {
		["0"] = "Vegetation classes."
	}
}

data{
	file = "uc_federais_2001.shp",
	summary = "Conservation units of Brazil.",
	source = "INCT.",
	attributes = {
		codigoCnuc = "Unique identifier.",
		nome = "Name of the unit.",
		geometriaA = "Geometry.",
		anoCriacao = "Creation year.",
		sigla = "Initials.",
		areaHa = "Area.",
		perimetroM = "Perimeter.",
		atoLegal = "Legal.",
		administra = "Administration.",
		SiglaGrupo = "Group initials.",
		UF = "States of Brazil.",
		municipios = "Municipalities.",
		biomaIBGE = "Biome IBGE.",
		biomaCRL = "Biome CRL.",
		CoordRegio = "Region coordinates.",
		codCat = "Code.",
		codUso = "Code.",
		categoria = "Category.",
		IdUnidade = "Unit id.",
		tipo = "Type.",
	}
}

data{
	file = "uc_federais_2009.shp",
	summary = "Conservation units of Brazil.",
	source = "INCT.",
	attributes = {
		codigoCnuc = "Unique identifier.",
		nome = "Name of the unit.",
		geometriaA = "Geometry.",
		anoCriacao = "Creation year.",
		sigla = "Initials.",
		areaHa = "Area.",
		perimetroM = "Perimeter.",
		atoLegal = "Legal.",
		administra = "Administration.",
		SiglaGrupo = "Group initials.",
		UF = "States of Brazil.",
		municipios = "Municipalities.",
		biomaIBGE = "Biome IBGE.",
		biomaCRL = "Biome CRL.",
		CoordRegio = "Region coordinates.",
		codCat = "Code.",
		codUso = "Code.",
		categoria = "Category.",
		IdUnidade = "Unit id.",
		tipo = "Type.",
	}
}

data{
	file = "uc_federais_2016.shp",
	summary = "Conservation units of Brazil.",
	source = "INCT.",
	attributes = {
		codigoCnuc = "Unique identifier.",
		nome = "Name of the unit.",
		geometriaA = "Geometry.",
		anoCriacao = "Creation year.",
		sigla = "Initials.",
		areaHa = "Area.",
		perimetroM = "Perimeter.",
		atoLegal = "Legal.",
		administra = "Administration.",
		SiglaGrupo = "Group initials.",
		UF = "States of Brazil.",
		municipios = "Municipalities.",
		biomaIBGE = "Biome IBGE.",
		biomaCRL = "Biome CRL.",
		CoordRegio = "Region coordinates.",
		codCat = "Code.",
		codUso = "Code.",
		categoria = "Category.",
		IdUnidade = "Unit id.",
		tipo = "Type.",
	}
}
