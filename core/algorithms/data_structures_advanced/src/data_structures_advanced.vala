/* data_structures_advanced — Node, TreeNode, BinaryTree, GraphNode y Graph.
 *
 * Especificación: 07_Data_Structures_Advanced
 *
 * Contrato: la base `Node` contiene solo el valor y no se instancia (es
 * `abstract`, con constructor `protected`); `TreeNode` la reutiliza por
 * herencia y añade los dos enlaces, y `GraphNode` la reutiliza igual y añade su
 * adyacencia y el enlace al siguiente vértice del registro canónico. Naming
 * snake_case, el mismo de la especificación y de la base
 * `data_structures_basics`.
 *
 * Adecuaciones declaradas:
 *   - **Ausencia de enlace**: `TreeNode?` con `null`, la forma nativa de Vala
 *     (la base del lenguaje ya lo usa en `Node.next`).
 *   - **Vértice inexistente frente a aislado**: `get_neighbors` devuelve
 *     `int[]?`; `null` es el vértice que no existe y un array vacío el que
 *     existe sin vecinos. Vala distingue los dos valores sin centinelas.
 *   - **Adyacencia**: `int[]` con inserción ordenada escrita a mano. No se usa
 *     `Gee.ArrayList` —el comando del módulo solo enlaza `glib-2.0`— ni
 *     `contains`, `index_of` o `sort` de la biblioteca.
 *   - **Mutabilidad**: nodos y estructuras mutan en sitio, como en la base, así
 *     que cada escenario trabaja con una instancia.
 *
 * Indicadores de fallo (valores representables, sin excepciones):
 *   - **bool**: `insert`, `contains`, `is_empty`, `add_vertex`, `add_edge`,
 *     `has_edge`. Un alta duplicada o una arista repetida devuelven `true`:
 *     son éxito y no suman al contador.
 *   - **null**: `get_neighbors` de un vértice inexistente.
 *
 * Los cuerpos de las consultas triviales leen su campo; las operaciones de la
 * especificación están implementadas: recorridos propios sobre el ABB y sobre
 * el registro enlazado, sin colecciones de biblioteca.
 */

namespace DataStructuresAdvanced {

    /**
     * Base local del módulo: solo el valor. Sin enlaces, sin validaciones y sin
     * instancias propias; el constructor es `protected` y la clase `abstract`.
     */
    public abstract class Node {
        private int _value;

        protected Node(int value) {
            this._value = value;
        }

        /** Valor de la celda (el `get_value()` del contrato). */
        public int value {
            get { return this._value; }
        }
    }

    /**
     * Nodo propio del ABB: valor heredado y dos enlaces que valida este nodo.
     * Un enlace ausente es `null`.
     */
    public class TreeNode : Node {
        private TreeNode? _left;
        private TreeNode? _right;

        /** `init(value)` de la especificación: valor heredado, enlaces ausentes. */
        public TreeNode(int value) {
            base(value);
            this._left = null;
            this._right = null;
        }

        /** Enlace izquierdo, o `null` cuando está ausente. */
        public TreeNode? left {
            get { return this._left; }
            set { this._left = value; }
        }

        /** Enlace derecho, o `null` cuando está ausente. */
        public TreeNode? right {
            get { return this._right; }
            set { this._right = value; }
        }
    }

    /**
     * ABB sin capacidad contractual. Raíz propia y contador de valores
     * distintos; los duplicados no crecen el tamaño.
     */
    public class BinaryTree {
        private TreeNode? _root;
        private int _count;

        /** `init()` de la especificación: raíz ausente y contador a cero. */
        public BinaryTree() {
            this._root = null;
            this._count = 0;
        }

        /**
         * Inserta `value`; un duplicado también es éxito y no crece el tamaño.
         * Desciende por la invariante del ABB con un bucle, sin recursión.
         */
        public bool insert(int value) {
            if (this._root == null) {
                this._root = new TreeNode(value);
                this._count++;
                return true;
            }
            TreeNode? current = this._root;
            while (current != null) {
                if (value == current.value) {
                    return true;
                }
                if (value < current.value) {
                    if (current.left == null) {
                        current.left = new TreeNode(value);
                        this._count++;
                        return true;
                    }
                    current = current.left;
                } else {
                    if (current.right == null) {
                        current.right = new TreeNode(value);
                        this._count++;
                        return true;
                    }
                    current = current.right;
                }
            }
            return true;
        }

        /** `true` si `value` pertenece al árbol; `false` si no. */
        public bool contains(int value) {
            TreeNode? current = this._root;
            while (current != null) {
                if (value == current.value) {
                    return true;
                }
                if (value < current.value) {
                    current = current.left;
                } else {
                    current = current.right;
                }
            }
            return false;
        }

        /** `true` solo si no hay nodos. */
        public bool is_empty {
            get { return this._count == 0; }
        }

        /** Número de valores distintos del árbol. */
        public int size {
            get { return this._count; }
        }
    }

    /**
     * Vértice del registro canónico: etiqueta, adyacencia ordenada y enlace al
     * siguiente vértice. Interno a `Graph`.
     */
    internal class GraphNode : Node {
        internal int[] neighbors;
        internal GraphNode? next_vertex;

        /** `init(label)` interno: sin vecinos y sin siguiente. */
        internal GraphNode(int label) {
            base(label);
            this.neighbors = new int[0];
            this.next_vertex = null;
        }

        /** `true` si `label` figura en la adyacencia; se recorre a mano. */
        internal bool has_neighbor(int label) {
            for (int i = 0; i < this.neighbors.length; i++) {
                if (this.neighbors[i] == label) {
                    return true;
                }
            }
            return false;
        }

        /**
         * Inserta `label` en su posición creciente y devuelve `true`; si ya era
         * vecino devuelve `false`, así que el grafo no cuenta arista nueva. La
         * posición se busca recorriendo la adyacencia a mano.
         */
        internal bool add_neighbor(int label) {
            if (this.has_neighbor(label)) {
                return false;
            }
            int position = 0;
            while (position < this.neighbors.length
                   && this.neighbors[position] < label) {
                position++;
            }
            int[] updated = new int[this.neighbors.length + 1];
            for (int i = 0; i < position; i++) {
                updated[i] = this.neighbors[i];
            }
            updated[position] = label;
            for (int i = position; i < this.neighbors.length; i++) {
                updated[i + 1] = this.neighbors[i];
            }
            this.neighbors = updated;
            return true;
        }
    }

    /**
     * Grafo dirigido con registro enlazado de vértices escrito a mano y
     * contadores separados de vértices y aristas.
     */
    public class Graph {
        private GraphNode? _vertices;
        private int _vertex_count;
        private int _edge_count;

        /** `init()` de la especificación: registro ausente y contadores a cero. */
        public Graph() {
            this._vertices = null;
            this._vertex_count = 0;
            this._edge_count = 0;
        }

        /** Búsqueda lineal por etiqueta sobre el registro enlazado. */
        private GraphNode? find_vertex(int label) {
            GraphNode? current = this._vertices;
            while (current != null) {
                if (current.value == label) {
                    return current;
                }
                current = current.next_vertex;
            }
            return null;
        }

        /** Registra `label`; un duplicado también es éxito y conserva vecinos. */
        public bool add_vertex(int label) {
            if (this.find_vertex(label) != null) {
                return true;
            }
            GraphNode new_vertex = new GraphNode(label);
            new_vertex.next_vertex = this._vertices;
            this._vertices = new_vertex;
            this._vertex_count++;
            return true;
        }

        /**
         * Añade la arista `u → v`; falla si falta un extremo y no muta. Una
         * arista repetida o un bucle repetido también son éxito, pero no
         * cuentan.
         */
        public bool add_edge(int u, int v) {
            GraphNode? vertex_u = this.find_vertex(u);
            GraphNode? vertex_v = this.find_vertex(v);
            if (vertex_u == null || vertex_v == null) {
                return false;
            }
            if (vertex_u.add_neighbor(v)) {
                this._edge_count++;
            }
            return true;
        }

        /** `true` si la arista `u → v` existe; falla si falta un extremo. */
        public bool has_edge(int u, int v) {
            GraphNode? vertex_u = this.find_vertex(u);
            if (vertex_u == null) {
                return false;
            }
            return vertex_u.has_neighbor(v);
        }

        /**
         * Vecinos de `u` en orden creciente como copia independiente. `found`
         * distingue el vértice inexistente (`false`) del aislado (`true` con
         * array vacío): en Vala un array vacío y uno nulo comparten puntero,
         * así que la existencia viaja en el parámetro de salida.
         */
        public int[] get_neighbors(int u, out bool found) {
            GraphNode? vertex_u = this.find_vertex(u);
            if (vertex_u == null) {
                found = false;
                return new int[0];
            }
            found = true;
            int[] result = new int[vertex_u.neighbors.length];
            for (int i = 0; i < vertex_u.neighbors.length; i++) {
                result[i] = vertex_u.neighbors[i];
            }
            return result;
        }

        /** `true` solo si no hay vértices. */
        public bool is_empty {
            get { return this._vertex_count == 0; }
        }

        /** Número de vértices registrados. */
        public int vertex_count {
            get { return this._vertex_count; }
        }

        /** Número de aristas registradas. */
        public int edge_count {
            get { return this._edge_count; }
        }
    }
}
