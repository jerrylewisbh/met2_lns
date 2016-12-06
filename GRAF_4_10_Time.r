ils_lns_data <- "/Users/CrystiamKelle/Documents/GitHub/met2_lns/data/FINAL_ILS_x_LNS/ils_lns_data.dat";
tableILS_LNS <- read.table(ils_lns_data, header = TRUE, sep = ";");

#GraphBoxplot(ils_lns_data, "TIME");
GraphBoxplot(ils_lns_data, "MQ");

#instanciasList <- list( "lslayout", "seemp", "imapd-1", "elm-1", "exim", "lucent", "dom4j", "pfcda_swing",
#                 "jtreeview", "lwjgl-2.8.4", "krb5", "eclipse_jgit");

#x = c();
#par(mfrow=c(4,3))
#par(mar=c(1,1,1,1))

#for(currentInstance in instanciasList){
#  tab = subset(tableILS_LNS, tableILS_LNS$INSTANCE == currentInstance);
  
#  time <- tab$TIME / 1000;
# ins <- tab$SOLVER;
#  boxplot(time~ins, main = currentInstance);
#}
