library(ggplot2)
library(dplyr)

dev.new(width=4,height=3)

# =================================================
# PLANAR GRAPHS
# =================================================

rawData = read.csv(file="results/29Dec14-1444.planar-graph-vX-n100.dat/summary.dat",header=FALSE,sep="\t")
meanData = rawData %>% group_by(V1,V2) %>% summarise(average=mean(V4),sd=sd(V4),min=min(V4),max=max(V4))
meanData = mutate(meanData, Algorithm=V1)
ggplot(meanData,aes(x=V2,y=average,group=Algorithm,shape=Algorithm,color=Algorithm)) + 
       geom_line(aes(linetype=Algorithm),size=0.75) +
#       geom_errorbar(aes(ymin=min,ymax=max)) +
       geom_point(size=1.5, fill="white") +
       ggtitle("Random Planar Graphs") +
       xlab("|V|") +
       ylab("Mean Time / s") +
       coord_cartesian(ylim=c(0,50))

ggsave("Exp1_planar_graphs.pdf")

# =================================================
# Regular3 GRAPHS
# =================================================

rawData = read.csv(file="results/29Dec14-1446.reg3vX.dat/summary.dat",header=FALSE,sep="\t")
meanData = rawData %>% group_by(V1,V2) %>% summarise(average=mean(V4),sd=sd(V4))
meanData = mutate(meanData, Algorithm=V1)
ggplot(meanData,aes(x=V2,y=average,group=Algorithm,shape=Algorithm,color=Algorithm)) + 
       geom_line(aes(linetype=Algorithm),size=0.75) +
       geom_point(size=1.5, fill="white") +
       ggtitle("Random 3-Regular Graphs") +
       xlab("|V|") +
       ylab("Mean Time / s") +
       coord_cartesian(ylim=c(0,50))

ggsave("Exp1_reg3_graphs.pdf")

# =================================================
# Regular4 Graphs
# =================================================

rawData = read.csv(file="results/29Dec14-1447.reg4vX.dat/summary.dat",header=FALSE,sep="\t")
meanData = rawData %>% group_by(V1,V2) %>% summarise(average=mean(V4),sd=sd(V4))
meanData = mutate(meanData, Algorithm=V1)
ggplot(meanData,aes(x=V2,y=average,group=Algorithm,shape=Algorithm,color=Algorithm)) + 
       geom_line(aes(linetype=Algorithm),size=0.75) +
       geom_point(size=1.5, fill="white") +
       ggtitle("Random 4-Regular Graphs") +
       xlab("|V|") +
       ylab("Mean Time / s") +
       coord_cartesian(ylim=c(0,50))

ggsave("Exp1_reg4_graphs.pdf")

# =================================================
# Random v12
# =================================================

rawData = read.csv(file="results/29Dec14-1447.random-connected-v12-eX.dat/summary.dat",header=FALSE,sep="\t")
meanData = rawData %>% group_by(V1,V3) %>% summarise(average=mean(V4),sd=sd(V4))
meanData = mutate(meanData, Algorithm=V1)
ggplot(meanData,aes(x=V3,y=average,group=Algorithm,shape=Algorithm,color=Algorithm)) + 
       geom_line(aes(linetype=Algorithm),size=0.75) +
       geom_point(size=1.5, fill="white") +
       ggtitle("Random Graphs (|V|=12)") +
       xlab("|E|") +
       ylab("Mean Time / s") +
       coord_cartesian(ylim=c(0,5))

ggsave("Exp1_random12_graphs.pdf")

# =================================================
# Random v14
# =================================================

rawData = read.csv(file="results/29Dec14-1447.random-connected-v14-eX.dat/summary.dat",header=FALSE,sep="\t")
meanData = rawData %>% group_by(V1,V3) %>% summarise(average=mean(V4),sd=sd(V4))
meanData = mutate(meanData, Algorithm=V1)
ggplot(meanData,aes(x=V3,y=average,group=Algorithm,shape=Algorithm,color=Algorithm)) + 
       geom_line(aes(linetype=Algorithm),size=0.75) +
       geom_point(size=1.5, fill="white") +
       ggtitle("Random Graphs (|V|=14)") +
       xlab("|E|") +
       ylab("Mean Time / s") +
       coord_cartesian(ylim=c(0,50))

ggsave("Exp1_random14_graphs.pdf")

# =================================================
# Random v16
# =================================================

rawData = read.csv(file="results/29Dec14-1447.random-connected-v16-eX.dat/summary.dat",header=FALSE,sep="\t")
meanData = rawData %>% group_by(V1,V3) %>% summarise(average=mean(V4),sd=sd(V4))
meanData = mutate(meanData, Algorithm=V1)
ggplot(meanData,aes(x=V3,y=average,group=Algorithm,shape=Algorithm,color=Algorithm)) + 
       geom_line(aes(linetype=Algorithm),size=0.75) +
       geom_point(size=1.5, fill="white") +
       ggtitle("Random Graphs (|V|=16)") +
       xlab("|E|") +
       ylab("Mean Time / s") +
       coord_cartesian(ylim=c(0,150))

ggsave("Exp1_random16_graphs.pdf")
