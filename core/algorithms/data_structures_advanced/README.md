# Data Structures Advanced — Vala

Implementación de la especificación [07_Data_Structures_Advanced](https://yorche3.github.io/programming_languages/core/algorithms/07_Data_Structures_Advanced/) en **Vala**, con un enfoque manual y minimalista.

**ES:** Se implementa una celda base `Node`, un árbol binario de búsqueda (`BinaryTree`) sobre `TreeNode`, y un grafo dirigido (`Graph`) con registro enlazado canónico y adyacencia ordenada manual, probados mediante GLib.Test.

**EN:** A base cell `Node`, a binary search tree (`BinaryTree`) on `TreeNode`, and a directed graph (`Graph`) with a canonical linked registry and manual sorted adjacency are implemented from scratch, verified with GLib.Test.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directory | Propósito / Purpose |
|---|---|
| [`src/data_structures_advanced.vala`](src/data_structures_advanced.vala) | Base `Node`, `TreeNode`, `BinaryTree`, `GraphNode` y `Graph` bajo el namespace `DataStructuresAdvanced`. |
| [`test/data_structures_advanced_test.vala`](test/data_structures_advanced_test.vala) | Suite de pruebas unitarias sobre GLib.Test para `TreeNode`, `BinaryTree` y `Graph`. |
| [`meson.build`](meson.build) | Configuración de compilación Meson a nivel de módulo. |
| [`src/meson.build`](src/meson.build) | Definición de la librería compartida para Meson. |
| [`test/meson.build`](test/meson.build) | Definición del ejecutable de prueba para Meson. |
| [`.gitignore`](.gitignore) | Archivos y directorios ignorados (`build/`, binarios y artefactos C generados). |

```text
data_structures_advanced/
├── src/
│   ├── data_structures_advanced.vala
│   └── meson.build
├── test/
│   ├── data_structures_advanced_test.vala
│   └── meson.build
├── .gitignore
├── meson.build
└── README.md
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El módulo se diseñó manualmente dentro de la jerarquía estándar de Vala (`src/` y `test/`), compilando con `valac` y vinculando `glib-2.0` y `gobject-2.0`. La base `Node` es una clase abstracta que almacena únicamente el valor entero con constructor `protected`, de la cual heredan `TreeNode` y `GraphNode`. `BinaryTree` y `Graph` gestionan sus propios punteros y contadores de manera independiente y sin dependencias de colecciones estándar.

**EN:** The module was designed manually following standard Vala layout (`src/` and `test/`), compiling via `valac` linking `glib-2.0` and `gobject-2.0`. Base `Node` is an abstract class holding only the integer value with a `protected` constructor, inherited by `TreeNode` and `GraphNode`. `BinaryTree` and `Graph` independently manage their own pointers and counters without delegating to standard collection libraries.

### Inicialización / Initialization

```bash
mkdir -p vala/core/algorithms/data_structures_advanced/{src,test}
cd vala/core/algorithms/data_structures_advanced
```

---

## 📄 Configuración clave / Key Configuration

### `src/data_structures_advanced.vala`

**ES:** Las cinco clases residen en un único archivo bajo el namespace `DataStructuresAdvanced`. `Node` es abstracta; `TreeNode` expone propiedades `left` y `right` nulables (`TreeNode?`). `BinaryTree` implementa inserción y búsqueda iterativas preservando la invariante del ABB. `GraphNode` y `Graph` implementan el registro canónico enlazado y adyacencia ordenada manual en arrays `int[]` sin usar `libgee`.

**EN:** All five classes reside in a single file within the `DataStructuresAdvanced` namespace. `Node` is abstract; `TreeNode` exposes nullable `left` and `right` properties (`TreeNode?`). `BinaryTree` implements iterative insertion and search preserving the BST invariant. `GraphNode` and `Graph` implement the canonical linked registry and manual sorted adjacency in `int[]` arrays without using `libgee`.

---

## 🚀 Compilación y ejecución / Build & Run

```bash
valac --pkg glib-2.0 --pkg gobject-2.0 src/data_structures_advanced.vala test/data_structures_advanced_test.vala -o /tmp/vala-data-structures-advanced-tests -X -w
/tmp/vala-data-structures-advanced-tests
```

**Salida real / Actual output:**

```text
TAP version 13
# random seed: R02Sf8e9ee2bfc3d7730f17cb71dead55ece
1..23
# Start of data_structures_advanced tests
# Start of tree_node tests
# TreeNode.value should equal 10 in create-tree-node; got 10
ok 1 /data_structures_advanced/tree_node/create
# TreeNode.left should be absent in absent-initial-links
# TreeNode.right should be absent in absent-initial-links
ok 2 /data_structures_advanced/tree_node/absent_links
# TreeNode.left should be present in link-two-children
# TreeNode.left.value should equal 20 in link-two-children; got 20
# TreeNode.right should be present in link-two-children
# TreeNode.right.value should equal 30 in link-two-children; got 30
ok 3 /data_structures_advanced/tree_node/link_children
# TreeNode.left should be present in traverse-each-link
# TreeNode.left.value should equal 20 in traverse-each-link; got 20
# TreeNode.right should be present in traverse-each-link
# TreeNode.right.value should equal 30 in traverse-each-link; got 30
# left child left should be absent in traverse-each-link
# left child right should be absent in traverse-each-link
# right child left should be absent in traverse-each-link
# right child right should be absent in traverse-each-link
ok 4 /data_structures_advanced/tree_node/traverse
# TreeNode.left after clearing left should be absent in unlink-children
# TreeNode.value after clearing left should equal 10 in unlink-children; got 10
# TreeNode.right after clearing left should be present in unlink-children
# TreeNode.right after clearing left.value should equal 30 in unlink-children; got 30
# TreeNode.left after clearing right should be absent in unlink-children
# TreeNode.right after clearing right should be absent in unlink-children
# TreeNode.value after clearing right should equal 10 in unlink-children; got 10
ok 5 /data_structures_advanced/tree_node/unlink
# End of tree_node tests
# Start of binary_tree tests
# BinaryTree.is_empty should be true in create-empty; got true
# BinaryTree.size should equal 0 in create-empty; got 0
# BinaryTree.contains(50) should be false in create-empty; got false
ok 6 /data_structures_advanced/binary_tree/create_empty
# BinaryTree.insert(50) should be true in insert-root; got true
# BinaryTree.size should equal 1 in insert-root; got 1
# BinaryTree.is_empty should be false in insert-root; got false
# BinaryTree.contains(50) should be true in insert-root; got true
ok 7 /data_structures_advanced/binary_tree/insert_root
# BinaryTree.insert(50) should be true in insert-lower-and-higher; got true
# BinaryTree.insert(30) should be true in insert-lower-and-higher; got true
# BinaryTree.insert(70) should be true in insert-lower-and-higher; got true
# BinaryTree.size should equal 3 in insert-lower-and-higher; got 3
# BinaryTree.contains(50) should be true in insert-lower-and-higher; got true
# BinaryTree.contains(30) should be true in insert-lower-and-higher; got true
# BinaryTree.contains(70) should be true in insert-lower-and-higher; got true
ok 8 /data_structures_advanced/binary_tree/insert_lower_higher
# BinaryTree.insert(50) should be true in multilevel-branches; got true
# BinaryTree.insert(30) should be true in multilevel-branches; got true
# BinaryTree.insert(70) should be true in multilevel-branches; got true
# BinaryTree.insert(20) should be true in multilevel-branches; got true
# BinaryTree.insert(40) should be true in multilevel-branches; got true
# BinaryTree.contains(50) should be true in multilevel-branches; got true
# BinaryTree.contains(30) should be true in multilevel-branches; got true
# BinaryTree.contains(70) should be true in multilevel-branches; got true
# BinaryTree.contains(20) should be true in multilevel-branches; got true
# BinaryTree.contains(40) should be true in multilevel-branches; got true
# BinaryTree.size should equal 5 in multilevel-branches; got 5
ok 9 /data_structures_advanced/binary_tree/multilevel
# BinaryTree.insert(50) should be true in missing-value-nonempty; got true
# BinaryTree.contains(99) should be false in missing-value-nonempty; got false
# BinaryTree.size should equal 1 in missing-value-nonempty; got 1
# BinaryTree.contains(50) should be true in missing-value-nonempty; got true
ok 10 /data_structures_advanced/binary_tree/missing_value
# BinaryTree.insert(50) should be true in idempotent-duplicate; got true
# BinaryTree.insert(30) should be true in idempotent-duplicate; got true
# BinaryTree.insert(70) should be true in idempotent-duplicate; got true
# BinaryTree.insert(30) should be true in idempotent-duplicate; got true
# BinaryTree.size should equal 3 in idempotent-duplicate; got 3
# BinaryTree.contains(50) should be true in idempotent-duplicate; got true
# BinaryTree.contains(30) should be true in idempotent-duplicate; got true
# BinaryTree.contains(70) should be true in idempotent-duplicate; got true
ok 11 /data_structures_advanced/binary_tree/duplicate
# BinaryTree.insert(20) should be true in ordered-insertions; got true
# BinaryTree.insert(30) should be true in ordered-insertions; got true
# BinaryTree.insert(40) should be true in ordered-insertions; got true
# BinaryTree.insert(50) should be true in ordered-insertions; got true
# BinaryTree.insert(70) should be true in ordered-insertions; got true
# BinaryTree.size should equal 5 in ordered-insertions; got 5
# BinaryTree.contains(20) should be true in ordered-insertions; got true
# BinaryTree.contains(30) should be true in ordered-insertions; got true
# BinaryTree.contains(40) should be true in ordered-insertions; got true
# BinaryTree.contains(50) should be true in ordered-insertions; got true
# BinaryTree.contains(70) should be true in ordered-insertions; got true
# BinaryTree.contains(99) should be false in ordered-insertions; got false
ok 12 /data_structures_advanced/binary_tree/ordered
# End of binary_tree tests
# Start of graph tests
# Graph.is_empty should be true in create-empty; got true
# Graph.vertex_count should equal 0 in create-empty; got 0
# Graph.edge_count should equal 0 in create-empty; got 0
# Graph.has_edge(10,30) should be false in create-empty; got false
# Graph.get_neighbors(10) should be the failure indicator in create-empty
ok 13 /data_structures_advanced/graph/create_empty
# Graph.add_vertex(10) should be true in isolated-vertex; got true
# Graph.is_empty should be false in isolated-vertex; got false
# Graph.vertex_count should equal 1 in isolated-vertex; got 1
# Graph.edge_count should equal 0 in isolated-vertex; got 0
# Graph.get_neighbors(10) should equal 0 neighbours in isolated-vertex
ok 14 /data_structures_advanced/graph/isolated_vertex
# Graph.add_vertex(10) should be true in nonconsecutive-labels-directed-edge; got true
# Graph.add_vertex(70) should be true in nonconsecutive-labels-directed-edge; got true
# Graph.add_edge(10,70) should be true in nonconsecutive-labels-directed-edge; got true
# Graph.has_edge(10,70) should be true in nonconsecutive-labels-directed-edge; got true
# Graph.has_edge(70,10) should be false in nonconsecutive-labels-directed-edge; got false
# Graph.vertex_count should equal 2 in nonconsecutive-labels-directed-edge; got 2
# Graph.edge_count should equal 1 in nonconsecutive-labels-directed-edge; got 1
ok 15 /data_structures_advanced/graph/directed_edge
# Graph.add_vertex(10) should be true in duplicate-vertex-preserves-adjacency; got true
# Graph.add_vertex(30) should be true in duplicate-vertex-preserves-adjacency; got true
# Graph.add_edge(10,30) should be true in duplicate-vertex-preserves-adjacency; got true
# Graph.add_vertex(10) again should be true in duplicate-vertex-preserves-adjacency; got true
# Graph.vertex_count should equal 2 in duplicate-vertex-preserves-adjacency; got 2
# Graph.edge_count should equal 1 in duplicate-vertex-preserves-adjacency; got 1
# Graph.get_neighbors(10) should equal 1 neighbours in duplicate-vertex-preserves-adjacency
# Graph.get_neighbors(10) should have 30 at position 0 in duplicate-vertex-preserves-adjacency
ok 16 /data_structures_advanced/graph/duplicate_vertex
# Graph.add_vertex(10) should be true in duplicate-edge; got true
# Graph.add_vertex(30) should be true in duplicate-edge; got true
# Graph.add_edge(10,30) first should be true in duplicate-edge; got true
# Graph.add_edge(10,30) second should be true in duplicate-edge; got true
# Graph.vertex_count should equal 2 in duplicate-edge; got 2
# Graph.edge_count should equal 1 in duplicate-edge; got 1
# Graph.get_neighbors(10) should equal 1 neighbours in duplicate-edge
# Graph.get_neighbors(10) should have 30 at position 0 in duplicate-edge
ok 17 /data_structures_advanced/graph/duplicate_edge
# Graph.add_vertex(10) should be true in missing-endpoint-without-mutation; got true
# Graph.add_vertex(30) should be true in missing-endpoint-without-mutation; got true
# Graph.add_edge(10,30) should be true in missing-endpoint-without-mutation; got true
# Graph.add_edge(10,99) should be false in missing-endpoint-without-mutation; got false
# Graph.add_edge(99,10) should be false in missing-endpoint-without-mutation; got false
# Graph.add_edge(98,99) should be false in missing-endpoint-without-mutation; got false
# Graph.add_edge(99,99) should be false in missing-endpoint-without-mutation; got false
# Graph.vertex_count should equal 2 in missing-endpoint-without-mutation; got 2
# Graph.edge_count should equal 1 in missing-endpoint-without-mutation; got 1
# Graph.get_neighbors(10) should equal 1 neighbours in missing-endpoint-without-mutation
# Graph.get_neighbors(10) should have 30 at position 0 in missing-endpoint-without-mutation
# Graph.get_neighbors(30) should equal 0 neighbours in missing-endpoint-without-mutation
# Graph.has_edge(10,99) should be false in missing-endpoint-without-mutation; got false
# Graph.has_edge(99,10) should be false in missing-endpoint-without-mutation; got false
# Graph.has_edge(98,99) should be false in missing-endpoint-without-mutation; got false
# Graph.has_edge(99,99) should be false in missing-endpoint-without-mutation; got false
# Graph.get_neighbors(98) should be the failure indicator in missing-endpoint-without-mutation
# Graph.get_neighbors(99) should be the failure indicator in missing-endpoint-without-mutation
ok 18 /data_structures_advanced/graph/missing_endpoint
# Graph.add_vertex(10) should be true in sorted-neighbours-and-counts; got true
# Graph.add_vertex(30) should be true in sorted-neighbours-and-counts; got true
# Graph.add_vertex(50) should be true in sorted-neighbours-and-counts; got true
# Graph.add_vertex(70) should be true in sorted-neighbours-and-counts; got true
# Graph.add_edge(10,70) should be true in sorted-neighbours-and-counts; got true
# Graph.add_edge(10,30) should be true in sorted-neighbours-and-counts; got true
# Graph.add_edge(10,50) should be true in sorted-neighbours-and-counts; got true
# Graph.add_edge(30,50) should be true in sorted-neighbours-and-counts; got true
# Graph.get_neighbors(10) should equal 3 neighbours in sorted-neighbours-and-counts
# Graph.get_neighbors(10) should have 30 at position 0 in sorted-neighbours-and-counts
# Graph.get_neighbors(10) should have 50 at position 1 in sorted-neighbours-and-counts
# Graph.get_neighbors(10) should have 70 at position 2 in sorted-neighbours-and-counts
# Graph.get_neighbors(30) should equal 1 neighbours in sorted-neighbours-and-counts
# Graph.get_neighbors(30) should have 50 at position 0 in sorted-neighbours-and-counts
# Graph.get_neighbors(50) should equal 0 neighbours in sorted-neighbours-and-counts
# Graph.get_neighbors(70) should equal 0 neighbours in sorted-neighbours-and-counts
# Graph.vertex_count should equal 4 in sorted-neighbours-and-counts; got 4
# Graph.edge_count should equal 4 in sorted-neighbours-and-counts; got 4
ok 19 /data_structures_advanced/graph/sorted_neighbours
# Graph.add_vertex(10) should be true in missing-edge-query; got true
# Graph.add_vertex(30) should be true in missing-edge-query; got true
# Graph.has_edge(10,30) should be false in missing-edge-query; got false
# Graph.vertex_count should equal 2 in missing-edge-query; got 2
# Graph.edge_count should equal 0 in missing-edge-query; got 0
# Graph.is_empty should be false in missing-edge-query; got false
ok 20 /data_structures_advanced/graph/missing_edge
# Graph.add_vertex(10) should be true in neighbours-of-missing-vertex; got true
# Graph.get_neighbors(99) should be the failure indicator in neighbours-of-missing-vertex
# Graph.get_neighbors(10) should equal 0 neighbours in neighbours-of-missing-vertex
# Graph.vertex_count should equal 1 in neighbours-of-missing-vertex; got 1
# Graph.edge_count should equal 0 in neighbours-of-missing-vertex; got 0
ok 21 /data_structures_advanced/graph/missing_vertex_neighbours
# Graph.add_vertex(10) should be true in self-loop-and-duplicate; got true
# Graph.add_edge(10,10) first should be true in self-loop-and-duplicate; got true
# Graph.add_edge(10,10) second should be true in self-loop-and-duplicate; got true
# Graph.has_edge(10,10) should be true in self-loop-and-duplicate; got true
# Graph.get_neighbors(10) should equal 1 neighbours in self-loop-and-duplicate
# Graph.get_neighbors(10) should have 10 at position 0 in self-loop-and-duplicate
# Graph.vertex_count should equal 1 in self-loop-and-duplicate; got 1
# Graph.edge_count should equal 1 in self-loop-and-duplicate; got 1
ok 22 /data_structures_advanced/graph/self_loop
# Graph.add_vertex(10) should be true in neighbour-result-isolation; got true
# Graph.add_vertex(30) should be true in neighbour-result-isolation; got true
# Graph.add_vertex(50) should be true in neighbour-result-isolation; got true
# Graph.add_edge(10,30) should be true in neighbour-result-isolation; got true
# saved neighbours after changing copy should equal 1 neighbours in neighbour-result-isolation
# saved neighbours after changing copy should have 30 at position 0 in neighbour-result-isolation
# Graph.get_neighbors(10) after changing copy should equal 1 neighbours in neighbour-result-isolation
# Graph.get_neighbors(10) after changing copy should have 30 at position 0 in neighbour-result-isolation
# Graph.add_edge(10,50) should be true in neighbour-result-isolation; got true
# saved neighbours after later edge should equal 1 neighbours in neighbour-result-isolation
# saved neighbours after later edge should have 30 at position 0 in neighbour-result-isolation
# fresh Graph.get_neighbors(10) should equal 2 neighbours in neighbour-result-isolation
# fresh Graph.get_neighbors(10) should have 30 at position 0 in neighbour-result-isolation
# fresh Graph.get_neighbors(10) should have 50 at position 1 in neighbour-result-isolation
# Graph.vertex_count should equal 3 in neighbour-result-isolation; got 3
# Graph.edge_count should equal 2 in neighbour-result-isolation; got 2
ok 23 /data_structures_advanced/graph/neighbour_isolation
# End of graph tests
# End of data_structures_advanced tests
```

---

## 🧠 Algoritmos y operaciones / Algorithms & Operations

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `Node.value` | `void → int` | $O(1)$ | Propiedad pública de solo lectura expuesta por la base abstracta. |
| `TreeNode(value)` | `int → TreeNode` | $O(1)$ | Constructor; llama a `base(value)` e inicializa `left` y `right` en `null`. |
| `TreeNode.left` | `void → TreeNode?` / `TreeNode? → void` | $O(1)$ | Getter y setter para enlace izquierdo. Ausencia como `null`. |
| `TreeNode.right` | `void → TreeNode?` / `TreeNode? → void` | $O(1)$ | Getter y setter para enlace derecho. Ausencia como `null`. |
| `BinaryTree()` | `void → BinaryTree` | $O(1)$ | Constructor; inicializa árbol vacío (`_root = null`, `_count = 0`). |
| `BinaryTree.is_empty` | `void → bool` | $O(1)$ | Propiedad `get`; evalúa `_count == 0`. |
| `BinaryTree.size` | `void → int` | $O(1)$ | Propiedad `get`; retorna `_count`. |
| `BinaryTree.insert(value)` | `int → bool` | $O(h)$ | Inserta preservando invariante ABB; bucle iterativo sin recursión. Duplicados retornan `true` sin alterar tamaño. |
| `BinaryTree.contains(value)` | `int → bool` | $O(h)$ | Búsqueda iterativa por ramas del ABB; retorna `true` si existe o `false` si no. |
| `Graph()` | `void → Graph` | $O(1)$ | Constructor; inicializa grafo vacío (`_vertices = null`, `_vertex_count = 0`, `_edge_count = 0`). |
| `Graph.is_empty` | `void → bool` | $O(1)$ | Propiedad `get`; evalúa `_vertex_count == 0`. |
| `Graph.vertex_count` | `void → int` | $O(1)$ | Propiedad `get`; retorna cantidad de vértices. |
| `Graph.edge_count` | `void → int` | $O(1)$ | Propiedad `get`; retorna cantidad de aristas dirigidas. |
| `Graph.add_vertex(label)` | `int → bool` | $O(V)$ | Inserta nodo al frente del registro enlazado si no existe; duplicado retorna `true` sin alterar conteo. |
| `Graph.add_edge(u, v)` | `int, int → bool` | $O(V + d(u))$ | Inserta arista dirigida `u → v` ordenada en adyacencia. Falla si falta un extremo (`false`); duplicado retorna `true`. |
| `Graph.has_edge(u, v)` | `int, int → bool` | $O(V + d(u))$ | Consulta existencia de arista en adyacencia ordenada; retorna `false` si falta un extremo o arista. |
| `Graph.get_neighbors(u, out bool found)` | `int → int[]` | $O(V + d(u))$ | Retorna copia de secuencia ordenada de vecinos. `found` es `false` si `u` no existe, `true` si existe (array vacío si aislado). |

---

## 🧩 Decisiones de diseño / Design decisions

| Decisión / Decision | Alternativa considerada / Alternative | Razón / Reason |
|---|---|---|
| Clase base `abstract class Node` con constructor `protected` | `interface` o estructuras separadas | Cumple la herencia solicitada en el contrato garantizando que `Node` almacene solo el valor sin poder instanciarse directamente. |
| Iteración con bucles en `BinaryTree.insert` y `contains` | Recursión directa o acumulador | En Vala la TCO no está garantizada por el compilador C subyacente; el recorrido iterativo evita desbordamiento de pila y garantiza $O(h)$ en espacio auxiliar $O(1)$. |
| Adyacencia con array dinámico manual `int[]` en `GraphNode` | `Gee.ArrayList` o lista enlazada propia de vecinos | Evita dependencias externas (`libgee`), mantiene el módulo dependiente solo de `glib-2.0` y respeta la cota $O(d(u))$ al insertar ordenado y al copiar vecinos. |
| Parámetro de salida `out bool found` en `Graph.get_neighbors` | Retornar `int[]?` o centinela en array | En la representación C generada por Vala para arrays primitivos (`int[]`), distinguir un puntero nulo de un array vacío puede ser ambiguo; `out bool found` separa limpiamente la existencia del vértice (`found`) de la secuencia de adyacencia devuelta. |
| Propiedades Vala (`left`, `right`, `size`, `is_empty`, etc.) | Métodos `get_*()` y `set_*()` | Sintaxis idiomática en Vala que preserva la semántica observacional de acceso a estado sin mutación respetando snake_case. |

---

## 🔀 Adaptaciones idiomáticas / Idiomatic adaptations

| Especificación / Specification | Adaptación / Adaptation | Justificación / Justification |
|---|---|---|
| `init(value)` y `init()` | Constructores de clase (`public TreeNode(int value)`, `public BinaryTree()`, `public Graph()`) | En Vala, la inicialización formal se realiza en constructores (`new`), garantizando estado inicial consistente. |
| `get_left()`, `set_left()`, `get_right()`, `set_right()` | Propiedades Vala `left` y `right` con getters/setters | Idiomático en Vala para atributos encapsulados. |
| `get_value()`, `size()`, `is_empty()`, `vertex_count()`, `edge_count()` | Propiedades Vala de solo lectura | Idiomático en Vala para consultas de estado sin mutación. |
| Ausencia de enlace o vértice (`absent`) | `null` con tipos anulables `TreeNode?` y `GraphNode?` | `null` es la representación nativa de ausencia de referencia en Vala. |
| `run_tests.ext` | Integración directa con GLib.Test en `main()` dentro de `test/data_structures_advanced_test.vala` | La suite registra funciones con `Test.add_func` y ejecuta todo con `Test.run()`, prescindiendo de un runner externo redundante. |
| Indicador de vértice inexistente en `get_neighbors` | `out bool found` con retorno `int[]` | Permite distinguir inequívocamente el vértice inexistente (`found = false`) del aislado (`found = true` y array vacío). |
| Adaptación inmutable de `TreeNode` | Omitido | En Vala las clases son tipos por referencia mutables in-place; la semántica del módulo es imperativa. |

---

## 🚨 Indicadores de fallo / Failure indicators

| Operación / Operation | Situación de fallo / Failure situation | Indicador / Indicator | Ejemplo / Example |
|---|---|---|---|
| `BinaryTree.contains(value)` | Valor ausente en el árbol | `false` | `tree.contains(99) == false` |
| `Graph.add_edge(u, v)` | Extremo `u` o `v` inexistente en el grafo | `false` | `graph.add_edge(10, 99) == false` |
| `Graph.has_edge(u, v)` | Extremo `u` o `v` inexistente, o arista inexistente | `false` | `graph.has_edge(10, 30) == false` |
| `Graph.get_neighbors(u, out found)` | Vértice `u` inexistente en el grafo | `found = false` | `graph.get_neighbors(99, out found); found == false` |
| Entrada nula / Null input | Paso de valor nulo a tipos primitivos `int` | No representable | En Vala `int` no admite `null`; los identificadores y valores son enteros válidos. |

---

## ✅ Cobertura de pruebas / Test coverage

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|---|:--:|---|
| `TreeNode`: Crear un nodo de árbol | Sí | `test_tree_node_create` (`test/data_structures_advanced_test.vala:64`) | Caso `create-tree-node`: verifica `value == 10`. |
| `TreeNode`: Enlaces iniciales ausentes | Sí | `test_tree_node_absent_links` (`test/data_structures_advanced_test.vala:70`) | Caso `absent-initial-links`: verifica `left == null` y `right == null`. |
| `TreeNode`: Enlazar dos hijos | Sí | `test_tree_node_link_children` (`test/data_structures_advanced_test.vala:77`) | Caso `link-two-children`: enlaza 20 y 30; verifica `left.value == 20` y `right.value == 30`. |
| `TreeNode`: Recorrer cada enlace | Sí | `test_tree_node_traverse` (`test/data_structures_advanced_test.vala:85`) | Caso `traverse-each-link`: verifica recorrido a hijos y enlaces ausentes en hojas. |
| `TreeNode`: Desenlazar hijos | Sí | `test_tree_node_unlink` (`test/data_structures_advanced_test.vala:97`) | Caso `unlink-children`: desenlaza `left` y luego `right`, verificando preservación de valores. |
| `TreeNode`: Adaptación inmutable | Omitido | — | No aplica: Vala implementa estructuras mutables in-place para clases. |
| `BinaryTree`: Crear vacío | Sí | `test_tree_create_empty` (`test/data_structures_advanced_test.vala:111`) | Caso `create-empty`: verifica `is_empty == true`, `size == 0`, `contains(50) == false`. |
| `BinaryTree`: Insertar la raíz | Sí | `test_tree_insert_root` (`test/data_structures_advanced_test.vala:118`) | Caso `insert-root`: inserta 50; verifica `size == 1`, `is_empty == false`, `contains(50) == true`. |
| `BinaryTree`: Insertar menor y mayor | Sí | `test_tree_insert_lower_higher` (`test/data_structures_advanced_test.vala:126`) | Caso `insert-lower-and-higher`: inserta 50, 30, 70; verifica `size == 3` y pertenencia. |
| `BinaryTree`: Ramas de varios niveles | Sí | `test_tree_multilevel` (`test/data_structures_advanced_test.vala:133`) | Caso `multilevel-branches`: inserta 50, 30, 70, 20, 40; verifica `size == 5` y pertenencia. |
| `BinaryTree`: Valor ausente en árbol no vacío | Sí | `test_tree_missing_value` (`test/data_structures_advanced_test.vala:140`) | Caso `missing-value-nonempty`: verifica `contains(99) == false` y `size == 1`. |
| `BinaryTree`: Duplicado idempotente | Sí | `test_tree_duplicate` (`test/data_structures_advanced_test.vala:148`) | Caso `idempotent-duplicate`: inserta 50, 30, 70, 30; verifica `size == 3` y valores preservados. |
| `BinaryTree`: Inserciones ordenadas | Sí | `test_tree_ordered` (`test/data_structures_advanced_test.vala:155`) | Caso `ordered-insertions`: inserta 20, 30, 40, 50, 70; verifica `size == 5`, pertenencia y ausencia de 99. |
| `Graph`: Crear vacío | Sí | `test_graph_create_empty` (`test/data_structures_advanced_test.vala:163`) | Caso `create-empty`: verifica `is_empty == true`, contadores en 0, `has_edge` y `get_neighbors` fallan. |
| `Graph`: Vértice aislado | Sí | `test_graph_isolated_vertex` (`test/data_structures_advanced_test.vala:171`) | Caso `isolated-vertex`: registra 10; verifica `vertex_count == 1`, `edge_count == 0`, vecinos vacíos. |
| `Graph`: Etiquetas no consecutivas y arista dirigida | Sí | `test_graph_directed_edge` (`test/data_structures_advanced_test.vala:179`) | Caso `nonconsecutive-labels-directed-edge`: registra 10 y 70, arista `10 → 70`; verifica dirección. |
| `Graph`: Vértice duplicado conserva adyacencia | Sí | `test_graph_duplicate_vertex` (`test/data_structures_advanced_test.vala:188`) | Caso `duplicate-vertex-preserves-adjacency`: registra 10, 30, arista y re-añade 10; verifica vecinos `[30]`. |
| `Graph`: Arista duplicada | Sí | `test_graph_duplicate_edge` (`test/data_structures_advanced_test.vala:198`) | Caso `duplicate-edge`: añade `(10, 30)` dos veces; verifica contadores (2 vértices, 1 arista) y vecinos `[30]`. |
| `Graph`: Extremo inexistente sin mutación | Sí | `test_graph_missing_endpoint` (`test/data_structures_advanced_test.vala:207`) | Caso `missing-endpoint-without-mutation`: intentos fallidos con extremos ausentes; verifica no mutación. |
| `Graph`: Vecinos ordenados y contadores | Sí | `test_graph_sorted_neighbours` (`test/data_structures_advanced_test.vala:227`) | Caso `sorted-neighbours-and-counts`: registra 4 vértices y 4 aristas; verifica orden y contadores. |
| `Graph`: Consulta de arista ausente | Sí | `test_graph_missing_edge` (`test/data_structures_advanced_test.vala:242`) | Caso `missing-edge-query`: consulta arista no conectada; verifica retorno `false` y contadores intactos. |
| `Graph`: Vecinos de vértice inexistente | Sí | `test_graph_missing_vertex_neighbours` (`test/data_structures_advanced_test.vala:250`) | Caso `neighbours-of-missing-vertex`: consulta 99; verifica fallo distinto a lista vacía de aislado. |
| `Graph`: Bucle y duplicado | Sí | `test_graph_self_loop` (`test/data_structures_advanced_test.vala:258`) | Caso `self-loop-and-duplicate`: añade `(10, 10)` dos veces; verifica contadores (1 vértice, 1 arista) y vecinos `[10]`. |
| `Graph`: Aislamiento del resultado de vecinos | Sí | `test_graph_neighbour_isolation` (`test/data_structures_advanced_test.vala:268`) | Caso `neighbour-result-isolation`: mutar la copia devuelta no altera adyacencia interna ni consultas posteriores. |

**Organización lógica de la suite / Logical suite mapping:**
- `TreeNode` → 5 casos aplicables → `/data_structures_advanced/tree_node/*` → `test/data_structures_advanced_test.vala` → GLib.Test (`Test.run()`).
- `BinaryTree` → 7 casos aplicables → `/data_structures_advanced/binary_tree/*` → `test/data_structures_advanced_test.vala` → GLib.Test (`Test.run()`).
- `Graph` → 11 casos aplicables → `/data_structures_advanced/graph/*` → `test/data_structures_advanced_test.vala` → GLib.Test (`Test.run()`).

---

## ⚠️ Limitaciones conocidas / Known limitations

| Limitación / Limitation | Impacto / Impact | Alternativa o plan / Workaround or plan |
|---|---|---|
| Dominio de valores limitado a enteros primitivos (`int`) | No admite tipos genéricos en esta fase | Previsto para fases posteriores según el roadmap. |
| Árbol binario no balanceado | Inserciones ordenadas degeneran en altura $O(n)$ | Comportamiento esperado para un BST educativo no balanceado según la especificación. |

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** Se implementa la jerarquía requerida: `Node` actúa como base abstracta con constructor protegido que almacena únicamente el entero `_value`. `TreeNode` y `GraphNode` heredan de `Node`, validando y exponiendo sus propios enlaces y adyacencias.
- **EN:** The required hierarchy is implemented: `Node` acts as an abstract base with a protected constructor holding only the integer `_value`. `TreeNode` and `GraphNode` inherit from `Node`, validating and exposing their own links and adjacency.
- **ES:** `BinaryTree` y `Graph` son ADTs independientes. Las operaciones de inserción y búsqueda en `BinaryTree` se realizan de forma iterativa, garantizando la complejidad $O(h)$ sin riesgo de desbordamiento de pila por falta de TCO garantizada en el backend C.
- **EN:** `BinaryTree` and `Graph` are independent ADTs. Insert and contains operations in `BinaryTree` execute iteratively, guaranteeing $O(h)$ time without stack overflow risks given the absence of guaranteed TCO in the C backend.
- **ES:** `Graph` mantiene su propio registro canónico de vértices enlazados (`GraphNode.next_vertex`). La lista de adyacencia se mantiene ordenada en un array `int[]` mediante inserción ordenada manual, cumpliendo $O(d(u))$ sin dependencias de librerías externas. `get_neighbors` devuelve una copia aislada y señala existencia con `out bool found`.
- **EN:** `Graph` maintains its own canonical linked vertex registry (`GraphNode.next_vertex`). Adjacency lists remain sorted in an `int[]` array via manual sorted insertion, meeting $O(d(u))$ without external library dependencies. `get_neighbors` returns an isolated copy and indicates vertex existence via `out bool found`.
- **ES:** Desviación de layout: se mantiene `src/data_structures_advanced.vala` y `test/data_structures_advanced_test.vala` con ejecución directa de GLib.Test mediante `valac`; no se requiere script `run_tests.vala` adicional.
- **EN:** Layout deviation note: standard Vala layout `src/data_structures_advanced.vala` and `test/data_structures_advanced_test.vala` is maintained using GLib.Test via `valac`; no separate `run_tests.vala` script is needed.

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
| Especificación / Specification | [`07_Data_Structures_Advanced.md`](../../../../docs/core/algorithms/07_Data_Structures_Advanced.md) |
| Primera base del lenguaje / First language reference | `data_structures_basics` — [`../data_structures_basics/README.md`](../data_structures_basics/README.md) |
| Segunda base del lenguaje / Second language reference | `numbers` — [`../../foundations/numbers/README.md`](../../foundations/numbers/README.md) |
| Guía de inicialización / Initialisation guide | [`core/00_Project_Initialization_Guide.md`](../../../../docs/core/00_Project_Initialization_Guide.md) |
| Adaptaciones idiomáticas / Idiomatic adaptations | [`AGENT_Template.md`](../../../../docs/AGENT_Template.md) |
| Validación de la documentación / Documentation validation | [`WORKFLOW.md`](../../../../docs/WORKFLOW.md) |
| Documentación oficial del lenguaje / Language official docs | [Vala Documentation](https://vala.dev/) |

---

*[← Volver a Algoritmos Puros](../README.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
