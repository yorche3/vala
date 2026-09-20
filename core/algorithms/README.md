# 🚀 Algoritmos Puros / Algorithms Pure — Vala

Implementaciones de la [Fase 1 — Algoritmos Puros](https://yorche3.github.io/programming_languages/ROADMAP/#fase-1--algoritmos-puros--algorithms-pure-) en **Vala**: ordenamientos elementales, estructuras de datos propias, ordenamientos óptimos y distribuidos, y búsqueda.

Los módulos de esta fase trabajan sobre **arrays mutables** (`int[]`), que se ordenan *in-place* y se devuelven. `int[]` no admite `null` sin la anotación `int[]?`, así que el caso nulo no es representable en la firma del contrato.

---

## 📂 Módulos / Modules

| Módulo | Especificación | Enfoque | Tests | Estado |
|--------|---------------|---------|:-----:|:------:|
| [`naive_sort/`](naive_sort/) | [05_Naive_Sort](https://yorche3.github.io/programming_languages/core/algorithms/05_Naive_Sort/) | `valac` + GLib.Test | 21 | ✅ |

---

## 📁 Estructura / Structure

```text
algorithms/
└── naive_sort/                      # 05_Naive_Sort
    ├── .gitignore                   # binario de pruebas y archivos generados por valac
    ├── src/
    │   └── naive_sort.vala          # namespace NaiveSort: 3 funciones
    ├── test/
    │   └── naive_sort_tests.vala    # 3 tests × 7 casos
    └── README.md
```

---

## 🛠️ Patrón común / Common Pattern

| Característica | Descripción |
|---------------|-------------|
| **Runtime** | Vala 0.56.16 sobre GLib/GObject 2.80.0 (GLib.Test incluido) |
| **CLI** | `valac src/<modulo>.vala test/<suite>.vala --pkg glib-2.0 -o /tmp/<binario>` y ejecución del binario |
| **Andamiaje** | ✍️ Estructura manual (`mkdir -p src test`), la que ya usa [`foundations/numbers/`](../foundations/numbers/) |
| **Framework de tests** | GLib.Test: `Test.init(ref args)`, `Test.add_func`, `assert` y `Test.run()` |
| **Runner** | La propia suite registra los tests y `Test.run()` los ejecuta; no hay `run_tests.vala` |
| **Separación** | `src/` (namespace del módulo) ↔ `test/` (suites) |
| **Módulo fuente** | Un `namespace` con funciones (`namespace NaiveSort`), como `namespace Numbers` |
| **API** | Una función por algoritmo: `NaiveSort.selection_sort(arr)`, etc. |
| **Naming** | `snake_case` idéntico al de la especificación (`selection_sort`), como en los otros módulos Vala del repositorio |
| **Mutabilidad** | Los arrays se pasan por referencia y los algoritmos ordenan *in-place*; la suite usa fixtures locales para no reutilizar arrays ordenados |
| **Nulabilidad** | `int[]` no admite `null` sin `int[]?`: el caso nulo no es representable y se omite |
| **Mensajes de aserción** | GLib.Test no admite mensaje en `assert`: el mensaje del contrato se emite con `Test.message` y `assert_not_reached()` |
| **Verificación estática** | `valac` compila sin warnings ni errores (cuidado con los fixtures `const int[]`, que generan `-Wdiscarded-qualifiers` al copiarse) |
| **Artefactos** | Binario de pruebas (`naive_sort_tests`) y archivos generados por `valac` (`*.c`, `*.h`, `*.vapi`, `*.o`, `*.a`, `*.so`) — ignorados por el `.gitignore`; el binario se compila en `/tmp` |
| **Particularidades** | Delegado `int[]` para pasar la función a probar; comparación de arrays elemento a elemento (no `==`, que compara referencias); salida en formato TAP |

---

## 🚀 Compilación rápida / Quick Build

```bash
# Naive Sort Tests
cd naive_sort
valac src/naive_sort.vala test/naive_sort_tests.vala --pkg glib-2.0 -o /tmp/vala-naive-sort-tests
/tmp/vala-naive-sort-tests
```

---

## ▶️ Siguiente / Next

👉 Continúa con los módulos pendientes de esta fase en el [Roadmap](https://yorche3.github.io/programming_languages/ROADMAP/).

👉 Continue with the pending modules of this phase in the [Roadmap](https://yorche3.github.io/programming_languages/ROADMAP/).

---

*[← Volver a Core](../README.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
