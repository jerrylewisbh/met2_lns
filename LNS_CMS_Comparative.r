

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
    pValue =  wilcoxonTest$p.value;
  }else{
    pValue = "< 0.001";
  }
  
  effect_size = vargha.delaney(currentInstanceLNSValues$MQ, currentInstanceILSValues$MQ) * 100;
  #effect_size = paste(round(a12, digits = 0), "%", sep = "");
  
  comparativeTable[currentRow, 1] <- currentInstance;
  comparativeTable[currentRow, 2] <- paste(LNSMean, '±', LNSSd, sep='');
  comparativeTable[currentRow, 3] <- paste(ILSMean, '±', ILSSd, sep='');
  comparativeTable[currentRow, 4] <- pValue;
  comparativeTable[currentRow, 5] <- paste(effect_size, '%', sep=''); 
  
  currentRow <- currentRow + 1;
}


return (comparativeTable);
 
}


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
