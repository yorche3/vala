# Numbers — Vala

Implementación de la especificación [04_Numbers](https://yorche3.github.io/programming_languages/core/foundations/04_Numbers/) en **Vala**, usando una estructura tipo librería con `src/` y `test/`, y **GLib.Test** como framework de pruebas unitarias.

No se requiere instalar una biblioteca externa ni usar `sudo`.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directorio | Propósito |
|----------------------|-----------|
| [`src/numbers.vala`](src/numbers.vala) | Implementación de los 15 métodos. |
| [`test/recursive_tests.vala`](test/recursive_tests.vala) | Suite `_rec`: 5 tests y 11 assertions. |
| [`test/iterative_tests.vala`](test/iterative_tests.vala) | Suite `_ite`: 5 tests y 11 assertions. |
| [`.gitignore`](.gitignore) | Ignora binarios y archivos generados por `valac`. |

```text
numbers/
├── src/
│   └── numbers.vala
├── test/
│   ├── recursive_tests.vala
│   └── iterative_tests.vala
├── .gitignore
└── README.md
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se creó manualmente como una librería Vala. El código de producción está en `src/` y las suites en `test/`. GLib.Test proporciona el runner y las aserciones sin dependencias externas.

**EN:** The project was created manually as a Vala library. Production code is under `src/`, and suites are under `test/`. GLib.Test provides the runner and assertions without external dependencies.

Los cinco algoritmos tienen tres implementaciones:

| Enfoque | Sufijo | Ejemplo | ¿Tiene suite propia? |
|---------|--------|---------|:--------------------:|
| Recursivo directo | `_rec` | `fibonacci_rec` | Sí |
| Recursivo con acumulador | `_acc` | `fibonacci_acc` | No, por TCO no garantizada |
| Iterativo | `_ite` | `fibonacci_ite` | Sí |

**Combinación aplicada:** TCO no garantizada + iteración nativa (`for`/`while`) ✅ → `_rec` + `_ite` = **2 suites, 10 tests agrupados y 22 casos**.

**Applied combination:** No guaranteed TCO + native iteration (`for`/`while`) ✅ → `_rec` + `_ite` = **2 suites, 10 grouped tests, and 22 cases**.

### Inicialización / Initialization

```bash
mkdir -p vala/core/foundations/numbers/{src,test}
cd vala/core/foundations/numbers
```

Después se añaden la librería en `src/` y las suites GLib.Test en `test/`.

---

## 📄 Archivos de configuración clave / Key Configuration Files

### Suites GLib.Test

Cada suite registra cinco funciones con `Test.add_func`; cada función corresponde a un algoritmo y agrupa dentro sus casos de prueba. GLib.Test proporciona `Test.init`, `assert` y `Test.run`.

Each suite registers five functions with `Test.add_func`; each function corresponds to an algorithm and groups its test cases. GLib.Test provides `Test.init`, `assert`, and `Test.run`.

---

## 🚀 Compilación y ejecución / Build & Run

### Requisitos / Requirements

- **Vala 0.56.16**.
- **GLib/GObject 2.80.0**.
- `valac` y `pkg-config`.

Verificar:

```bash
valac --version
pkg-config --modversion glib-2.0 gobject-2.0
```

No se requiere instalar una biblioteca externa: GLib.Test está disponible con GLib.

### Suite recursiva / Recursive suite

```bash
cd vala/core/foundations/numbers
valac src/numbers.vala test/recursive_tests.vala \
  --pkg glib-2.0 \
  -o /tmp/vala-numbers-recursive-tests
/tmp/vala-numbers-recursive-tests
```

### Suite iterativa / Iterative suite

```bash
cd vala/core/foundations/numbers
valac src/numbers.vala test/iterative_tests.vala \
  --pkg glib-2.0 \
  -o /tmp/vala-numbers-iterative-tests
/tmp/vala-numbers-iterative-tests
```

### Salida esperada / Expected output

Cada suite debe mostrar 11 casos aprobados:

```text
1..5
# Start of recursive tests
ok 1 /recursive/sum_of_first_n
ok 2 /recursive/factorial
ok 3 /recursive/fibonacci
ok 4 /recursive/greatest_common_divisor
ok 5 /recursive/least_common_multiple
# End of recursive tests
```

La ejecución conjunta representa 22 casos/assertions aprobados y 0 fallos.

The combined execution represents 22 passed cases/assertions and 0 failures.

---

## 🧠 Operaciones / Operations

| Función | `_rec` | `_acc` | `_ite` |
|---------|--------|--------|--------|
| `sum_of_first_n` | Recursión directa | Helper con acumulador | `for` |
| `factorial` | Recursión directa | Helper con acumulador | `for` |
| `fibonacci` | Dos llamadas recursivas | Dos acumuladores | `for` |
| `greatest_common_divisor` | Euclides recursivo | Helper de Euclides | `while` |
| `least_common_multiple` | Usa MCD y aritmética | Usa MCD y aritmética | Usa MCD y aritmética |

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** Vala tiene iteración nativa mediante `for` y `while`, por lo que `_ite` se implementa sin llamadas recursivas.
- **EN:** Vala has native iteration through `for` and `while`, so `_ite` is implemented without recursive calls.
- **ES:** Vala no ofrece una garantía general de TCO para este proyecto; `_acc` se conserva como puente didáctico sin suite propia.
- **EN:** Vala does not provide a general TCO guarantee for this project; `_acc` remains as an educational bridge without its own suite.
- **ES:** GLib.Test proporciona el runner y `assert`, por lo que no se añade una dependencia externa.
- **EN:** GLib.Test provides the runner and `assert`, so no external dependency is added.
- **ES:** Los ejecutables generados quedan excluidos por `.gitignore`.
- **EN:** Generated executables are excluded by `.gitignore`.
- **ES:** El código fuente no incluye comentarios inline; la explicación se mantiene en este README.
- **EN:** The source code contains no inline comments; explanations are kept in this README.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://github.com/yorche3/programming_languages)*
