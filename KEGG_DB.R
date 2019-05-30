library(tidyverse)

comps <- KEGGREST::keggList('compound') %>% 
  names() %>% 
  str_remove(., 'cpd:')

if (exists('KEGG_DB')){
  
  cpd <- map_chr(KEGG_DB, function(x) x$ENTRY)
  comps <- setdiff(comps, cpd)
  n <- length(KEGG_DB)
  
  for (i in 1:length(comps)) {
    KEGG_DB[[(n + i)]] <- KEGGREST::keggGet(comps[i])[[1]]
    print(i)
  }
  
} else {
  
  for (i in 1:length(comps)) {
    KEGG_DB[[i]] <- KEGGREST::keggGet(comps[i])
    print(i)
  }
}

saveRDS(KEGG_DB, file='KEGG_DB.rds')

#test <- list()
#for (i in 1:length(KEGG_DB)){
#  test[[i]] <- as.list(KEGG_DB[[i]][[1]])
#}
#KEGG_DB <- test


decode_KEGG <- function(x){
  Name <- paste(x$NAME, collapse = '')
  if (is.null(Name)) Name <- NA
  
  KEGG.ID <- x$ENTRY %>% 
    as.character()
  if (is.null(KEGG.ID)) KEGG.ID <- NA
  
  Formula <- x$FORMULA
  if (is.null(Formula)) Formula <- NA
  
  Exact.Mass <- x$EXACT_MASS
  if (is.null(Exact.Mass)) Exact.Mass <- NA
  
  PubChem <- paste(x$DBLINKS, collapse = '_')
  if (is.null(PubChem)) PubChem <- NA
  start <- str_locate(PubChem, 'PubChem(: )?')[2] + 1
  PubChem <- str_sub(PubChem, start = start) 
  end <- str_locate(PubChem, '_')[1] - 1
  PubChem <- str_sub(PubChem, end = end)
  
  MetabDB <- data.frame(Name, KEGG.ID, Formula, Exact.Mass, PubChem)
  return(MetabDB)
}

MetabDB <- suppressWarnings(map_df(KEGG_DB, decode_KEGG))

saveRDS(MetabDB, 'MetabDB.rds')

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
save(hsa_path, file='hsa_path.rda')

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

save(mmu_path, file='mmu_path.rda')
