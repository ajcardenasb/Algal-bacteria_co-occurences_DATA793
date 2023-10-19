# DATA 793

## read bacterial data in and fix rownames

asv=as.data.frame(t(read.table("Documents/Teaching/DATA-793/Documents/inputs/16S.txt", sep = "\t", row.names = 1, header = T)))
asv_tax=read.table("Documents/Teaching/DATA-793/Documents/inputs/16S_tax.txt", sep = "\t", row.names = 1,header = T)
rownames(asv)=gsub("\\.", "-", rownames(asv))

## read algal data in and fix rownames
its2=read.table("Documents/Teaching/DATA-793/Documents/inputs/ITS2.txt", sep = "\t", row.names = 1, header = T)
its2_tax=read.table("Documents/Teaching/DATA-793/Documents/inputs/ITS2_tax.txt", sep = "\t", row.names = 1,header = T)
its2_sub=subset(its2, rownames(its2) %in% rownames(asv))
colnames(its2_sub)=gsub("X", "", colnames(its2_sub) )

## read metadata in and filter out samples that aren’t  present in botwh, the bacterial and algal datasets  
meta=read.table("Documents/Teaching/DATA-793/Documents/inputs/metadata.txt", sep = "\t", row.names = 1, header = T)
meta_sub=subset(meta, rownames(meta) %in% rownames(asv) &  rownames(meta) %in% rownames(its2))

##  filter out bacterial samples that aren’tpresent in the algal dataset 
asv_sub=subset(asv, rownames(asv) %in% rownames(its2))

##  Add column in algal dataset  with clade using the majoritarian ITS2 type
its2_sub_t=as.data.frame(t(its2_sub))
its2_sub_t$Majority_ITS_type=its2_tax$Majority.ITS2.sequence[match(rownames(its2_sub_t), rownames(its2_tax))]
its2_sub_t$Clade=substring(its2_sub_t$Majority_ITS_type, 1, 1)


#write.table(asv_sub, "Documents/Teaching/DATA-793/Documents/inputs/outputs/ASV_table", quote = F, sep = "\t", row.names = T)
#write.table(its2_sub, "Documents/Teaching/DATA-793/Documents/inputs/outputs/ITS2_table", quote = F, sep = "\t", row.names = T)
#write.table(meta_sub, "Documents/Teaching/DATA-793/Documents/inputs/outputs/metadata", quote = F, sep = "\t", row.names = T)



