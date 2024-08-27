/*
 * makro ma za zadanie zduplikować stack, rozdzielić kanały,  
 * zamknąć kanał z BF
 * zastosować filtr Gaussa
 * odciąć dwa pierwsze slice i zapisać je do wybranego folderu
 * DLA PRAWIDŁOWO ZAREJESTROWANEGO TIME SERIES
 */
run("Duplicate...", "duplicate");
run("Split Channels");
close();

run("Gaussian Blur...", "sigma=2 stack");
//odcięcie i zapisanie 2 pierwszych punktów czasowych przez uszkodzeniem
run("Rename...");
title = getTitle();
run("Duplicate...", "duplicate");
run("Make Subset...", "slices=1-2");

path_save=getDirectory("zapisz pliki substackow ");
saveAs("tiff", path_save + File.separator + title + "_before_damage");
close();
//utworzenie time series po uszkodzeniu
run("Make Subset...", "slices=1-2 delete do_not");
