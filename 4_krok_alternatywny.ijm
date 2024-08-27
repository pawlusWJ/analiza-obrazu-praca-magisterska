/*
 * makro ma za zadanie zaznaczyć binarne maski z time series i dodać je do roi managera
 * 
 */
for (slice = 1; slice <= nSlices; slice++) {
	setSlice(slice);
	run("Create Selection");
	roiManager("add");
	
}


//makro ma za zadanie zmierzyć jasność foci i zapisać wyniki


path_save=getDirectory("Zapisz wyniki parametrów foci HPF1");
indexes = newArray(roiManager("count") - 1);
waitForUser("wybierz wycinek z ogniskiem");
title = getTitle();
roiManager("measure");

saveAs("Results", path_save + File.separator + title +"_wyniki_foci" + ".csv");
roiManager("delete");
waitForUser("wybierz oryginalny plik");
close("\\Others");
close("Results");
close("Summary of Result*");
