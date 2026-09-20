# Naive Sort — Vala

Implementación de la especificación [05_Naive_Sort](https://yorche3.github.io/programming_languages/core/algorithms/05_Naive_Sort/) en **Vala**, usando una estructura tipo librería con `src/` y `test/`, y **GLib.Test** como framework de pruebas unitarias.

Los tres algoritmos elementales de ordenamiento $O(n^2)$ — **selection sort**, **bubble sort** e **insertion sort** — ordenan *in-place* el array recibido y devuelven la misma referencia, sin invocar ninguna función de ordenamiento de la biblioteca estándar.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directorio | Propósito |
|----------------------|-----------|
| [`src/naive_sort.vala`](src/naive_sort.vala) | Namespace `NaiveSort` con las 3 funciones del contrato. |
| [`test/naive_sort_tests.vala`](test/naive_sort_tests.vala) | Suite GLib.Test: 3 tests (uno por algoritmo) con los 7 casos. |
| [`.gitignore`](.gitignore) | Ignora el binario de pruebas y los archivos generados por `valac`. |

```text
naive_sort/
├── src/
│   └── naive_sort.vala        # namespace NaiveSort: 3 algoritmos
├── test/
│   └── naive_sort_tests.vala  # 3 tests × 7 casos
├── .gitignore
└── README.md
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se creó manualmente como una librería Vala, igual que `core/foundations/numbers/`: código de producción en `src/`, suite en `test/` y GLib.Test como runner y framework de aserciones, sin dependencias externas. El binario de pruebas se compila fuera del módulo (`/tmp`), así que el repositorio solo guarda fuentes.

**EN:** The project was created by hand as a Vala library, like `core/foundations/numbers/`: production code under `src/`, suite under `test/`, and GLib.Test as runner and assertion framework, with no external dependencies. The test binary is compiled outside the module (`/tmp`), so the repository only stores sources.

### Inicialización / Initialization

```bash
mkdir -p vala/core/algorithms/naive_sort/{src,test}
cd vala/core/algorithms/naive_sort
```

Después se añade la librería en `src/` y la suite GLib.Test en `test/`.

---

## 📄 Configuración clave / Key Configuration

### `src/naive_sort.vala` — contrato e implementación

**ES:** Las tres funciones reciben el array por referencia, lo ordenan *in-place* y devuelven la misma referencia. Con menos de dos elementos el array vuelve sin cambios y ninguna función lanza excepciones.

**EN:** All three functions take the array by reference, sort it *in-place*, and return the same reference. With fewer than two elements the array is returned unchanged and no function throws.

```vala
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
}
```

| Elemento del contrato | Representación en Vala |
| --------------------- | ---------------------- |
| Array de enteros | `int[]` (índices 0-based) |
| Caso nulo / inválido | Omitido: `int[]` no admite `null` sin la anotación `int[]?` |
| Array vacío | `{}` (`arr.length == 0`) |
| Orden | in-place sobre el array recibido, devuelve la misma referencia |
| Nombres de la especificación | `selection_sort`, `bubble_sort`, `insertion_sort` (snake_case, idénticos a la especificación y al namespace `Numbers`) |

### Suite de pruebas / Test suite

**ES:** La suite usa GLib.Test: un `delegate` para pasar la función a probar, un helper compartido que recibe el nombre del algoritmo y ejecuta los 7 casos, y un `Test.add_func` por algoritmo registrado en `main` con `Test.run()`.

**EN:** The suite uses GLib.Test: a `delegate` to pass the function under test, a shared helper that receives the algorithm name and runs the 7 cases, and one `Test.add_func` per algorithm registered in `main` with `Test.run()`.

```vala
delegate int[] SortFunc(int[] arr);

// Helper compartido por caso: ejecuta la función y reporta con el mensaje del
// contrato cuando el resultado no coincide.
void check_case(string algorithm, SortFunc sort, string description, int[] input, int[] expected) {
    int[] actual = sort(input);

    if (!same_values(actual, expected)) {
        Test.message(@"$algorithm should sort $description");
        assert_not_reached();
    }
}
```

---

## 🚀 Compilación y ejecución / Build & Run

### Requisitos / Requirements

- **Vala 0.56.16** y **GLib/GObject 2.80.0** con `pkg-config`; GLib.Test viene incluido con GLib.

```bash
valac --version
pkg-config --modversion glib-2.0 gobject-2.0
```

### Compilar y ejecutar las pruebas / Build & run tests

```bash
cd vala/core/algorithms/naive_sort
valac src/naive_sort.vala test/naive_sort_tests.vala --pkg glib-2.0 -o /tmp/vala-naive-sort-tests
/tmp/vala-naive-sort-tests
```

**Salida real / Actual output:**

```text
$ valac src/naive_sort.vala test/naive_sort_tests.vala --pkg glib-2.0 -o /tmp/vala-naive-sort-tests
```

```text
$ /tmp/vala-naive-sort-tests
TAP version 13
# random seed: R02S01e0ff43f32807f08dabf61a70c58aec
1..3
# Start of naive_sort tests
ok 1 /naive_sort/selection_sort
ok 2 /naive_sort/bubble_sort
ok 3 /naive_sort/insertion_sort
# End of naive_sort tests
```

> **ES:** `valac` compila el módulo y la suite sin warnings ni errores (verificación estática) y el binario imprime el resultado en formato TAP: 3 tests, uno por algoritmo, cada uno con los 7 casos de la tabla (21 aserciones).
> **EN:** `valac` compiles the module and the suite with no warnings or errors (static check) and the binary prints the result in TAP format: 3 tests, one per algorithm, each with the 7 cases of the table (21 assertions).

---

## 🧠 Algoritmos y operaciones / Algorithms & Operations

| Función / Algorithm | Enfoque / Approach | Descripción / Description |
| ------------------- | ------------------ | ------------------------- |
| `selection_sort(arr)` | iterativo, in-place | Busca el mínimo del tramo no ordenado con `min_index` y lo intercambia al inicio con `temp`. $O(n^2)$ siempre. |
| `bubble_sort(arr)` | iterativo, in-place, con bandera | Compara adyacentes e intercambia; sale antes con `if (!swapped) { break; }` cuando una pasada no intercambia nada. $O(n^2)$ peor/promedio, $O(n)$ mejor. |
| `insertion_sort(arr)` | iterativo, in-place, estable | Guarda `key`, desplaza el sub-array ordenado con `while (j >= 0 && arr[j] > key)` y lo inserta en su posición. $O(n^2)$ peor/promedio, $O(n)$ mejor. |

| Caso (descripción en la suite) | Entrada | Salida esperada |
| ------------------------------ | ------- | --------------- |
| an unsorted array | `{ 5, 2, 9, 1, 5, 6 }` | `{ 1, 2, 5, 5, 6, 9 }` |
| an already sorted array | `{ 1, 2, 3, 4, 5 }` | `{ 1, 2, 3, 4, 5 }` |
| a reverse ordered array | `{ 5, 4, 3, 2, 1 }` | `{ 1, 2, 3, 4, 5 }` |
| an array of identical elements | `{ 7, 7, 7, 7 }` | `{ 7, 7, 7, 7 }` |
| an array with negative numbers | `{ 3, -1, 4, -5, 0 }` | `{ -5, -1, 0, 3, 4 }` |
| a single element array | `{ 42 }` | `{ 42 }` |
| an empty array | `{}` | `{}` |

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** Divergencia idiomática aceptada: las tres funciones ordenan **in-place** el array recibido y devuelven esa misma referencia, variante que la especificación permite. Los arrays de Vala se pasan por referencia, así que la suite crea los fixtures como arrays locales en cada llamada al helper: ningún caso reutiliza un array ya ordenado.
- **EN:** Accepted idiomatic divergence: all three functions sort the received array **in-place** and return that same reference, a variant the specification allows. Vala arrays are passed by reference, so the suite creates the fixtures as local arrays on every helper call: no case reuses an already sorted array.
- **ES:** Caso nulo omitido: en Vala `int[]` no admite `null` (el compilador avisa `Argument 1: Cannot pass null to non-null parameter type`); haría falta la anotación `int[]?`, que se formaliza en la fase de abstracción y persistencia, así que no hay indicador de fallo que comprobar. Se conservan los 7 casos. Ninguna función lanza excepciones.
- **EN:** Null case omitted: in Vala `int[]` does not admit `null` (the compiler warns `Argument 1: Cannot pass null to non-null parameter type`); the `int[]?` annotation would be required, and it is formalized in the abstraction and persistence phase, so there is no failure indicator to check. The 7 cases are kept. No function throws.
- **ES:** GLib.Test no admite mensaje en `assert`, así que el mensaje del contrato se reporta con `Test.message` seguido de `assert_not_reached()` cuando un caso no coincide; esa es la línea que aparece en el reporte de fallo.
- **EN:** GLib.Test does not accept a message in `assert`, so the contract message is reported with `Test.message` followed by `assert_not_reached()` when a case does not match; that is the line shown in the failure report.
- **ES:** Los fixtures de la suite son arrays locales (no `const int[]`) porque copiar una constante de tipo array genera warnings de C al compilar con `--pkg glib-2.0` (`-Wdiscarded-qualifiers`); así la compilación queda limpia.
- **EN:** The suite fixtures are local arrays (not `const int[]`) because copying a constant array generates C warnings when compiling with `--pkg glib-2.0` (`-Wdiscarded-qualifiers`); this keeps the build clean.
- **ES:** `bubble_sort` conserva la optimización de salida temprana: la bandera `swapped` y el `break` reproducen el `if not swapped: break` del pseudocódigo (mejor caso $O(n)$). La bandera no es observable en la salida, así que su presencia se verifica contra el pseudocódigo.
- **EN:** `bubble_sort` keeps the early-exit optimization: the `swapped` flag and the `break` reproduce the pseudocode's `if not swapped: break` (best case $O(n)$). The flag is not observable in the output, so its presence is verified against the pseudocode.
- **ES:** Los bucles del pseudocódigo se traducen a `for (int i = 0; i < n - 1; i++)` con bucles interiores `j < n` y `j < n - 1 - i` (el equivalente exacto de `for j = 0 to n - 2 - i`); el intercambio usa una variable `temp` y no se invoca ninguna función de ordenamiento de GLib.
- **EN:** The pseudocode loops translate to `for (int i = 0; i < n - 1; i++)` with inner loops `j < n` and `j < n - 1 - i` (the exact equivalent of `for j = 0 to n - 2 - i`); swaps use a `temp` variable and no GLib sorting function is called.
- **ES:** `insertion_sort` traduce el `while j >= 0 and arr[j] > key` del pseudocódigo literalmente; la comparación estricta lo mantiene estable.
- **EN:** `insertion_sort` translates the pseudocode's `while j >= 0 and arr[j] > key` literally; the strict comparison keeps it stable.
- **ES:** Las funciones se declaran `static` dentro del namespace `NaiveSort`, es decir con visibilidad de archivo; el módulo se compila junto con la suite en una sola invocación de `valac`, que es el flujo documentado, así que la suite las resuelve sin necesidad de exportar un `.vapi`.
- **EN:** The functions are declared `static` inside the `NaiveSort` namespace, i.e. with file visibility; the module is compiled together with the suite in a single `valac` invocation, which is the documented flow, so the suite resolves them without exporting a `.vapi`.
- **ES:** Nota de desviación respecto a la ubicación esperada: se conservan `src/naive_sort.vala` (solo cambia la extensión) y `test/naive_sort_tests.vala` (sufijo en plural, como `recursive_tests.vala` de `numbers/`); no se añade `run_tests.vala` porque la propia suite registra los tests y `Test.run()` los ejecuta. El binario se compila en `/tmp`, fuera del repositorio.
- **EN:** Deviation note from the expected location: `src/naive_sort.vala` (only the extension changes) and `test/naive_sort_tests.vala` (plural suffix, like `recursive_tests.vala` in `numbers/`) are kept; no `run_tests.vala` is added because the suite registers the tests itself and `Test.run()` executes them. The binary is compiled in `/tmp`, outside the repository.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*[← Volver a Algoritmos Puros](../README.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
