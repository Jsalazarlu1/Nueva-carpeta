  import java.util.Scanner;

  public class Proyecto {
      public static void main(String[] args) {
          Scanner scanner = new Scanner(System.in);

          int numEstudiantes = 7;
          String[] nombres = new String[numEstudiantes];
          double[][] notas = new double[numEstudiantes][3];
          double[] promedios = new double[numEstudiantes];

          // Ingreso de datos
          for (int i = 0; i < numEstudiantes; i++) {
              System.out.print("Ingrese el nombre del estudiante " + (i + 1) + ": ");
              nombres[i] = scanner.nextLine();

              for (int j = 0; j < 3; j++) {
                  System.out.print("Ingrese la nota " + (j + 1) + " de " + nombres[i] + ": ");
                  notas[i][j] = scanner.nextDouble();
              }
              scanner.nextLine(); // Limpiar el buffer
          }

          // Calcular promedios
          System.out.println("\nPromedios:");
          for (int i = 0; i < numEstudiantes; i++) {
              double suma = 0;
              for (int j = 0; j < 3; j++) {
                  suma += notas[i][j];
              }
              promedios[i] = suma / 3;
              System.out.printf("%s: %.2f\n", nombres[i], promedios[i]);
          }

          // Identificar estudiantes en riesgo
          System.out.println("\nEstudiantes en riesgo académico (promedio < 3.0):");
          int enRiesgo = 0;
          for (int i = 0; i < numEstudiantes; i++) {
              if (promedios[i] < 3.0) {
                  System.out.printf("- %s (posición %d) con promedio %.2f\n", nombres[i], i, promedios[i]);
                  enRiesgo++;
              }
          }

          if (enRiesgo == 0) {
              System.out.println("Ningún estudiante está en riesgo.");
          } else {
              System.out.println("Total en riesgo: " + enRiesgo);
          }
          scanner.close();
      }
  }