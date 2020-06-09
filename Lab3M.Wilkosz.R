###TASK1###

rm(list=ls())
load("/Users/michalwilkosz/Desktop/Programming-in-R-and-Python/Dmel.RData")
#Complement the sequences
sequence <- chartr("ATCG","TAGC", dmel)
#Counting nucleotides 
nucleotides <- matrix(nrow=length(sequence),ncol=4)
library(stringr)
for (i in 1:length(sequence))
{
  nucleotides[i,1] <- str_count(sequence[i],"A")
  nucleotides[i,2] <- str_count(sequence[i],"T")
  nucleotides[i,3] <- str_count(sequence[i],"C")
  nucleotides[i,4] <- str_count(sequence[i],"G")
}
nucleotides
