#-----------------------generateMQComparativeTable------------------------------

generateMQComparativeTable <- function(dir) {
  
  files <-list.files(dir);
  tableData <-list();
  col <-c("Pontos", "Tempo médio(s)", "% pontos");
  MQ_scores <-matrix();
  for (file_ in files) {
    file <-paste(dir, file_, sep = "");
    tab <-function_read_fixed_param_file(file);
    tableData <-rbind(tableData, tab);
    
    labels <-unique(tab$PARAM_VALUE);
    
    #cria a tabela apenas na primeira iteração
    if (nrow(MQ_scores) == 1) {
      MQ_scores <-matrix(nrow = length(labels), ncol = length(col), dimnames = list(labels, "Valor"=col));
      #inicia a tabela com valores = 0
      for (p in 0: length(labels) - 1) {
        MQ_scores[p, 1] = 0;
      }
    }
    
    #itera tantas vezes quantas foram as execuções do experimento
    n_executions <-(nrow(tab) / 2) - 1;
    for (i in 0: n_executions) {
      
      currentConfig <-subset(tab, tab$N_CONFIG == i);
      maxMQInCurrentConfig <-max(currentConfig$MQ);
      paramWithMaxMQ <-subset(currentConfig, currentConfig$MQ == maxMQInCurrentConfig);
      nameParamWithMaxMQ <-unique(paramWithMaxMQ$PARAM_VALUE);
      
      for (p in nameParamWithMaxMQ) {
        param <-subset(paramWithMaxMQ, paramWithMaxMQ$PARAM_VALUE == p);
        if (param$MQ != param$INITIAL_COST) {
          MQ_scores[p, 1] <-MQ_scores[p, 1] + 1;
        }
      }
    }
  }
  
  for (param in labels) {
    timeExec <-mean(subset(tableData, tableData$PARAM_VALUE == param)$TIME) / 1000;
    MQ_scores[param, 2] = round(timeExec, digits = 4);
    
    percVal <-(MQ_scores[param, 1] * 100) / sum(MQ_scores[, 1]);
    MQ_scores[param, 3] = round(percVal, digits = 2);
    
  }
  return (MQ_scores);
}