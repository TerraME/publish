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

data{
	file = "temporal-data.shp",
	summary = "Test of temporal data to create graphic and table.",
	source = "CCST.",
	attributes = {
		id = "Identifying of label.",
		col = "Column.",
		row	= "Row.",
		f = "Identifier f.",
		d = "Identifier d.",
		outros = "outhers.",
		[{"f16", "d16", "ag_slope_1", "e_roads", "e_proads", "e_railway", "e_connmkt", "e_hidro", "e_beef", "e_wood", "e_soysug", "e_min", "e_urban100",
			"as_pland_s", "as_pland_m", "as_pland_b", "c_sett11" ,"c_nsett11" ,"c_hidreopc" ,"c_ucpi12" ,"c_ussapa12"}] = "Temporal data test bloc 1.",
		deterCR = "Deter.",
		[{"p19class27", "d_recente", "CAR_vazio", "f_recente", "e_urban10", "drec","frec", "OBJECTID", "Join_Cou_1", "TARGET_F_1"}] = "Test data bloc 1.",
		id_1 = "Identifier id 1.",
		col_1 = "Identifier col 1.",
		row_1 = "Identifier row_1.",
		[{"d_inita", "d_area02", "d_area03","d_area04", "d_area05", "d_area06", "d_area07", "d_area08", "d_area09", "d_area10", "d_area11", "d_area12",
			"d_area13", "d_area14", "d_area15"}] = "Temporal data test bloc 2.",
		[{"dg_darea06", "dg_darea07", "dg_darea08", "dg_darea09", "dg_darea10", "dg_darea11", "dg_darea12"}] = "Temporal data test bloc 3.",
		[{"B2nd", "b2_agb", "AGB3rd", "BGB3rd", "DW3rd", "Litter3rd", "soma_dg"}] = "Test data bloc 2.",
		[{"dg_darea13", "dg_darea14"}] = "Temporal data test bloc 4.",
		[{"b3_agb","B2ndM100"}] = "Test data bloc 3.",
		[{"b3_perc1", "b3_perc2", "b3_perc3"}] = "Temporal data test bloc 5.",
		[{"d_area16", "d_inita01", "d_forest"}] = "Temporal data test bloc 6.",
		forest02 = "Forest 02.",
		b12	= "Test data b12.",
		forest06 = "Forest 06.",
		[{"d_inita05", "b4_agb", "O", "soma_d"}] = "Test data bloc 4.",
		[{"AGB3rdM70", "BGB3rdM70"}] = "Temporal data test bloc 7.",
		[{"Lit3rdM70", "DW3rdM70", "AGB3M70cor"}] = "Test data bloc 5.",
		[{"for06_test", "for06_area"}] = "Temporal data test bloc 8.",
		[{"averAGBDeg", "b12_3rdInv"}] = "Test data bloc 6.",
		[{"dg_darea15", "dg_darea16", "dg_darea17", "dg_darea18", "dg_darea19"}] = "Temporal data test bloc 9.",
		[{"Shape_Leng", "Shape_Area"}] = "Temporal data test bloc 10.",
		[{"mcwd06", "mcwd07", "mcwd08", "mcwd09", "mcwd10", "mcwd11", "mcwd12", "mcwd13", "mcwd14", "mcwd15", "mcwd16"}] = "Temporal data test bloc 11.",
		[{"log_pDG06", "dAcc_ant", "pDG06", "TIndigena", "area_disp"}] = "Test data bloc 7.",
		[{"pTrjCrRaso", "pTrjDegrad", "pTrjRegen"}] = "Temporal data test bloc 12.",
		[{"log_CrRaso", "log_Degrad", "log_Regen"}] = "Temporal data test bloc 13.",
		min_mcwd = "Identifier MCWD.",
	}
}
