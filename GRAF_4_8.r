ils_lns_data <- "/Users/CrystiamKelle/Documents/GitHub/met2_lns/data/FINAL_ILS_x_LNS/ils_lns_data.dat";
instances_module_data <- "/Users/CrystiamKelle/Documents/GitHub/met2_lns/data/INSTANCIAS/instances_module_dep.dat";
tabela = compareTimeByInstanceGroupSize(ils_lns_data, instances_module_data);

par(mfrow=c(2,2))

groupCod <- c(unique(tabela$GROUP));

#parametros para a geração dos gráficos
title <- c("Categoria Pequena", " Categoria Média", "Categoria Grande", "Categoria Muito Grande");
axisX <- c(10, 20, 50, 200);
mult <- c(0.1, 0.5, 5,500);

for(i in 1:length(groupCod)){ 
 axisY = c();
 
 cont = 0;
 for (t in 0:5){
   axisY = append(axisY, (t*mult[i]));
   cont = cont + 1;
 }
 
 
 linha = subset(tabela, tabela$GROUP == i);
 
 a <- min(linha$MODULO);
 b <- max(linha$MODULO);
  
 xrange <- range(a:b);
 yrange <- range(axisY);

 plot(xrange, yrange, type="n", xlab="Quantidade de Módulos", ylab="Tempo(s)", yaxs="i", axes = FALSE, ann = TRUE, main = title[i]);
  
 box();
 axis(1, at = axisX[i]*0:xrange[2])
 axis(2, at = axisY)
 
 par("usr")
  
 points(linha$MODULO, linha$MEDIA_TIME_LNS, col="darkblue", pch=3, cex = 0.8)
 points(linha$MODULO, linha$MEDIA_TIME_ILS, col="red", pch=4, cex = 0.8)
 
}

legend('topright', c("LNS","ILS"), col=c("darkblue", "red"), pch=3:4, bty ="n", cex = 0.7)