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


