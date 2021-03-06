# Gerar Tabelas 4.4, 4.5, 4.6, 4.7, 4.16, 4.17, 4.18, 4.19 e 4.20 e os gráficos 4.8, 4.9 e 4.10. 

#-----------------------Tabela 4.4------------------------
#dir <- "/Users/CrystiamKelle/Documents/GitHub/met2_lns/data/PARAM_01_INITIAL_SOLUTION_METHOD/data/";
#table <- generateMQComparativeTable(dir);
#View(table);

#-----------------------Tabela 4.5------------------------
#dir = "/Users/CrystiamKelle/Documents/GitHub/met2_lns/data/PARAM_02_REPAIR_METHOD/data/";
#table <- generateMQComparativeTable(dir);
#View(table);

#-----------------------Tabela 4.6------------------------
#dir = "/Users/CrystiamKelle/Documents/GitHub/met2_lns/data/PARAM_03_DESTRUTIVE_METHOD/data/";
#table <- generateMQComparativeTable(dir);
#View(table);

#-----------------------Tabela 4.7------------------------
#dir = "/Users/CrystiamKelle/Documents/GitHub/met2_lns/data/PARAM_04_DESTRUCTION_FACTOR/data/";
#table <- generateMQComparativeTable(dir);
#View(table);

#-----------------------EXECUTA TABELAS de 4.16 até 4.19------------------------
#INSTANCE_SIZE <- list(SMALL = 1, MEDIUM = 2, LARGE = 3, EXTRA_LARGE = 4);

#file <- "/Users/CrystiamKelle/Documents/GitHub/met2_lns/data/FINAL_ILS_x_LNS/ils_lns_data.dat";
#table = compareByInstanceGroupSize(file, INSTANCE_SIZE$EXTRA_LARGE);
#View(table);

#-----------------------EXECUTA A TABELA de 4.20------------------------
#table = compareExecutionTime(file);
#View(table);


#-----------------------EXECUTA GRAFICO  de 4.8------------------------
ils_lns_data <- "/Users/CrystiamKelle/Documents/GitHub/met2_lns/data/FINAL_ILS_x_LNS/ils_lns_data.dat";
instances_module_data <- "/Users/CrystiamKelle/Documents/GitHub/met2_lns/data/INSTANCIAS/instances_module_dep.dat";

tabela = compareTimeByInstanceGroupSize(ils_lns_data,  instances_module_data);
#View(tabela);
GraphByCategory(tabela);

#-----------------------EXECUTA GRAFICO  de 4.9 e 4.10------------------------
GraphBoxplot(ils_lns_data, "TIME");
GraphBoxplot(ils_lns_data, "MQ");
