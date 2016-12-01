data = read.table("/Users/CrystiamKelle/Dropbox/Doutorado/Segundo Semestre/Metodologia Científica 2/Trabalho Final/FINAL_ILS_x_LNS/ils_lns_data.dat", header = TRUE, sep = ";");

lns <- subset(data, data$SOLVER == LNS);
ils <- subset(data, data$SOLVER == ILS);
