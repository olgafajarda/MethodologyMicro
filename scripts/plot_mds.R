#!/usr/bin/env Rscript

# read the data frame with the expressions
# replace name_datasets with "asd" for the usecase of autism spectrum disorder
name_dataset="hf"
nl<-scan(paste(name_dataset,"_id.txt",sep=""),what=character())
nc<-scan(paste(name_dataset,"_samples.txt",sep=""),what=character())

#replace face with "after_rem_batch_combat.txt" for combat dataset or with "after_rem_batch_fsva.txt" for fsva dataset
fase = "_before_rem_batch.txt"
df<-read.table(paste(name_dataset,fase,sep=""),header=FALSE,sep="\t",dec=".",row.names=nl,col.names=nc)
df<-as.data.frame(t(df))

# read the class of every sample (D: diseased or Z: control)
tipo<-factor(scan(paste(name_dataset,"_type.txt",sep=""),what=character()))
tipo2<-1:length(tipo)
for(i in 1:length(tipo)){
  if(tipo[i]=='D'){
    tipo2[i]<-name_dataset
  } else {
    tipo2[i]<-"Control"
  }
}
tipo2<-factor(tipo2)

# read the platform used to obtain the expression of a sample
platform<-factor(scan(paste(name_dataset,"_platform.txt",sep=""),what=character()))

# calculate the distances
d <- dist(df)
mds<-cmdscale(d)

# chose the colours and shapes of the points
cols=c('red', 'blue', 'black')
shps = c(16, 3)

# plot mds
par(mar=c(5.1, 4.1, 4.1, 12.0), xpd=TRUE)
plot(mds, col=cols[platform], pch=shps[tipo2], asp=1, xlab = "", ylab = "", main="MDS plot") 
legend("topright", col=cols, inset=c(-0.30,0), legend=levels(platform), pch = 16, cex = 0.9, title="Platforms")
legend('right', legend=levels(tipo), pch = shps, cex = 0.95, inset=c(-0.30,0), title="Samples' type")

