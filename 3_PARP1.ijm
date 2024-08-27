//CZESC PRZYGOTOWAWCZA

//maska dla jądra
title = getTitle()
run("Duplicate...", "duplicate");
setAutoThreshold("Li dark no-reset");

//run("Threshold...");
setOption("BlackBackground", true);
run("Convert to Mask", "method=Li background=Dark calculate black");

//nalozenie maski na obraz oryginalny i obliczenie sredniej jasnosci + zachowanie tej jasności w jakiejś zmiennej
run("Rename...");

//odjęcie tła,zduplikowanie obrazu
run("Image Calculator...");
run("Duplicate...", "duplicate");

//wybranie obrazu, ustawienie maski jądra
setAutoThreshold("Li dark no-reset");

// Oblicz średnią jasność i usuń dane z roimanagera
run("Analyze Particles...", "size=10-Infinity show=Outlines display clear include summarize overlay add composite stack");

path_save=getDirectory("Zapisz wyniki parametrów jądra komórkowego HPF1");
saveAs("Results", path_save + File.separator + title +"_wyniki_jądro_kom" + ".csv");
roiManager("delete");

close()
close()

//OBLICZENIE ŚREDNIEJ JASNOSCI JADRA Z CAŁEGO TIME SERIES

// Inicjalizacja zmiennej przechowującej sumę jasności
totalBrightness = 0;

// Przechodzimy przez każdy wiersz w tabeli "Results"
for (row = 0; row < nResults(); row++) {
    // Pobieramy jasność jądra komórkowego z kolumny "Mean" w tabeli "Results"
    brightness = getResult("Mean", row);

    // Dodajemy jasność do sumy
    totalBrightness += brightness;
}

// Obliczanie średniej jasności
meanBrightness = totalBrightness / nResults();

//zamkniecie okna z wynikami jasnosci jądra
close("Results");

 
//CZESC WLASCIWA
// Ustaw parametry
maxSlices = nSlices;  // Liczba slice'ów w obrazie


waitForUser("wybierz obraz z foci do wygenerowania maski");

// Pętla po wszystkich slice'ach
for (slice = 1; slice <= maxSlices; slice++) {
    
                
        //Utwórz zaznaczenie i przenieś zaznaczenie na następny slice
       	setThreshold(meanBrightness*1.25, 255); // Progowanie wokół meanInFoci
        	
    	//przesuń do następnego slice
    	run("Next Slice [>]");
        	
    	// Aktualizuj listę maksimów
        run("Find Maxima...", "prominence=50 output=List");
        
        }
        
run("Convert to Mask", "black create");
run("Dilate", "stack");
run("Dilate", "stack");
run("Fill Holes", "stack");
run("Erode", "stack");
run("Erode", "stack");



//maska z poprzedniego punktu - trzymać się jej do końca slice
//albo przeskoczyć jeden slice
//albo wziąć maske z poprzedniego slice'a