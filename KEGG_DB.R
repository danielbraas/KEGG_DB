library(tidyverse)
library(KEGGREST)


comps <- keggList('compound')

for (i in 1:length(comps)) {
  KEGG_DB[[i]] <- keggGet(names(comps[i]))
  print(i)
}

save(KEGG_DB, file='KEGG_DB.rda')

test <- list()
for (i in 1:length(KEGG_DB)){
  test[[i]] <- as.list(KEGG_DB[[i]][[1]])
}
KEGG_DB <- test



# getting pathway information for Homo sapiens ----------------------------

pathway <- keggList('pathway', 'hsa')

hsa_path <- list()
for (i in 1:length(pathway)){
  hsa_path[[i]] <- keggGet(gsub('path:','',names(pathway[i])))
  print(i)
}

test <- list()
for (i in 1:length(hsa_path)){
  test[[i]] <- as.list(hsa_path[[i]][[1]])
}
hsa_path <- test

# getting Mus musculus pathway --------------------------------------------

pathway <- keggList('pathway', 'mmu')

mmu_path <- list()
for (i in 1:length(pathway)){
  mmu_path[[i]] <- keggGet(gsub('path:','',names(pathway[i])))
  print(i)
}

test <- list()
for (i in 1:length(pathway)){
  test[[i]] <- as.list(mmu_path[[i]][[1]])
}
mmu_path <- test
rm(test)
