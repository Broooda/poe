package main;

import java.util.ArrayList;
import java.util.Arrays;

import javax.swing.JComboBox;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JTextField;
import javax.swing.plaf.basic.BasicInternalFrameTitlePane.MaximizeAction;

public class Macierze {
  private int m, n, ileSztucznych, ileSztucznychOgolem, czyKoniec;
  private int zmienneSztuczne[];
  private double dokladnosc = 100.0;
  private double[][] wspolczynnikiOgraniczen;
  private double[] wspolczynnikiFunkcjiCelu;
  private double[] ograniczenia;
  private double[] baza;
  private double[] wspolczynnikiBazy;
  private double[] wskaznikiOptymalnosci;
  private double[] kryteriumWejscia;
  private double[] wskaznikiOptymalnosciSztucznychZmiennych;

  public Macierze(int m, int n) {
    this.m = m;
    this.n = n;
    this.wspolczynnikiOgraniczen = new double[m][n];
    this.wspolczynnikiFunkcjiCelu = new double[n];
    this.ograniczenia = new double[m];
    this.baza = new double[m];
    this.wspolczynnikiBazy = new double[m];
    this.wskaznikiOptymalnosci = new double[n + 1];
    this.wskaznikiOptymalnosciSztucznychZmiennych = new double[n + 1];
    this.kryteriumWejscia = new double[m];
    System.out.println("W bazie sa:");
    for (int i = 0; i < m; i++) {
      baza[i] = n - m + i;
      System.out.println(baza[i] + 1);
    }

  }

  public int getM() {
    return m;
  }

  public void setM(int m) {
    this.m = m;
  }

  public int getN() {
    return n;
  }

  public void setN(int n) {
    this.n = n;
  }

  public double[][] getwspolczynnikiOgraniczen() {
    return wspolczynnikiOgraniczen;
  }

  public void setwspolczynnikiOgraniczen(double[][] wspolczynnikiOgraniczen) {
    this.wspolczynnikiOgraniczen = wspolczynnikiOgraniczen;
  }

  public double[] getwspolczynnikiFunkcjiCelu() {
    return wspolczynnikiFunkcjiCelu;
  }

  public void setwspolczynnikiFunkcjiCelu(double[] wspolczynnikiFunkcjiCelu) {
    this.wspolczynnikiFunkcjiCelu = wspolczynnikiFunkcjiCelu;
  }

  public double[] getOgraniczenia() {
    return ograniczenia;
  }

  public void setOgraniczenia(double[] ograniczenia) {
    this.ograniczenia = ograniczenia;
  }

  public void wypelnij(ArrayList<JTextField> tablicaWspolczynnikow,
      ArrayList<JComboBox> tablicaTypowOgraniczen) {
    ileSztucznych = 0;
    for (int i = 0; i < tablicaTypowOgraniczen.size() - 1; i++) {
      ileSztucznych += tablicaTypowOgraniczen.get(i).getSelectedIndex();
    }
    ileSztucznychOgolem = ileSztucznych;
    zmienneSztuczne = new int[ileSztucznychOgolem];
    for (int i = 0; i < ileSztucznych; i++) {
      zmienneSztuczne[i] = n - ileSztucznych - 1 + i;
    }

    System.out.println("m=" + m + "   n=" + n);
    n = n - ileSztucznych;
    for (int i = 0; i < m; i++) {
      baza[i] = n - m + i;
    }
    try {
      for (int i = 0; i < (tablicaWspolczynnikow.size() - (n - m))
          / (n - m + 1); i++) {
        for (int j = 1; j < n; j++) {
          if (j % (n - m + 1) != 0) {
            wspolczynnikiOgraniczen[i][j - 1] = Double
                .parseDouble(tablicaWspolczynnikow.get(
                    i * (n - m + 1) + j - 1).getText());
          } else {
            ograniczenia[i] = Double
                .parseDouble(tablicaWspolczynnikow.get(
                    i * (n - m + 1) + j - 1).getText());
            j = j + m;
          }
        }
      }
    } catch (java.lang.NumberFormatException e) {
      JOptionPane.showMessageDialog(null,
          "Nie wprowadzono odpowiednich wartosci");
    }
    int ileZostalo = 0;
    for (int i = 0; i < m; i++) {
      for (int j = n - m; j < n; j++) {
        if (i + n - m == j
            && tablicaTypowOgraniczen.get(i).getSelectedIndex() == 0) {
          wspolczynnikiOgraniczen[i][j] = 1;
        } else if (i + n - m == j
            && tablicaTypowOgraniczen.get(i).getSelectedIndex() == 1) {
          wspolczynnikiOgraniczen[i][j] = -1;
          wspolczynnikiOgraniczen[i][n + ileZostalo] = 1;
          baza[i] = n + ileZostalo;
          wspolczynnikiFunkcjiCelu[n + ileZostalo] = 1000.0;
          ileZostalo++;
        }
      }
    }

    for (int i = 0; i < n - m; i++) {
      wspolczynnikiFunkcjiCelu[i] = tablicaTypowOgraniczen.get(
          tablicaTypowOgraniczen.size() - 1).getSelectedIndex() == 0 ? -Integer
          .parseInt(tablicaWspolczynnikow.get(
              tablicaWspolczynnikow.size() - n + m + i).getText())
          : Integer
              .parseInt(tablicaWspolczynnikow.get(
                  tablicaWspolczynnikow.size() - n + m + i)
                  .getText());
    }
    for (int x = 0; x < baza.length; x++) {
      wspolczynnikiBazy[x] = wspolczynnikiFunkcjiCelu[(int) (baza[x])];
      System.out.println("wspolczynniki bazy:" + wspolczynnikiBazy[x]);
    }
    n = n + ileSztucznych;
  }

  public void ustawWspolczynnikiBazyINowaTablice() {
    int i = policzKryteriumWejscia();
    int j = policzKryteriumWyjscia(i);

    System.out.println("Oto wektor wejscia " + (i + 1)
        + "  i wektor wyjscia " + (j + 1));
    baza[j] = i;
    wspolczynnikiBazy[j] = wspolczynnikiFunkcjiCelu[i];

    for (double x : baza)
      System.out.println("Oto baza x" + (int) (x + 1));
    for (double x : wspolczynnikiBazy)
      System.out.println("Oto wspolczynniki bazy "
          + Math.round(x * dokladnosc) / dokladnosc);
    double tmp = wspolczynnikiOgraniczen[j][i];
    if (tmp != 0) {
      for (int t = 0; t < n; t++)
        wspolczynnikiOgraniczen[j][t] = wspolczynnikiOgraniczen[j][t]
            / tmp;
      ograniczenia[j] = ograniczenia[j] / tmp;
    }
    for (int s = 0; s < m; s++) {
      tmp = wspolczynnikiOgraniczen[s][i];
      if (j != s) {
        for (int t = 0; t < n; t++) {
          wspolczynnikiOgraniczen[s][t] = wspolczynnikiOgraniczen[s][t]
              - wspolczynnikiOgraniczen[j][t] * tmp;
        }
        ograniczenia[s] = ograniczenia[s] - ograniczenia[j] * tmp;
      }
    }
    wypiszMacierz();
  }

  public void policzWskaznikiOptymalnosci() {
    System.out.println();
    System.out.println("Wspolczynniki optymalnosci");
    for (int j = 0; j < n + 1; j++) {
      wskaznikiOptymalnosci[j] = 0.0;
    }
    for (int i = 0; i < wskaznikiOptymalnosci.length - 1; i++) {
      for (int j = 0; j < m; j++) {
        wskaznikiOptymalnosci[i] += wspolczynnikiBazy[j]
            * wspolczynnikiOgraniczen[j][i];
      }
      wskaznikiOptymalnosci[i] -= wspolczynnikiFunkcjiCelu[i];
      System.out.print(Math.round(wskaznikiOptymalnosci[i] * dokladnosc)
          / dokladnosc + " ");
    }
    for (int j = 0; j < m; j++)
      wskaznikiOptymalnosci[wskaznikiOptymalnosci.length - 1] += wspolczynnikiBazy[j]
          * ograniczenia[j];
    System.out.println(Math
        .round(wskaznikiOptymalnosci[wskaznikiOptymalnosci.length - 1]
            * dokladnosc)
        / dokladnosc);
    System.out.println("-----------------------");
  }

  public boolean czyNalezyDoBazy(int indeks) {
    for (int i = 0; i < zmienneSztuczne.length; i++) {
      if (zmienneSztuczne[i] == indeks)
        return true;
    }
    return false;
  }

  public void policzWskaznikiOptymalnosciSztucznejBazy() {

    System.out.println("Wspolczynniki optymalnosci sztucznej bazy");
    for (int j = 0; j < n + 1; j++) {
      wskaznikiOptymalnosciSztucznychZmiennych[j] = 0.0;
    }

    for (int i = 0; i < wskaznikiOptymalnosci.length - 1; i++) {
      for (int j = 0; j < m; j++) {
        if (czyNalezyDoBazy(((int) baza[j]) - 1)) {
          wskaznikiOptymalnosciSztucznychZmiennych[i] += wspolczynnikiOgraniczen[j][i];
        }
      }
      System.out.print(Math
          .round(wskaznikiOptymalnosciSztucznychZmiennych[i]
              * dokladnosc)
          / dokladnosc + " ");
    }
    for (int j = 0; j < m; j++)
      if (czyNalezyDoBazy(((int) baza[j]) - 1))
        wskaznikiOptymalnosciSztucznychZmiennych[wskaznikiOptymalnosciSztucznychZmiennych.length - 1] += ograniczenia[j];
    System.out
        .println(Math
            .round(wskaznikiOptymalnosciSztucznychZmiennych[wskaznikiOptymalnosciSztucznychZmiennych.length - 1]
                * dokladnosc)
            / dokladnosc);
    System.out.println("-----------------------");

  }

  public int policzKryteriumWejscia() {
    //
    int maximum = -1;
    czyKoniec = -1;
    double max = wskaznikiOptymalnosci[0];
    if (max > 0.0)
      maximum = 0;
    for (int i = 0; i < wskaznikiOptymalnosci.length - 2; i++) {
      if (wskaznikiOptymalnosci[i + 1] > 0.0
          && wskaznikiOptymalnosci[i + 1] > max) {
        maximum = i + 1;
        max = wskaznikiOptymalnosci[i + 1];
      }
    }
    if (ileSztucznych > 0) {
      max = wskaznikiOptymalnosciSztucznychZmiennych[0];
      maximum = 0;
      for (int i = 0; i < wskaznikiOptymalnosciSztucznychZmiennych.length
          - 2 - ileSztucznychOgolem; i++) {
        if (wskaznikiOptymalnosciSztucznychZmiennych[i + 1] > 0.0
            && wskaznikiOptymalnosciSztucznychZmiennych[i + 1] > max) {
          maximum = i + 1;
          max = wskaznikiOptymalnosciSztucznychZmiennych[i + 1];
        }
      }
      ileSztucznych--;
    }
    if (maximum == -1) {
      czyKoniec = -1;
      return -1;
    }

    for (int i = 0; i < m; i++) {
      if (wspolczynnikiOgraniczen[i][maximum] > 0.0) {
        czyKoniec = maximum;
        return maximum;
      }
    }
    czyKoniec = -2;
    return -2;
  }

  public int policzKryteriumWyjscia(int coWchodzi) {
    int minimum = 0;

    for (int i = 0; i < kryteriumWejscia.length; i++) {
      if (wspolczynnikiOgraniczen[i][coWchodzi] != 0.0)
        kryteriumWejscia[i] = ograniczenia[i]
            / wspolczynnikiOgraniczen[i][coWchodzi];
      else
        kryteriumWejscia[i] = 0;
      System.out
          .println("Wspolczynniki Wyjscia "
              + Math.round(kryteriumWejscia[i] * dokladnosc)
              / dokladnosc);
    }

    for (int i = 0; i < kryteriumWejscia.length; i++) {
      if (wspolczynnikiBazy[i] != 1000.0 && kryteriumWejscia[i] == 0.0) {
        kryteriumWejscia[i] = -10.0;
      }
    }

    for (int i = 0; i < kryteriumWejscia.length - 1; i++) {
      if (kryteriumWejscia[i] > kryteriumWejscia[i + 1]
          && kryteriumWejscia[i + 1] >= 0.0) {
        minimum = i + 1;
      }
    }
    return minimum;
  }

  public void wypiszMacierz() {
    for (double[] x : wspolczynnikiOgraniczen) {
      for (double y : x) {
        System.out.print(Math.round(y * dokladnosc) / dokladnosc + " ");
      }
      System.out.println();
    }
    System.out.println("----------");
    for (double y : ograniczenia) {
      System.out.println("ograniczenia: " + Math.round(y * dokladnosc)
          / dokladnosc + " ");
    }
    System.out.println("--------------");

    System.out.println("wspolczynnikiFunkcjiCelu:");
    for (double y : wspolczynnikiFunkcjiCelu) {
      System.out.print(y + " ");
    }
  }

  @Override
  public String toString() {
    int[] bazaDoWypisania = new int[baza.length];
    for (int i = 0; i < baza.length; i++) {
      bazaDoWypisania[i] = (int) (baza[i] + 1);
    }
    String sprzecznosc = new String("");
    if (wskaznikiOptymalnosciSztucznychZmiennych[wskaznikiOptymalnosciSztucznychZmiennych.length - 1] != 0.0) {
      sprzecznosc = "uklad sprzeczny poniewaz zj-cj(w)="
          + wskaznikiOptymalnosciSztucznychZmiennych[wskaznikiOptymalnosciSztucznychZmiennych.length - 1];
    }
    return " baza=" + Arrays.toString(bazaDoWypisania)
        + ", \n wspolczynniki Bazy="
        + Arrays.toString(wspolczynnikiBazy)
        + ", \n wskazniki Optymalnosci=\n "
        + Arrays.toString(wskaznikiOptymalnosci)
        + ", \n wskazniki Optymalnosci Sztucznych Zmiennych=\n "
        + Arrays.toString(wskaznikiOptymalnosciSztucznychZmiennych)
        + ", \n wynik= "
        + -wskaznikiOptymalnosci[wskaznikiOptymalnosci.length - 1]
        + "\n " + sprzecznosc;
  }

  public int getCzyKoniec() {
    return czyKoniec;
  }

}