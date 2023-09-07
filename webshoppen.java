package webshoppen;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.*;
import java.util.Properties;

import static webshoppen.getfromDb.*;

public class webshoppen {
    public static void main(String[] args) throws IOException {
        System.out.println("*Vilka kunder har köpt svarta byxor i storlek 38 av märket SweetPants? Lista deras namn och använd inga hårdkodade id-nummer i din fråga.*");
        System.out.println();
        getSvartByxa();
        System.out.println();
        System.out.println("*Lista antalet produkter per kategori. Listningen ska innehålla kategori-namn och antalet produkter. *");
        System.out.println();
        produkterPerKat();
        System.out.println();
        System.out.println("*Skapa en kundlista med den totala summan pengar som varje kund har handlat för. Kundens för- och efternamn, samt det totala värdet som varje person har shoppats för, skall visas*");
        System.out.println();
        kundLista();
        System.out.println();
        System.out.println("*Skriv ut en lista på det totala beställningsvärdet per ort där beställningsvärdet är större än 1000 kr. Ortnamn och värde ska visas.*");
        System.out.println();
        bestPerOrt();
        System.out.println();
        System.out.println("*Skapa en topp-5 lista av de mest sålda produkterna.*");
        System.out.println();
        toppFem();
        System.out.println();
        System.out.println("*Vilken månad hade du den största försäljningen?*");
        System.out.println();
        månadFörsäljning();
    }
}
