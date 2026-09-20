// naive_sort — ordenamientos elementales O(n²).
//
// Especificación: 05_Naive_Sort
//
// Contrato: las tres funciones reciben un array de enteros y devuelven el array
// ordenado de menor a mayor (in-place o como copia ordenada), sin invocar
// métodos de ordenamiento de la biblioteca estándar y sin estructuras
// auxiliares complejas.
// API (naming snake_case, el mismo de la especificación y de `core/foundations/
// numbers/`): las funciones públicas del namespace `NaiveSort` —
// `selection_sort`, `bubble_sort` e `insertion_sort`.
// El caso nulo se omite: en Vala `int[]` no admite `null` sin la anotación
// `int[]?`, que se formaliza en una fase posterior. Si el array está vacío o
// tiene un solo elemento se devuelve sin cambios. No lanza excepciones.
//
// Implementación pendiente: la escribe el autor. Esta delegación solo genera el
// esqueleto y las pruebas unitarias.

namespace NaiveSort {

  static int[] selection_sort(int[] arr) {
    int n = arr.length;
    if (n < 2) {
      return arr;
    }
    for (int i = 0; i < n - 1; i++) {
      int min_index = i;
      for (int j = i + 1; j < n; j++) {
        if (arr[j] < arr[min_index]) {
          min_index = j;
        }
      }
      if (min_index != i) {
        int temp = arr[i];
        arr[i] = arr[min_index];
        arr[min_index] = temp;
      }
    }
    return arr;
  }

  static int[] bubble_sort(int[] arr) {
    int n = arr.length;
    if (n < 2) {
      return arr;
    }
    for (int i = 0; i < n - 1; i++) {
      bool swapped = false;
      for (int j = 0; j < n - 1 - i; j++) {
        if (arr[j] > arr[j + 1]) {
          int temp = arr[j];
          arr[j] = arr[j + 1];
          arr[j + 1] = temp;
          swapped = true;
        }
      }
      if (!swapped) {
        break;
      }
    }
    return arr;
  }

  static int[] insertion_sort(int[] arr) {
    int n = arr.length;
    if (n < 2) {
      return arr;
    }
    for (int i = 1; i < n; i++) {
      int key = arr[i];
      int j = i - 1;
      while (j >= 0 && arr[j] > key) {
        arr[j + 1] = arr[j];
        j--;
      }
      arr[j + 1] = key;
    }
    return arr;
  }
}