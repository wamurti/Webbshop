use webshoppen;
-- Vilka kunder har köpt svarta byxor i storlek 38 av märket SweetPants? Lista deras namn och använd inga hårdkodade id-nummer i din fråga.
select kund.förnamn, kund.efternamn
from produktMärke
         inner join produktberoenden
                    on produktMärke.id = produktMärkeId
         inner join produktStorlek
                    on produktStorlek.id = produktstorlekId
         inner join produkt
                    on produktberoenden.id = produktBeroendeId
         inner join produktbeställning
                    on produkt.id = produktId
         inner join beställning
                    on beställningsId = beställning.id
         inner join kund
                    on kundId=kund.id where produktmärke.namn = 'SweetPants' and produktstorlek.namn='38';


-- Lista antalet produkter per kategori. Listningen ska innehålla kategori-namn och antalet produkter.
select kategori.namn as kategoriNamn,count(kategori.id) as antal
from kategori
         left join produktkategori
                   on kategori.id = kategoriId
         inner join produkt
                    on produkt.id=produktId group by kategori.namn;-- group by produkt.id; -- ;

-- Skapa en kundlista med den totala summan pengar som varje kund har handlat för. Kundens för- och efternamn, samt det totala värdet som varje person har shoppats för, skall visas
select kund.förnamn,kund.efternamn,sum(produkt.pris) as HandlatFör
from kund
         inner join beställning
                    on kund.id = kundId
         inner join produktbeställning
                    on beställning.id = beställningsId
         inner join produkt
                    on produkt.id = produktId group by kund.id ;


-- Skriv ut en lista på det totala beställningsvärdet per ort där beställningsvärdet är större än 1000 kr. Ortnamn och värde ska visas. (det måste finnas orter i databasen där det har
-- handlats för mindre än 1000 kr för att visa att frågan är korrekt formulerad)
select kund.adress,sum(produkt.Pris) as HandlatFör
from kund
         inner join beställning
                    on kund.id = kundId
         inner join produktbeställning
                    on beställning.Id = beställningsId
         inner join produkt
                    on produkt.id = produktId group by kund.adress
having HandlatFör >= 1000;

-- Skapa en topp-5 lista av de mest sålda produkterna.
select count(produktId) as AntalSålda,namn
from produktbeställning
         inner join produkt
                    on produkt.id = produktId
         inner join produktBeroenden
                    on produktBeroenden.id =produktBeroendeId
         inner join produktNamn
                    on produktNamnId = produktNamn.Id group by namn order by AntalSålda desc;

-- Vilken månad hade du den största försäljningen? (det måste finnas data som anger försäljning för mer än en månad i databasen för att visa att frågan är korrekt formulerad)
select sum(produkt.Pris) as HandladesFör, month(datum) as Månad
from beställning
    inner join produktbeställning
on beställning.Id = BeställningsId
    inner join produkt
    on produkt.Id=ProduktId GROUP BY MONTH(Datum) order by HandladesFör desc;