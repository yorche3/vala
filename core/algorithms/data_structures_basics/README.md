# Data Structures Basics — Vala

Implementación de la especificación [06_Data_Structures_Basics](https://yorche3.github.io/programming_languages/core/algorithms/06_Data_Structures_Basics/) en **Vala**, con un enfoque manual y minimalista.

**ES:** Se implementa un nodo enlazado `Node` compartido y tres estructuras de datos clásicas (`LinkedList`, `Stack` y `Queue`) construidas desde cero sin delegar entre sí ni en colecciones estándar, probadas mediante GLib.Test.

**EN:** A shared `Node` cell and three classic data structures (`LinkedList`, `Stack`, and `Queue`) are implemented from scratch without delegating to each other or standard collections, verified with GLib.Test.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directory | Propósito / Purpose |
|---|---|
| [`src/data_structures_basics.vala`](src/data_structures_basics.vala) | Clases `Node`, `LinkedList`, `Stack` y `Queue` bajo el namespace `DataStructuresBasics`. |
| [`test/data_structures_basics_test.vala`](test/data_structures_basics_test.vala) | Suite de pruebas unitarias sobre GLib.Test con runners secuenciales para cada estructura. |
| [`meson.build`](meson.build) | Configuración de compilación Meson a nivel de módulo. |
| [`src/meson.build`](src/meson.build) | Definición de la librería compartida para Meson. |
| [`test/meson.build`](test/meson.build) | Definición del ejecutable de prueba para Meson. |
| [`.gitignore`](.gitignore) | Archivos y directorios ignorados (`build/`, binarios y artefactos C generados). |

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El módulo se diseñó manualmente dentro de la jerarquía estándar de Vala (`src/` y `test/`), compilando directamente con `valac` y vinculando `glib-2.0` y `gobject-2.0`. Todas las estructuras gestionan sus propios punteros (`_head`/`_tail`, `_top`, `_front`/`_rear`) y su contador de elementos, reutilizando únicamente la clase de celda `Node`.

**EN:** The module was designed manually following the standard Vala layout (`src/` and `test/`), compiling directly via `valac` linking `glib-2.0` and `gobject-2.0`. All structures independently manage their own pointers (`_head`/`_tail`, `_top`, `_front`/`_rear`) and size counter, sharing only the `Node` cell class.

### Inicialización / Initialization

```bash
mkdir -p vala/core/algorithms/data_structures_basics/{src,test}
cd vala/core/algorithms/data_structures_basics
```

---

## 📄 Configuración clave / Key Configuration

### `src/data_structures_basics.vala`

**ES:** Las cuatro clases residen en un único archivo dentro del namespace `DataStructuresBasics`. `Node` expone una propiedad de valor inmutable y una referencia `next` nullable (`Node?`). Las estructuras inicializan su estado vacío en el constructor (`new`) y no lanzan excepciones; cuando están vacías o una búsqueda falla, retornan el centinela `-1` o `false`.

**EN:** All four classes reside in a single file within the `DataStructuresBasics` namespace. `Node` exposes an immutable value property and a nullable `next` reference (`Node?`). Structures initialize their empty state in the constructor (`new`) and do not throw exceptions; when empty or on search failure, they return the sentinel `-1` or `false`.

```vala
namespace DataStructuresBasics {
    public class Node {
        private int _value;
        private Node? _next;

        public int value { get { return _value; } }
        public Node? next {
            get { return _next; }
            set { _next = value; }
        }

        public Node(int value) {
            _value = value;
            _next = null;
        }
    }
}
```

---

## 🚀 Compilación y ejecución / Build & Run

```bash
valac --pkg glib-2.0 --pkg gobject-2.0 src/data_structures_basics.vala test/data_structures_basics_test.vala -o /tmp/vala-data-structures-basics-tests -X -w
/tmp/vala-data-structures-basics-tests
```

**Salida real / Actual output:**

```text
$ valac --pkg glib-2.0 --pkg gobject-2.0 src/data_structures_basics.vala test/data_structures_basics_test.vala -o /tmp/vala-data-structures-basics-tests -X -w
$ /tmp/vala-data-structures-basics-tests
TAP version 13
# random seed: R02S4fcaf1a7ff5a040cee0b1a1e4bb46f11
1..4
# Start of data_structures_basics tests
# Node should satisfy initialize-and-observe-value-link
# Node.value should equal 10 in initialize-and-observe-value-link; got 10
# Node.next should be absent in initialize-and-observe-value-link
# Node should satisfy initialize-link-and-traverse
# Node.next.value should equal 20 in initialize-link-and-traverse; got 20
# linked node next should be absent in initialize-link-and-traverse
ok 1 /data_structures_basics/node
# LinkedList should satisfy empty-state
# LinkedList.is_empty should be true in empty-state; got true
# LinkedList.size should equal 0 in empty-state; got 0
# LinkedList.head should equal -1 in empty-state; got -1
# LinkedList should satisfy insert-at-both-ends
# LinkedList.size should equal 4 in insert-at-both-ends; got 4
# LinkedList.head should equal 5 in insert-at-both-ends; got 5
# LinkedList should satisfy delete-first-occurrence
# LinkedList.delete should be true in delete-first-occurrence; got true
# LinkedList.head should equal 5 in delete-first-occurrence; got 5
# LinkedList.size should equal 3 in delete-first-occurrence; got 3
# LinkedList should satisfy absent-value
# LinkedList.delete should be false in absent-value; got false
# LinkedList.head should equal 5 in absent-value; got 5
# LinkedList.size should equal 3 in absent-value; got 3
# LinkedList should satisfy empty-the-list
# LinkedList.delete(head) should be true in empty-the-list; got true
# LinkedList.delete(middle) should be true in empty-the-list; got true
# LinkedList.delete(tail) should be true in empty-the-list; got true
# LinkedList.is_empty should be true in empty-the-list; got true
# LinkedList.size should equal 0 in empty-the-list; got 0
# LinkedList.head should equal -1 in empty-the-list; got -1
ok 2 /data_structures_basics/linked_list
# Stack should satisfy empty-state-and-failed-removal
# Stack.is_empty should be true in empty-state-and-failed-removal; got true
# Stack.size should equal 0 in empty-state-and-failed-removal; got 0
# Stack.peek should equal -1 in empty-state-and-failed-removal; got -1
# Stack.pop should equal -1 in empty-state-and-failed-removal; got -1
# Stack should satisfy lifo-and-non-mutating-peek
# Stack.peek should equal 30 in lifo-and-non-mutating-peek; got 30
# Stack.size should equal 3 in lifo-and-non-mutating-peek; got 3
# Stack should satisfy removal-and-reuse
# first Stack.pop should equal 30 in removal-and-reuse; got 30
# second Stack.pop should equal 40 in removal-and-reuse; got 40
# third Stack.pop should equal 20 in removal-and-reuse; got 20
# fourth Stack.pop should equal 10 in removal-and-reuse; got 10
# Stack.is_empty should be true in removal-and-reuse; got true
# Stack.size should equal 0 in removal-and-reuse; got 0
# Stack should satisfy empty-after-removal
# Stack.pop should equal -1 in empty-after-removal; got -1
# Stack.is_empty should be true in empty-after-removal; got true
ok 3 /data_structures_basics/stack
# Queue should satisfy empty-state-and-failed-removal
# Queue.is_empty should be true in empty-state-and-failed-removal; got true
# Queue.size should equal 0 in empty-state-and-failed-removal; got 0
# Queue.peek should equal -1 in empty-state-and-failed-removal; got -1
# Queue.dequeue should equal -1 in empty-state-and-failed-removal; got -1
# Queue should satisfy fifo-and-non-mutating-peek
# Queue.peek should equal 10 in fifo-and-non-mutating-peek; got 10
# Queue.size should equal 3 in fifo-and-non-mutating-peek; got 3
# Queue should satisfy removal-and-reuse
# first Queue.dequeue should equal 10 in removal-and-reuse; got 10
# second Queue.dequeue should equal 20 in removal-and-reuse; got 20
# third Queue.dequeue should equal 30 in removal-and-reuse; got 30
# fourth Queue.dequeue should equal 40 in removal-and-reuse; got 40
# Queue.is_empty should be true in removal-and-reuse; got true
# Queue.size should equal 0 in removal-and-reuse; got 0
# Queue should satisfy empty-after-removal
# Queue.dequeue should equal -1 in empty-after-removal; got -1
# Queue.is_empty should be true in empty-after-removal; got true
ok 4 /data_structures_basics/queue
# End of data_structures_basics tests
```

---

## 🧠 Algoritmos y operaciones / Algorithms & Operations

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `Node(value)` | `int → Node` | $O(1)$ | Constructor; fija valor y deja `next = null`. |
| `Node.value` | `void → int` | $O(1)$ | Propiedad pública de solo lectura. |
| `Node.next` | `void → Node?` / `Node? → void` | $O(1)$ | Getter y setter de enlace. Ausencia indicada por `null`. |
| `LinkedList()` | `void → LinkedList` | $O(1)$ | Constructor; lista vacía (`_head = _tail = null`, `_count = 0`). |
| `LinkedList.head` | `void → int` | $O(1)$ | Propiedad `get`; valor de cabeza o `-1` si está vacía. |
| `LinkedList.is_empty` | `void → bool` | $O(1)$ | Propiedad `get`; evalúa `_head == null`. |
| `LinkedList.size` | `void → int` | $O(1)$ | Propiedad `get`; retorna `_count`. |
| `LinkedList.insert_head(value)` | `int → void` | $O(1)$ | Inserta al inicio y ajusta `_tail` si estaba vacía; incrementa `_count`. |
| `LinkedList.insert_tail(value)` | `int → void` | $O(1)$ | Inserta al final usando puntero de cola; incrementa `_count`. |
| `LinkedList.delete(value)` | `int → bool` | $O(n)$ | Busca y elimina primera ocurrencia; retorna `true` si se eliminó, `false` si no existe. |
| `Stack()` | `void → Stack` | $O(1)$ | Constructor; pila vacía (`_top = null`, `_count = 0`). |
| `Stack.is_empty` | `void → bool` | $O(1)$ | Propiedad `get`; evalúa `_top == null`. |
| `Stack.size` | `void → int` | $O(1)$ | Propiedad `get`; retorna `_count`. |
| `Stack.peek` | `void → int` | $O(1)$ | Consulta cima sin extraer; `-1` si está vacía. |
| `Stack.push(value)` | `int → void` | $O(1)$ | Apila sobre `_top`; incrementa `_count`. |
| `Stack.pop()` | `void → int` | $O(1)$ | Desapila cima y decrementa `_count`; `-1` si está vacía. |
| `Queue()` | `void → Queue` | $O(1)$ | Constructor; cola vacía (`_front = _rear = null`, `_count = 0`). |
| `Queue.is_empty` | `void → bool` | $O(1)$ | Propiedad `get`; evalúa `_front == null`. |
| `Queue.size` | `void → int` | $O(1)$ | Propiedad `get`; retorna `_count`. |
| `Queue.peek` | `void → int` | $O(1)$ | Consulta frente sin extraer; `-1` si está vacía. |
| `Queue.enqueue(value)` | `int → void` | $O(1)$ | Encola al final usando `_rear`; incrementa `_count`. |
| `Queue.dequeue()` | `void → int` | $O(1)$ | Desencola frente y decrementa `_count`; `-1` si está vacía. |

---

## 🧩 Decisiones de diseño / Design decisions

| Decisión / Decision | Alternativa considerada / Alternative | Razón / Reason |
|---|---|---|
| Clases GObject (`public class`) | Estructuras (`struct`) | Los nodos y estructuras enlazadas requieren semántica por referencia y punteros nullables que las clases en Vala ofrecen de forma natural. |
| Propiedades Vala (`head`, `size`, `is_empty`, `peek`) | Métodos `get_*()` | En Vala, las propiedades de solo lectura son la forma idiomática de acceder a estado sin mutación manteniendo la convención de nomenclatura snake_case. |
| Puntero explícito a cola (`_tail` / `_rear`) | Recorrer lista para inserción al final | Permite $O(1)$ estricto en `insert_tail` y `enqueue` como exige el contrato. |
| Reutilización directa de `Node` en `Stack` y `Queue` | Reutilizar o envolver `LinkedList` | La especificación prohíbe que `Stack` y `Queue` deleguen en `LinkedList`; ambas gestionan sus propios punteros sobre `Node`. |

---

## 🔀 Adaptaciones idiomáticas / Idiomatic adaptations

| Especificación / Specification | Adaptación / Adaptation | Justificación / Justification |
|---|---|---|
| `init(value)` y `init()` | Constructores de clase (`public Node(int value)`, constructores por defecto) | En Vala, la inicialización formal se realiza en constructores (`new`); `new Node(10)` y `new LinkedList()` garantizan el estado inicial válido sin paso adicional. |
| `get_head()`, `is_empty()`, `size()`, `peek()` | Propiedades Vala de solo lectura (`head`, `is_empty`, `size`, `peek`) | Sintaxis idiomática en Vala que preserva la semántica observacional sin mutación. |
| `run_tests.ext` | Integración directa con GLib.Test en `main()` dentro de `test/data_structures_basics_test.vala` | La suite registra funciones con `Test.add_func` y ejecuta todo con `Test.run()`, prescindiendo de un runner externo redundante. |
| Ausencia de enlace (`absent`) | `null` con tipo nullable `Node?` | `Node?` representa de forma nativa e inequívoca la ausencia de nodo en Vala. |

---

## 🚨 Indicadores de fallo / Failure indicators

| Operación / Operation | Situación de fallo / Failure situation | Indicador / Indicator | Ejemplo / Example |
|---|---|---|---|
| `LinkedList.head` | Lista vacía | `-1` | `list.head == -1` |
| `LinkedList.delete` | Valor ausente en la lista | `false` | `list.delete(99) == false` |
| `Stack.peek` | Pila vacía | `-1` | `stack.peek == -1` |
| `Stack.pop` | Pila vacía | `-1` | `stack.pop() == -1` |
| `Queue.peek` | Cola vacía | `-1` | `queue.peek == -1` |
| `Queue.dequeue` | Cola vacía | `-1` | `queue.dequeue() == -1` |
| Entrada nula / Null input | Paso de valor nulo a tipos no nullables (`int`) | No representable | En Vala `int` no admite `null`; el dominio de prueba usa enteros válidos. |

---

## ✅ Cobertura de pruebas / Test coverage

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|---|:--:|---|
| `Node`: Inicializar y observar valor/enlace | Sí | `test_node` (`test/data_structures_basics_test.vala:43`) | Caso `initialize-and-observe-value-link`: verifica `value == 10` y `next == null`. |
| `Node`: Inicializar otro nodo, enlazar y recorrer | Sí | `test_node` (`test/data_structures_basics_test.vala:47`) | Caso `initialize-link-and-traverse`: enlaza nodo `20` y verifica traversal. |
| `LinkedList`: Estado vacío | Sí | `test_linked_list` (`test/data_structures_basics_test.vala:78`) | Caso `empty-state`: verifica `is_empty == true`, `size == 0`, `head == -1`. |
| `LinkedList`: Insertar por ambos extremos | Sí | `test_linked_list` (`test/data_structures_basics_test.vala:82`) | Caso `insert-at-both-ends`: inserta en tail y head; verifica `size == 4` y `head == 5`. |
| `LinkedList`: Eliminar primera aparición | Sí | `test_linked_list` (`test/data_structures_basics_test.vala:89`) | Caso `delete-first-occurrence`: elimina `10`, verifica retorno `true` y `size == 3`. |
| `LinkedList`: Valor ausente | Sí | `test_linked_list` (`test/data_structures_basics_test.vala:93`) | Caso `absent-value`: elimina `99`, verifica retorno `false` y tamaño sin cambios. |
| `LinkedList`: Vaciar | Sí | `test_linked_list` (`test/data_structures_basics_test.vala:97`) | Caso `empty-the-list`: elimina todos los elementos; verifica `is_empty == true`, `size == 0`, `head == -1`. |
| `Stack`: Estado vacío y extracción fallida | Sí | `test_stack` (`test/data_structures_basics_test.vala:125`) | Caso `empty-state-and-failed-removal`: verifica `is_empty == true`, `peek == -1`, `pop == -1`. |
| `Stack`: LIFO y `peek` no mutante | Sí | `test_stack` (`test/data_structures_basics_test.vala:130`) | Caso `lifo-and-non-mutating-peek`: apila 10, 20, 30; verifica `peek == 30`, `size == 3`. |
| `Stack`: Extracción y reutilización | Sí | `test_stack` (`test/data_structures_basics_test.vala:136`) | Caso `removal-and-reuse`: verifica secuencia de `pop` y re-inserción LIFO. |
| `Stack`: Vacío tras extracción | Sí | `test_stack` (`test/data_structures_basics_test.vala:144`) | Caso `empty-after-removal`: verifica extracción sobre pila vacía (`-1`). |
| `Queue`: Estado vacío y extracción fallida | Sí | `test_queue` (`test/data_structures_basics_test.vala:168`) | Caso `empty-state-and-failed-removal`: verifica `is_empty == true`, `peek == -1`, `dequeue == -1`. |
| `Queue`: FIFO y `peek` no mutante | Sí | `test_queue` (`test/data_structures_basics_test.vala:173`) | Caso `fifo-and-non-mutating-peek`: encola 10, 20, 30; verifica `peek == 10`, `size == 3`. |
| `Queue`: Extracción y reutilización | Sí | `test_queue` (`test/data_structures_basics_test.vala:179`) | Caso `removal-and-reuse`: verifica secuencia FIFO (`dequeue`), encolado y vaciado. |
| `Queue`: Vacío tras extracción | Sí | `test_queue` (`test/data_structures_basics_test.vala:187`) | Caso `empty-after-removal`: verifica extracción sobre cola vacía (`-1`). |

---

## ⚠️ Limitaciones conocidas / Known limitations

| Limitación / Limitation | Impacto / Impact | Alternativa o plan / Workaround or plan |
|---|---|---|
| Dominio de valores limitado a enteros primitivos (`int`) | No admite tipos genéricos en esta fase | Previsto para fases posteriores según el roadmap. |
| Centinela `-1` coincide con el entero `-1` | Si se insertase `-1`, colisionaría con el indicador de estructura vacía | Los casos de prueba usan enteros positivos; el modelado con `Option`/`Result` se aborda en Fase 4. |

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** Se conservan las cuatro estructuras solicitadas con mutación in-place. `Node` utiliza una referencia nullable `Node? _next` para enlazar celdas; al destruirse o reasignarse, GLib/GObject gestiona el conteo de referencias automáticamente.
- **EN:** All four requested structures are maintained with in-place mutation. `Node` uses a nullable `Node? _next` reference to chain cells; GLib/GObject manages reference counting upon reassignment or destruction.
- **ES:** `Stack` y `Queue` no heredan ni envuelven `LinkedList`. Cada estructura administra de manera directa sus punteros de celda (`_top` en `Stack`, `_front` y `_rear` en `Queue`), garantizando operaciones $O(1)$ sin sobrecarga.
- **EN:** `Stack` and `Queue` neither inherit nor wrap `LinkedList`. Each structure directly manages its cell pointers (`_top` in `Stack`, `_front` and `_rear` in `Queue`), ensuring $O(1)$ operations with zero delegation overhead.
- **ES:** En `LinkedList.delete`, cuando el nodo a eliminar es el apuntado por `_tail`, este puntero se actualiza correctamente a `previous`. Si la lista queda vacía tras un `dequeue` en `Queue`, `_rear` se reinicia a `null`.
- **EN:** In `LinkedList.delete`, when the removed node is targeted by `_tail`, the tail pointer is correctly updated to `previous`. When `Queue` becomes empty following a `dequeue`, `_rear` is reset to `null`.
- **ES:** Nota de desviación de layout: se mantiene `src/data_structures_basics.vala` y `test/data_structures_basics_test.vala`. No se genera un script `run_tests.vala` separado porque la suite ejecuta el runner nativo GLib.Test directamente a través de `main()`.

**ES:** Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para consultar las demás versiones.

**EN:** This project is also implemented in other languages. Explore the [main repository](https://github.com/yorche3/programming_languages) to see the other versions.

---

## 🔍 Checklist de validación / Validation checklist

- [x] La suite nativa se ejecutó y su salida real está copiada en este README.
- [x] Cada caso de la especificación tiene su fila en _Cobertura de pruebas_ (o `Omitido` con razón).
- [x] Cada desviación del pseudocódigo o de la ubicación esperada está en _Adaptaciones idiomáticas_.
- [x] Cada operación con fallo posible está en _Indicadores de fallo_.
- [x] No hay rutas absolutas del autor, credenciales ni salidas inventadas.
- [x] Los enlaces relativos resuelven dentro del repositorio y el documento es bilingüe.
- [x] Ninguna sección repite lo que ya dice la especificación.

---

## 📚 Referencias / References

| Tipo / Kind | Referencia / Reference |
|---|---|
| Especificación / Specification | [`06_Data_Structures_Basics.md`](../../../docs/core/algorithms/06_Data_Structures_Basics.md) |
| Módulo homologado del lenguaje / Homologated module | [`core/algorithms/naive_sort/`](../naive_sort/) |
| Guía de inicialización / Initialisation guide | [`core/00_Project_Initialization_Guide.md`](../../../docs/core/00_Project_Initialization_Guide.md) |
| Adaptaciones idiomáticas / Idiomatic adaptations | [`AGENT_Template.md`](../../../docs/AGENT_Template.md) |
| Validación de la documentación / Documentation validation | [`WORKFLOW.md`](../../../docs/WORKFLOW.md) |
| Documentación oficial del lenguaje / Language official docs | [Vala Documentation](https://vala.dev/) |

---

*[← Volver a Algoritmos Puros](../README.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
