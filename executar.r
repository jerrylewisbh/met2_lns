#importa e executa o arquivo functions.r automaticamente
script.dir <- dirname(sys.frame(1)$ofile)
if(!exists("function_read_fixed_param_file", mode="function")) source(paste(script.dir, "/utils.r",  sep = ""));
if(!exists("generateMQComparativeTable", mode="function")) source(paste(script.dir, "/MQComparative.r",  sep = ""));


#-----------------------Tabela 4.4------------------------
dir = "/data/PARAM_01_INITIAL_SOLUTION_METHOD/data/";

#-----------------------Tabela 4.5------------------------
dir = "/data/PARAM_02_REPAIR_METHOD/data/";

#-----------------------Tabela 4.6------------------------
#dir = "/data/PARAM_03_DESTRUTIVE_METHOD/data/";

#-----------------------Tabela 4.7------------------------

#dir = "/data/PARAM_04_DESTRUCTION_FACTOR/data/";
 

#-----------------------EXECUTA TABELAS ANTERIORES------------------------
table = generateMQComparativeTable(paste(script.dir, dir,  sep = ""));
print(table)
