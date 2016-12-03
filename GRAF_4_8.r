ils_lns_data <- "/Users/CrystiamKelle/Documents/GitHub/met2_lns/data/FINAL_ILS_x_LNS/ils_lns_data.dat";
instances_module_data <- "/Users/CrystiamKelle/Documents/GitHub/met2_lns/data/INSTANCIAS/instances_module_dep.dat";
tabela = compareTimeByInstanceGroupSize(ils_lns_data, instances_module_data);

l <- list(unique(tabela$GROUP));


for(i in 1:length(l)){ 
  
  modulos = 0:0;
 step = 0;
 ticks = c();
 titulo = "";
  
 if(i == 1){
   modulos = 0:74;
   mult = 0.1;
   step = 10;
   titulo = "Categoria Pequena";
 }else if(i == 2){
   modulos = 79:182;
   mult = 0.5;
   step = 20;
   titulo = "Categoria M?dia";
 }else if(i == 3){
   modulos = 190:377;
   mult = 5;
   step = 50;
   titulo = "Categoria Grande";
 }else{
   modulos = 400:1400;
   mult = 500;
   step = 200;
   titulo = "Categoria Muito Grande";
 }
  
 cont = 0;
 for (t in 0:5){
   ticks = append(ticks, (t*mult));
   cont = cont + 1;
}
 
 linha = subset(tabela, tabela$GROUP == i);
  
 xrange <- range(modulos);
 yrange <- range(ticks);
  
 plot(xrange, yrange, type="n", xlab="Qtde. Modulos", ylab="Tempo(s)", axes = FALSE, ann = TRUE, main = titulo);
  
   box();
 axis(1, at = step*0:xrange[2])
 axis(2, at = ticks)
  
 points(linha$MODULO, linha$MEDIA_TIME_LNS, col="darkblue", pch=3, cex = 0.8)
 points(linha$MODULO, linha$MEDIA_TIME_LNS, col="red", pch=4, cex = 0.8)
}

legend('topright', c("Antes da Redu??o","Depois da Redu??o"), col=c("darkblue", "red"), pch=3:4, bty ="n", cex = 0.7)
View(tabela);
