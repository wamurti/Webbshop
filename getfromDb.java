package webshoppen;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.*;
import java.util.Properties;

public class getfromDb {

    static void getSvartByxa() throws IOException {

        Properties p = new Properties();
        p.load(new FileInputStream("src/webshoppen/Settingss.properties"));
        try (Connection con = DriverManager.getConnection(
                p.getProperty("connectionString"),
                p.getProperty("name"),
                p.getProperty("password"));
             PreparedStatement stmt =  con.prepareStatement("select kund.förnamn, kund.efternamn from produktMärke inner join produktberoenden on produktMärke.id = produktMärkeId inner join produktStorlek on produktStorlek.id = produktstorlekId inner join produkt on produktberoenden.id = produktBeroendeId inner join produktbeställning on produkt.id = produktId inner join beställning on beställningsId = beställning.id inner join kund on kundId=kund.id where produktmärke.namn = 'SweetPants' and produktstorlek.namn='38';")){
            ResultSet rs=stmt.executeQuery();
            while (rs.next()) {

                String fnamn = rs.getString("förnamn");
                String enamn = rs.getString("efternamn");


                System.out.println(fnamn+" "+enamn);

            }

        }catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
    }

    static void produkterPerKat() throws IOException {

        Properties p = new Properties();
        p.load(new FileInputStream("src/webshoppen/Settingss.properties"));
        try (Connection con = DriverManager.getConnection(
                p.getProperty("connectionString"),
                p.getProperty("name"),
                p.getProperty("password"));
             PreparedStatement stmt =  con.prepareStatement("select kategori.namn as kategoriNamn,count(kategori.id) as antal from kategori inner join produktkategori on kategori.id = kategoriId inner join produkt on produkt.id=produktId group by kategori.namn;")){
            ResultSet rs=stmt.executeQuery();
            while (rs.next()) {

                String kategoriNamn = rs.getString("kategoriNamn");
                int antal = rs.getInt("antal");
                System.out.println(kategoriNamn+" "+antal);
            }

        }catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
    }

    static void kundLista() throws IOException {

        Properties p = new Properties();
        p.load(new FileInputStream("src/webshoppen/Settingss.properties"));
        try (Connection con = DriverManager.getConnection(
                p.getProperty("connectionString"),
                p.getProperty("name"),
                p.getProperty("password"));
             PreparedStatement stmt =  con.prepareStatement("select kund.förnamn,kund.efternamn,sum(produkt.pris) as HandlatFör from kund inner join beställning on kund.id = kundId inner join produktbeställning on beställning.id = beställningsId inner join produkt on produkt.id = produktId group by kund.id;")){
            ResultSet rs=stmt.executeQuery();
            while (rs.next()) {

                String fnamn = rs.getString("förnamn");
                String enamn = rs.getString("efternamn");
                int handlat = rs.getInt("HandlatFör");
                System.out.println(fnamn+" "+enamn+" har handlat för "+handlat);
            }

        }catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
    }

    static void bestPerOrt() throws IOException {

        Properties p = new Properties();
        p.load(new FileInputStream("src/webshoppen/Settingss.properties"));
        try (Connection con = DriverManager.getConnection(
                p.getProperty("connectionString"),
                p.getProperty("name"),
                p.getProperty("password"));
             PreparedStatement stmt =  con.prepareStatement("select kund.adress,sum(produkt.Pris) as HandlatFör from kund inner join beställning on kund.id = kundId inner join produktbeställning on beställning.Id = beställningsId inner join produkt on produkt.id = produktId group by kund.adress having HandlatFör >= 1000;")){
            ResultSet rs=stmt.executeQuery();
            while (rs.next()) {

                String adress = rs.getString("adress");
                int handlat = rs.getInt("HandlatFör");
                System.out.println(adress+" "+handlat);
            }

        }catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
    }

    static void toppFem() throws IOException {

        Properties p = new Properties();
        p.load(new FileInputStream("src/webshoppen/Settingss.properties"));
        try (Connection con = DriverManager.getConnection(
                p.getProperty("connectionString"),
                p.getProperty("name"),
                p.getProperty("password"));
             PreparedStatement stmt =  con.prepareStatement("select count(produktId) as AntalSålda,namn from produktbeställning inner join produkt on produkt.id = produktId inner join produktBeroenden on produktBeroenden.id =produktBeroendeId inner join produktNamn on produktNamnId = produktNamn.Id group by namn order by AntalSålda desc;")){
            ResultSet rs=stmt.executeQuery();
            while (rs.next()) {

                String namn = rs.getString("namn");
                int antalSålda = rs.getInt("AntalSålda");
                System.out.println(namn+" "+antalSålda);
            }

        }catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
    }
    static void månadFörsäljning() throws IOException {

        Properties p = new Properties();
        p.load(new FileInputStream("src/webshoppen/Settingss.properties"));
        try (Connection con = DriverManager.getConnection(
                p.getProperty("connectionString"),
                p.getProperty("name"),
                p.getProperty("password"));
             PreparedStatement stmt =  con.prepareStatement("select sum(produkt.Pris) as HandladesFör, month(datum) as Månad from beställning inner join produktbeställning on beställning.Id = BeställningsId inner join produkt on produkt.Id=ProduktId GROUP BY MONTH(Datum) order by HandladesFör desc;")){
            ResultSet rs=stmt.executeQuery();
            while (rs.next()) {

                String månad = rs.getString("Månad");
                int handladesFör = rs.getInt("HandladesFör");
                System.out.println(månad+" "+handladesFör);
            }

        }catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
    }

}
