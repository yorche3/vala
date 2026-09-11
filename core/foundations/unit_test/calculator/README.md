# Calculator — Vala

Implementación de la especificación [03_Unit_Test_Calculator](https://yorche3.github.io/programming_languages/core/foundations/03_Unit_Test_Calculator/) en **Vala**, usando una estructura tipo librería con `src/` y `test/`, y el framework de pruebas integrado de GLib (`GLib.Test`).

No se requiere instalar una biblioteca externa ni usar `sudo`.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directorio | Propósito |
|----------------------|-----------|
| [`src/calculator.vala`](src/calculator.vala) | Librería con el namespace `Calculator` y las cinco operaciones. |
| [`test/calculator_test.vala`](test/calculator_test.vala) | Suite GLib.Test con cinco pruebas agrupadas por operación. |
| [`.gitignore`](.gitignore) | Ignora binarios y archivos generados por `valac`. |

```text
calculator/
├── src/
│   └── calculator.vala
├── test/
│   └── calculator_test.vala
├── .gitignore
└── README.md
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se creó manualmente como una librería Vala. La implementación vive en `src/` y las pruebas en `test/`. GLib.Test proporciona el registro de tests, las aserciones y el runner sin añadir una dependencia externa.

**EN:** The project was created manually as a Vala library. Implementation lives in `src/`, and tests live in `test/`. GLib.Test provides test registration, assertions, and the runner without adding an external dependency.

Las operaciones siguen las implementaciones educativas:

- `addition`: suma directa.
- `subtraction`: resta directa.
- `multiplication`: suma repetitiva, sin usar `*`.
- `division`: resta repetitiva, sin usar `/`.
- `modulus`: reutiliza `division` y `multiplication`, sin usar `%`.

### Inicialización / Initialization

```bash
mkdir -p vala/core/foundations/unit_test/calculator/{src,test}
cd vala/core/foundations/unit_test/calculator
```

Después se añaden la librería en `src/` y la suite GLib.Test en `test/`.

---

## 📄 Archivos de configuración clave / Key Configuration Files

No se requiere un archivo de build para este ejercicio. `valac` compila el código de `src/` junto con la suite de `test/` y enlaza GLib/GObject.

### `test/calculator_test.vala`

La suite usa `Test.init`, `Test.add_func`, `assert` y `Test.run`. Cada operación tiene una función de prueba y una ruta registrada bajo `/calculator/`.

The suite uses `Test.init`, `Test.add_func`, `assert`, and `Test.run`. Each operation has a test function and a registered path under `/calculator/`.

---

## 🚀 Compilación y ejecución / Build & Run

### Requisitos / Requirements

- **Vala 0.56.16**.
- **GLib/GObject 2.80.0**.
- `valac` y `pkg-config`.

Verificar el entorno:

```bash
valac --version
pkg-config --modversion glib-2.0 gobject-2.0
```

No se requiere instalar un framework externo: GLib.Test forma parte del entorno GLib usado por Vala.

### Compilar y ejecutar las pruebas / Build and run tests

```bash
cd vala/core/foundations/unit_test/calculator
valac src/calculator.vala test/calculator_test.vala \
  --pkg glib-2.0 \
  -o /tmp/vala-calculator-test
/tmp/vala-calculator-test
```

### Salida esperada / Expected output

```text
# Start of calculator tests
ok 1 /calculator/addition
ok 2 /calculator/subtraction
ok 3 /calculator/multiplication
ok 4 /calculator/division
ok 5 /calculator/modulus
# End of calculator tests
1..5
```

> **ES:** El formato exacto puede variar entre versiones de GLib.Test, pero deben ejecutarse los 5 tests y producirse 0 fallos.
> **EN:** The exact format may vary across GLib.Test versions, but all 5 tests must run with 0 failures.

---

## 🧠 Operaciones / Operations

| Operación | Implementación educativa |
|-----------|--------------------------|
| `addition(a, b)` | Suma directa. |
| `subtraction(a, b)` | Resta directa. |
| `multiplication(a, b)` | Suma `a` repetidamente mediante `for`. |
| `division(a, b)` | Resta `b` repetidamente mediante `while`. |
| `modulus(a, b)` | Calcula el resto reutilizando `division` y `multiplication`. |

Los cinco tests están agrupados por operación mediante funciones `test_*`.

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** GLib.Test proporciona el runner y `assert`, por lo que no se añade una biblioteca externa.
- **EN:** GLib.Test provides the runner and `assert`, so no external testing library is added.
- **ES:** `valac` compila la librería y la suite en un ejecutable nativo temporal.
- **EN:** `valac` compiles the library and suite into a temporary native executable.
- **ES:** La división por cero y los divisores no positivos quedan fuera de los casos básicos y provocan una aserción de runtime.
- **EN:** Division by zero and non-positive divisors are outside the basic cases and trigger a runtime assertion.
- **ES:** El código fuente no incluye comentarios inline; la explicación se mantiene en este README.
- **EN:** The source code contains no inline comments; explanations are kept in this README.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://github.com/yorche3/programming_languages)*
