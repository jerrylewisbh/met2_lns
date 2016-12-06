

#--------------------------------------------------
compareByInstanceGroupSize <- function(file, instanceSize){

table <- read.table(file, header = TRUE, sep = ";");
data <- subset(table, table$GROUP == instanceSize);

ILS_data <- subset(data, data$SOLVER == "ILS");
LNS_data <- subset(data, data$SOLVER == "LNS");


colNames <- c("Instancia", "MEDIA_MQ (LNS)", "MEDIA_MQ (ILS)", "p-VALUE", "ES");
instancesNames <- unique(ILS_data$INSTANCE);
rows <- 1:length(instancesNames);
comparativeTable <- matrix(nrow = length(rows), ncol = length(colNames), dimnames = list(rows, colNames));

tabela = data.frame(comparativeTable);

currentRow <- 1;

for(currentInstance in instancesNames){
  
  currentInstanceLNSValues = subset(LNS_data, LNS_data$INSTANCE == currentInstance);
  currentInstanceILSValues = subset(ILS_data, ILS_data$INSTANCE == currentInstance);
  
  LNSMean = mean(currentInstanceLNSValues$MQ);
  LNSSd   = sd(currentInstanceLNSValues$MQ);

  ILSMean = mean(currentInstanceILSValues$MQ);
  ILSSd   = sd(currentInstanceILSValues$MQ);


  wilcoxonTest = wilcox.test(currentInstanceLNSValues$MQ, currentInstanceILSValues$MQ);

  if(is.nan(wilcoxonTest$p.value)){
    pValue = "-";
  }else if(wilcoxonTest$p.value > 0.001){
    pValue =  round(wilcoxonTest$p.value, digits = 4);
  }else{
    pValue = "< 0.001";
  }
  
  effect_size = vargha.delaney(currentInstanceLNSValues$MQ, currentInstanceILSValues$MQ) * 100;
  effect_size = paste(round(effect_size, digits = 0), "%", sep = "");
  
  comparativeTable[currentRow, 1] <- currentInstance;
  comparativeTable[currentRow, 2] <- paste(round(LNSMean, digits = 4), '±', round(LNSSd, digits = 2), sep='');
  comparativeTable[currentRow, 3] <- paste(round(ILSMean, digits = 4), '±', round(ILSSd, digits = 2), sep='');
  comparativeTable[currentRow, 4] <- pValue;
  comparativeTable[currentRow, 5] <- effect_size;
  
  currentRow <- currentRow + 1;
}


return (comparativeTable);
 
}

#--------------------------------------------------
compareExecutionTime <-function(file){
  
  table <- read.table(file, header = TRUE, sep = ";");

  LNS_data <- subset(table, table$SOLVER == "LNS");  
  ILS_data <- subset(table, table$SOLVER == "ILS");


  colNames <- c("LNS", "ILS", "LNS < ILS", "LNS > ILS")
  rowNames <- c("Pequena", "Média", "Grande", "Muito Grande");

  comparativeTable <- matrix(nrow = length(rowNames), ncol = length(colNames), dimnames = list(rowNames, colNames));
  instanceGroups = unique(table$GROUP)


  for(currentGroup in 1:length(instanceGroups))
  {

    LNSscore <- 0;
    ILSScore <- 0;

    LNSValues <- subset(LNS_data, LNS_data$GROUP == currentGroup);
    ILSValues <- subset(ILS_data, ILS_data$GROUP == currentGroup);

    avgLNSTime <- round((mean(LNSValues$TIME) / 1000), digits = 4);
    avgILSTime <-round((mean(ILSValues$TIME) / 1000), digits = 4);

    
    groupInstances = unique(LNSValues$INSTANCE);

    for(instanceName in groupInstances){
      
      currentLNS = subset(LNSValues, LNSValues$INSTANCE == instanceName);
      currentILS = subset(ILSValues, ILSValues$INSTANCE == instanceName);

      currentInstanceLNSAvg = mean(currentLNS$TIME);
      currentInstanceILSAvg = mean(currentILS$TIME);

      if(currentInstanceLNSAvg > currentInstanceILSAvg){
        LNSscore = LNSscore + 1;  
      }else{
        ILSScore = ILSScore + 1;
      }
    }
    

    comparativeTable[currentGroup, 1] = avgLNSTime;
    comparativeTable[currentGroup, 2] = avgILSTime;
    comparativeTable[currentGroup, 3] = ILSScore;
    comparativeTable[currentGroup, 4] = LNSscore;
  }

  return (comparativeTable);


}

#--------------------------------------------------
compareTimeByInstanceGroupSize <- function(instanceFile, moduleFile){
  
  table <- read.table(instanceFile, header = TRUE, sep = ";");
  
  tableModule <- read.table(moduleFile, header = TRUE, sep = ";");
  
  ILS_data <- subset(table, table$SOLVER == "ILS");
  LNS_data <- subset(table, table$SOLVER == "LNS");
  
  
  colNames <- c("GROUP", "MEDIA_TIME_LNS", "MEDIA_TIME_ILS", "MODULO");
  instancesNames <- unique(ILS_data$INSTANCE);
  rows <- 1:length(instancesNames);
  comparativeTable <- matrix(nrow = length(rows), ncol = length(colNames), dimnames = list(instancesNames, colNames));
  
  for(i in rows){
    for(j in 1:length(colNames)){
      comparativeTable[i, j]  = 0;
    }
  }
  comparativeTable = data.frame(comparativeTable);
  
  currentRow <- 1;
  
  for(currentInstance in instancesNames){
    
    currentInstanceLNSValues = subset(LNS_data, LNS_data$INSTANCE == currentInstance);
    currentInstanceILSValues = subset(ILS_data, ILS_data$INSTANCE == currentInstance);
    
    LNSMean = mean(currentInstanceLNSValues$TIME);
    
    ILSMean = mean(currentInstanceILSValues$TIME);
    
    module = subset(tableModule, tableModule$INSTANCE == currentInstance);


    comparativeTable[currentRow, 1] <- unique(currentInstanceLNSValues$GROUP);
    comparativeTable[currentRow, 2] <- paste(round((mean(LNSMean) / 1000), digits = 4), sep='');
    comparativeTable[currentRow, 3] <- paste(round((mean(ILSMean) / 1000), digits = 4), sep='');
    comparativeTable[currentRow, 4] <- module$MODULES_pre;
    
    currentRow <- currentRow + 1;
  }
  return (comparativeTable);
  
}

#--------------------------------------------------
GraphByCategory <- function(tabela){
  par(mfrow=c(2,2))
  
  groupCod <- c(unique(tabela$GROUP));
  
  #parametros para a geração dos gráficos
  title <- c("Categoria Pequena", " Categoria Média", "Categoria Grande", "Categoria Muito Grande");
  axisX <- c(10, 20, 50, 200);
  mult <- c(0.1, 0.5, 5,500);
  
  for(i in 1:length(groupCod)){ 
    axisY = c();
    
    cont = 0;
    for (t in 0:4){
      axisY = append(axisY, (t*mult[i]));
      cont = cont + 1;
    }
    
    
    linha = subset(tabela, tabela$GROUP == i);
    
    a <- min(linha$MODULO);
    b <- max(linha$MODULO);
    
    xrange <- range(a:b);
    yrange <- range(axisY);
    
    plot(xrange, yrange, type="n", xlab="Quantidade de Módulos", ylab="Tempo(s)", yaxs="r", axes = FALSE, ann = TRUE, main = title[i]);
    
    box();
    axis(1, at = axisX[i]*0:xrange[2])
    axis(2, at = axisY)
    
    par("usr")
    
    points(linha$MODULO, linha$MEDIA_TIME_LNS, col="darkblue", pch=3, cex = 0.8)
    points(linha$MODULO, linha$MEDIA_TIME_ILS, col="red", pch=4, cex = 0.8)
    
  }
  
  legend('bottom', c("LNS","ILS"), col=c("darkblue", "red"), pch=3:4, bty ="n", cex = 0.7)
}



#------------------------------------------GraphBoxplot - INICIO -----------------------------------------------
GraphBoxplot <- function(instanceFile, parametro){
  tableILS_LNS <- read.table(instanceFile, header = TRUE, sep = ";");
  instanciasList <- list( "lslayout", "seemp", "imapd-1", "elm-1", "exim", "lucent", "dom4j", "pfcda_swing",
                          "jtreeview", "lwjgl-2.8.4", "krb5", "eclipse_jgit");
  
  
  x = c();
  par(mfrow=c(4,3))
  par(mar=c(1,1,1,1))
  
  for(currentInstance in instanciasList){
    tab = subset(tableILS_LNS, tableILS_LNS$INSTANCE == currentInstance);
    if(parametro == "TIME"){
      pm <- tab$TIME / 1000;
    }
    if(parametro == "MQ"){
      pm <- tab$MQ;
    }
    
    ins <- tab$SOLVER;
    boxplot(pm~ins, main = currentInstance, varwidth=TRUE);
    title(ylab = "Value axis", xlab = "Single sample", font.lab = 2)
  }
}
#------------------------------------------GraphBoxplot - FIM -----------------------------------------------