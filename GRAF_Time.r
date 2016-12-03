ils_lns_data <- "/Users/XXX/Documents/GitHub/met2_lns/data/FINAL_ILS_x_LNS/ils_lns_data.dat";
instances_module_data <- "/Users/XXX/Documents/GitHub/met2_lns/data/INSTANCIAS/instances_module_dep.dat";

ils_lns_table <- read.table(ils_lns_data, header = TRUE, sep = ";");
instances_table <- read.table(instances_module_data, header = TRUE, sep = ";");

instanceGroups = unique(table$INSTANCE)

#for(currentGroup in 1:length(instanceGroups)){
  data <- subset(table, table$GROUP == 1);
  LNS_data <- order(subset(data, data$SOLVER == "LNS");  
  #ILS_data <- subset(data, data$SOLVER == "ILS");
  
 
  
  Times <- cbind(LNS_data$TIME, LNS_data$MQ);
  plot(Times);
  #ILSTime <- subset(ILS_data, ILS_data$TIME);
#}


  
#  LNS_data <- subset(data, data$SOLVER == "LNS");  
# ILS_data <- subset(data, data$SOLVER == "ILS");
  
# ILS_data;
  
# instanceGroups = unique(table$GROUP)
  
  #for(currentGroup in 1:length(instanceGroups))
  #{
    
#   LNSscore <- 0;
#   ILSScore <- 0;
#   
#   LNSValues <- subset(LNS_data, LNS_data$GROUP == 1);
#   ILSValues <- subset(ILS_data, ILS_data$GROUP == 1);
    
#   LNSTime <- subset(LNSValues, LNSValues$TIME);
#   ILSTime <- subset(ILSValues, ILSValues$TIME);
#  
#   return (ILSTime);