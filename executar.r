# Gerar Tabelas 4.4, 4.5, 4.6, 4.7, 4.16, 4.17, 4.18, 4.19 e 4.20 e os gráficos 4.8, 4.9 e 4.10. 



#importa e executa o arquivo functions.r automaticamente
script.dir <- dirname(sys.frame(1)$ofile)
if(!exists("function_read_fixed_param_file", mode="function")) source(paste(script.dir, "/utils.r",  sep = ""));
if(!exists("generateMQComparativeTable", mode="function")) source(paste(script.dir, "/MQComparative.r",  sep = ""));
if(!exists("comperaByInstanceGroupSize", mode="function")) source(paste(script.dir, "/LNS_CMS_Comparative.r",  sep = ""));


#-----------------------Tabela 4.4------------------------
dir <- "/data/PARAM_01_INITIAL_SOLUTION_METHOD/data/";

#-----------------------Tabela 4.5------------------------
#dir = "/data/PARAM_02_REPAIR_METHOD/data/";

#-----------------------Tabela 4.6------------------------
#dir = "/data/PARAM_03_DESTRUTIVE_METHOD/data/";

#-----------------------Tabela 4.7------------------------

#dir = "/data/PARAM_04_DESTRUCTION_FACTOR/data/";
 

#-----------------------EXECUTA TABELAS de 4.4 até 4.7------------------------
#table <- generateMQComparativeTable(paste(script.dir, dir,  sep = ""));
#View(table);


#-----------------------EXECUTA TABELAS de 4.16 até 4.19------------------------

INSTANCE_SIZE <- list(SMALL = 1, MEDIUM = 2, LARGE = 3, EXTRA_LARGE = 4);

file <- "/data/FINAL_ILS_x_LNS/ils_lns_data.dat";
#table = compareByInstanceGroupSize(paste(script.dir, file,  sep = ""), INSTANCE_SIZE$EXTRA_LARGE);

table = compareExecutionTime(paste(script.dir, file,  sep = ""));
View(table);