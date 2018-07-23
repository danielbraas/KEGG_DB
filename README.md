<h1>KEGG_DB</h1>
<h2>Functions to work with KEGG</h2>

This repository will show how to work with the KEGGREST library to import and manipulate data coming from the KEGG database.
Essentially, the code will show how to use the KEGG database REST API to download information about all compounds listed in 
the KEGG database, as well as information about all human and mouse metabolic pathways. The compound data will be the used to 
parse out information about the KEGG ID, formula and monoisotopic mass of each compound. This data frame will subsequently be 
used to generate 46 ion clusters from each compound using the calculations described in: 
<a href="http://dx.doi.org/10.1016/S1044-0305(99)00089-6"> Huang N.; Siegel M.M.1; Kruppa G.H.; Laukien F.H. 
<i>J Am Soc Mass Spectrom</i> <u>1999</u>, <b>10</b>, 1166–1173. Automation of a Fourier transform ion cyclotron resonance mass spectrometer for acquisition, analysis, 
and e-mailing of high-resolution exact-mass electrospray ionization mass spectral data.</a>
taken from <a href = "http://fiehnlab.ucdavis.edu/staff/kind/Metabolomics/MS-Adduct-Calculator">http://fiehnlab.ucdavis.edu/staff/kind/Metabolomics/MS-Adduct-Calculator</a>.

