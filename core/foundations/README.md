# 🚀 Fundamentos / Foundations — Vala

Implementación de los ejercicios de la sección [Fundamentos / Foundations](https://yorche3.github.io/programming_languages/core/foundations/) del repositorio principal en **Vala**.

---

## 📖 Descripción / Description

**ES:** Esta sección introduce Vala mediante programas independientes compilados con `valac` y proyectos tipo librería con pruebas unitarias usando el framework integrado de GLib (`GLib.Test`).

**EN:** This section introduces Vala through standalone programs compiled with `valac` and library-style projects with unit tests using GLib's built-in framework (`GLib.Test`).

---

## 📁 Estructura / Structure

```text
vala/
└── core/
    └── foundations/
        ├── README.md                   # Este archivo / This file
        ├── helloworld/                 # 01_Hello_World
        │   ├── helloworld.vala
        │   └── README.md
        ├── hellouser/                  # 02_Hello_User
        │   ├── HelloUser.vala
        │   └── README.md
        ├── unit_test/
        │   └── calculator/             # 03_Unit_Test_Calculator
        │       ├── src/
        │       │   └── calculator.vala
        │       ├── test/
        │       │   └── calculator_test.vala
        │       ├── .gitignore
        │       └── README.md
        └── numbers/                    # 04_Numbers
            ├── src/
            │   └── numbers.vala
            ├── test/
            │   ├── recursive_tests.vala
            │   └── iterative_tests.vala
            ├── .gitignore
            └── README.md
```

---

## 🔢 Progresión / Progression

| Especificación | Proyecto | Conceptos | Tests | Dependencias |
| -------------- | -------- | --------- | :---: | ------------ |
| [`01_Hello_World`](https://yorche3.github.io/programming_languages/core/foundations/01_Hello_World/) | [`helloworld/`](helloworld/) | clase, `main`, `print`, compilación con `valac` | — | Vala + GLib/GObject |
| [`02_Hello_User`](https://yorche3.github.io/programming_languages/core/foundations/02_Hello_User/) | [`hellouser/`](hellouser/) | `stdin`, `stdout.printf`, `read_line`, formato | — | Vala + GLib/GObject |
| [`03_Unit_Test_Calculator`](https://yorche3.github.io/programming_languages/core/foundations/03_Unit_Test_Calculator/) | [`unit_test/calculator/`](unit_test/calculator/) | librería `src/`, GLib.Test, `Test.add_func`, `assert` | 5 | GLib.Test incluido |
| [`04_Numbers`](https://yorche3.github.io/programming_languages/core/foundations/04_Numbers/) | [`numbers/`](numbers/) | recursión, acumuladores, `for`, `while`, TCO | 10 (22 casos) | GLib.Test incluido |

---

## 🛠️ Enfoque general / General Approach

**ES:** Los proyectos de esta sección siguen una progresión gradual:

1. **Hello World**: programa independiente con una clase y un método `main`, compilado a un ejecutable nativo mediante `valac`.
2. **Hello User**: programa con entrada estándar mediante `stdin.read_line()` y salida formateada mediante `stdout.printf`.
3. **Calculator**: primer proyecto tipo librería con `src/` y `test/`. Usa GLib.Test para validar las cinco operaciones aritméticas educativas.
4. **Numbers**: implementa cinco algoritmos en tres enfoques. Vala tiene `for`/`while`, pero no ofrece una garantía general de TCO; por eso se prueban `_rec` e `_ite`, mientras `_acc` permanece como puente didáctico sin suite propia.

**EN:** The projects in this section follow a gradual progression:

1. **Hello World**: standalone program with a class and `main` method, compiled into a native executable with `valac`.
2. **Hello User**: program with standard input through `stdin.read_line()` and formatted output through `stdout.printf`.
3. **Calculator**: the first library-style project with `src/` and `test/`. It uses GLib.Test to validate the five educational arithmetic operations.
4. **Numbers**: implements five algorithms in three approaches. Vala has `for`/`while`, but does not provide a general TCO guarantee; therefore `_rec` and `_ite` are tested, while `_acc` remains an educational bridge without its own suite.

---

## 📦 Requisitos / Requirements

| Herramienta | Uso | Verificación |
| ----------- | --- | ------------ |
| Vala 0.56.16 | Compilador del lenguaje | `valac --version` |
| GLib/GObject 2.80.0 | Runtime y base de `Object` | `pkg-config --modversion glib-2.0 gobject-2.0` |
| GLib.Test | Framework de pruebas | Incluido con GLib |
| `pkg-config` | Descubrir librerías GLib | `pkg-config --version` |

Verificar el entorno:

```bash
valac --version
pkg-config --modversion glib-2.0 gobject-2.0
```

No se requiere instalar una biblioteca externa ni usar `sudo` para estos módulos.

---

## 🚀 Ejecución rápida / Quick Start

### Hello World

```bash
cd vala/core/foundations/helloworld
valac helloworld.vala -o /tmp/vala-helloworld
/tmp/vala-helloworld
```

### Hello User

```bash
cd vala/core/foundations/hellouser
valac HelloUser.vala -o /tmp/vala-hellouser
printf 'Ada\n' | /tmp/vala-hellouser
```

### Calculator

```bash
cd vala/core/foundations/unit_test/calculator
valac src/calculator.vala test/calculator_test.vala \
  --pkg glib-2.0 \
  -o /tmp/vala-calculator-test
/tmp/vala-calculator-test
```

Resultado verificado: 5 tests aprobados.

### Numbers

```bash
cd vala/core/foundations/numbers
valac src/numbers.vala test/recursive_tests.vala \
  --pkg glib-2.0 \
  -o /tmp/vala-numbers-recursive-tests
/tmp/vala-numbers-recursive-tests

valac src/numbers.vala test/iterative_tests.vala \
  --pkg glib-2.0 \
  -o /tmp/vala-numbers-iterative-tests
/tmp/vala-numbers-iterative-tests
```

Resultado verificado: 22 casos/assertions aprobados.

---

## 🧪 Convenciones de pruebas / Testing Conventions

**ES:** Los proyectos tipo librería usan GLib.Test, incluido en el entorno GLib. Cada suite registra funciones mediante `Test.add_func`, agrupa los casos por algoritmo y usa `assert` para validar resultados.

**EN:** Library-style projects use GLib.Test, included in the GLib environment. Each suite registers functions through `Test.add_func`, groups cases by algorithm, and uses `assert` to validate results.

`calculator` tiene 5 tests. `numbers` tiene 2 suites con 5 tests cada una y 22 casos/assertions en total.

`calculator` has 5 tests. `numbers` has 2 suites with 5 tests each and 22 total cases/assertions.

---

## 🔁 TCO e iteración / TCO and Iteration

Vala dispone de iteración nativa mediante `for` y `while`, pero no ofrece una garantía general de Tail Call Optimization para estos módulos. Según la regla de `04_Numbers`, la combinación aplicada es:

Vala provides native iteration through `for` and `while`, but does not provide a general Tail Call Optimization guarantee for these modules. According to the `04_Numbers` rule, the applied combination is:

```text
TCO no garantizada + iteración nativa ✅
_rec + _ite
2 suites
10 tests
22 casos
```

La implementación `_acc` permanece en `numbers.vala` como puente conceptual hacia `_ite`, pero no tiene una suite independiente.

The `_acc` implementation remains in `numbers.vala` as a conceptual bridge toward `_ite`, but it has no independent suite.

---

## 🧹 Artefactos de compilación / Build Artifacts

Los `.gitignore` locales excluyen los ejecutables, código C generado, objetos y otros artefactos de `valac`. Los comandos rápidos escriben los binarios en `/tmp` para mantener limpio el proyecto.

Local `.gitignore` files exclude executables, generated C code, objects, and other `valac` artifacts. Quick-start commands write binaries under `/tmp` to keep the project clean.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://github.com/yorche3/programming_languages)*
