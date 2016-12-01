
#----------------------DISPONIBILIZADAS PELO PROF. MÁRCIO ------------------------------

#OBS1: tabela sem header
function_read_fixed_param_file = function(input_file){
  file_data = read.table(input_file, header=FALSE, sep=";", dec=".", fileEncoding="utf8"
                         ,colClasses=c("character","character","character","integer","integer","double","double","integer","integer","integer", "integer")
  )
  ;
  colnames(file_data) <- c("FIXED_PARAM","PARAM_VALUE","CONFIG","N_CONFIG","N_EXECUTION","INITIAL_COST","MQ","ITERATION_MQ","NO_IMPROVEMENT_MAX_GAP","TIME","TOTAL_CLUSTERS");
  return (file_data);
}

# Calculo de moda
calcModa <- function(v) 
{
  as.numeric(names(sort(-table(v)))[1]);
}

# cramer V and chi-squared test
cramerV <- function(data) 
{
  tempchi <- chisq.test(data);
  chi2 <- unname(tempchi$statistic["X-squared"]);
  pvalue <- unname(tempchi$p.value);
  cv <- sqrt(chi2 / sum(data) / (min(length(data), nrow(data))-1));
  c(effsize = cv, p.value = pvalue, chi2 = chi2);
}

# cohen d
cohenD <- function(data1, data2) 
{
  n1 <- length(data1);
  n2 <- length(data2);
  mean1 <- mean(data1);
  mean2 <- mean(data2);
  sd1 <- sd(data1);
  sd2 <- sd(data2);
  s <- sqrt(((n1 - 1) * sd1 * sd1 + (n2 - 1) * sd2 * sd2) / (n1 + n2 - 2));
  abs(mean1 - mean2) / s;
}

# Vargha & Delaney's A12
vargha.delaney <- function(r1, r2) {
  m <- length(r1);
  n <- length(r2);
  return ((sum(rank(c(r1, r2))[seq_along(r1)]) / m - (m + 1) / 2) / n);
}