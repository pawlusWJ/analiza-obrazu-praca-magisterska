
title = getTitle()

// Zduplikuj obraz
run("Duplicate...", "duplicate");
run("Duplicate...", "duplicate");

setSlice(5);
// Znajdź maksimum
run("Find Maxima..."); //, "prominence=70 output=[List]");

// Wycięcie fragmentu gdzie znajduje się ognisko - find maxima ma stanowić środek
maximaCount = nResults();
if (maximaCount > 0) {
    // Przygotowanie listy maksimów do wyboru przez użytkownika
    xCoords = newArray(maximaCount);
    yCoords = newArray(maximaCount);
    choices = newArray(maximaCount);
    for (i = 0; i < maximaCount; i++) {
        xCoords[i] = getResult("X", i);
        yCoords[i] = getResult("Y", i);
        choices[i] = "Maksimum " + (i + 1) + ": (" + xCoords[i] + ", " + yCoords[i] + ")";

        // Rysowanie krzyżyków i numerów w miejscach maksimów
        makeRectangle(xCoords[i] - 2, yCoords[i] - 2, 5, 5);
        run("Draw", "color=red");
        drawString("" + (i + 1), xCoords[i] + 5, yCoords[i]);
    }

    // Wyświetlenie dialogu do wyboru maksimum
    Dialog.create("Wybierz maksimum");
    Dialog.addChoice("Maksimum:", choices);
    Dialog.show();
    selectedChoice = Dialog.getChoice();

    // Znalezienie indeksu wybranego maksimum ręcznie
    selectedMaximum = -1;
    for (i = 0; i < maximaCount; i++) {
        if (choices[i] == selectedChoice) {
            selectedMaximum = i;
            break;
        }
    }

    if (selectedMaximum != -1) {
        // Pobranie wybranych współrzędnych
        x = xCoords[selectedMaximum];
        y = yCoords[selectedMaximum];
        
        selectWindow(title);
        

        // Przejście do pierwszej warstwy i przycięcie obrazu
        setSlice(1);
        makeRectangle(x - 50, y - 50, 100, 100);
        run("Crop");
    }
}

close("Results");

run("Duplicate...", "duplicate");