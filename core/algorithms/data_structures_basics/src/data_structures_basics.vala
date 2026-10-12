/* data_structures_basics — Node, lista enlazada, pila y cola.
 *
 * Especificación: 06_Data_Structures_Basics
 *
 * Contrato: un único tipo de celda, `Node`, compartido por las tres estructuras
 * (`LinkedList`, `Stack` y `Queue`); cada una guarda sus propios punteros y su
 * contador y no delega en `LinkedList`. El valor de la celda se fija al
 * construirla y el enlace se reengancha con la propiedad `next`.
 * API (naming snake_case, el mismo de la especificación y de
 * `core/algorithms/naive_sort/`): `Node` — `value`, `next`; `LinkedList` —
 * `head`, `is_empty`, `size`, `insert_head`, `insert_tail`, `delete`; `Stack` —
 * `push`, `pop`, `peek`, `is_empty`, `size`; `Queue` — `enqueue`, `dequeue`,
 * `peek`, `is_empty`, `size`.
 *
 * Adecuaciones de salida de centinela (todavía no hay fallos reales):
 *   - **int → -1**: `value`, `head`, `pop`, `peek`, `dequeue` y `size` mientras su
 *     cuerpo sea un esqueleto.
 *   - **bool → false**: `is_empty` y `delete`.
 *   - **Solo los nodos y los enlaces usan nulo**: `next` es `Node?` y `null` es la
 *     ausencia de enlace. Ningún cuerpo lanza excepciones.
 *
 * `init` de la especificación: en Vala la inicialización es el constructor, así
 * que `new Node(valor)` deja la celda con su valor y sin enlace, y
 * `new LinkedList()` —igual `Stack` y `Queue`— deja la estructura vacía. Los
 * constructores quedan implementados y el resto de los cuerpos son esqueletos con
 * el centinela de su tipo: la implementación es el paso 5.
 *
 * Un solo archivo: el módulo tiene cuatro tipos y todavía no se considera grande,
 * así que viven juntos; se separarán por archivo (struct o class) el día que
 * crezca.
 */

namespace DataStructuresBasics {

    /**
     * Celda enlazada compartida por LinkedList, Stack y Queue.
     * El valor es inmutable tras la construcción; el enlace es mutable.
     */
    public class Node {
        private int _value;
        private Node? _next;

        /**
         * Esqueleto: valor de la celda. El centinela es -1 mientras su cuerpo sea
         * un esqueleto.
         */
        public int value {
            get { return _value; }
        }

        /**
         * Esqueleto: enlace a la celda siguiente, o null cuando no hay ninguna.
         */
        public Node? next {
            get { return _next; }
            set { _next = value; }
        }

        /**
         * Crea la celda con `value` y el enlace ausente (el `init(value)` de la
         * especificación). Queda implementado: es el estado inicial del contrato.
         */
        public Node(int value) {
            _value = value;
            _next  = null;
        }
    }

    /**
     * Lista enlazada simple construida desde cero sobre Node.
     * El constructor por defecto deja la lista vacía (el `init()` de la
     * especificación). Los campos arrancan vacíos, así que queda implementado.
     */
    public class LinkedList {
        private Node? _head = null;
        private Node? _tail = null;
        private int _count = 0;

        /**
         * Crea la lista vacía (el `init()` de la especificación). Queda
         * implementado: es el estado inicial del contrato.
         */
        public LinkedList() {
            _head  = null;
            _tail  = null;
            _count = 0;
        }

        /**
         * Esqueleto: valor de la cabeza, o -1 cuando la lista está vacía. No muta.
         */
        public int head {
            get { return _head != null ? _head.value : -1; }
        }

        /** Esqueleto: true solo si no hay nodos. */
        public bool is_empty {
            get { return _head == null; }
        }

        /** Esqueleto: número de nodos (el centinela es -1 mientras sea esqueleto). */
        public int size {
            get { return _count; }
        }

        /** Esqueleto: inserta al principio. O(1). Sin resultado de fallo. */
        public void insert_head(int value) {
            Node new_head = new Node(value);
            new_head.next = _head;
            _head = new_head;
            if (_tail == null) {
                _tail = new_head;
            }
            _count++;
        }

        /** Esqueleto: inserta al final. O(1). Sin resultado de fallo. */
        public void insert_tail(int value) {
            Node new_tail = new Node(value);
            if (_tail != null) {
                _tail.next = new_tail;
            } else {
                _head = new_tail;
            }
            _tail = new_tail;
            _count++;
        }

        /**
         * Esqueleto: borra la primera aparición; false cuando el valor no estaba.
         * O(n).
         */
        public bool delete(int value) {
            Node? previous = null;
            Node? current = _head;
            while (current != null) {
                if (current.value == value) {
                    if (previous != null) {
                        previous.next = current.next;
                    } else {
                        _head = current.next;
                    }
                    if (_tail == current) {
                        _tail = previous;
                    }
                    _count--;
                    return true;
                }
                previous = current;
                current = current.next;
            }
            return false;
        }
    }

    /**
     * Pila LIFO construida desde cero sobre Node.
     * El constructor por defecto deja la pila vacía (el `init()` de la
     * especificación). Los campos arrancan vacíos, así que queda implementado.
     */
    public class Stack {
        private Node? _top = null;
        private int _count = 0;

        /**
         * Crea la pila vacía (el `init()` de la especificación). Queda
         * implementado: es el estado inicial del contrato.
         */
        public Stack() {
            _top   = null;
            _count = 0;
        }

        /** Esqueleto: true solo si no hay nodos. */
        public bool is_empty {
            get { return _top == null; }
        }

        /** Esqueleto: número de nodos (el centinela es -1 mientras sea esqueleto). */
        public int size {
            get { return _count; }
        }

        /** Esqueleto: valor de la cima, o -1 cuando está vacía. No muta. */
        public int peek {
            get { return _top != null ? _top.value : -1; }
        }

        /** Esqueleto: apila sobre la cima. O(1). Sin resultado de fallo. */
        public void push(int value) {
            Node new_top = new Node(value);
            new_top.next = _top;
            _top = new_top;
            _count++;
        }

        /** Esqueleto: desapila el valor de la cima, o -1 cuando está vacía. O(1). */
        public int pop() {
            if (_top != null) {
                int value = _top.value;
                _top = _top.next;
                _count--;
                return value;
            }
            return -1;
        }
    }

    /**
     * Cola FIFO construida desde cero sobre Node.
     * El constructor por defecto deja la cola vacía (el `init()` de la
     * especificación). Los campos arrancan vacíos, así que queda implementado.
     */
    public class Queue {
        private Node? _front = null;
        private Node? _rear = null;
        private int _count = 0;

        /**
         * Crea la cola vacía (el `init()` de la especificación). Queda
         * implementado: es el estado inicial del contrato.
         */
        public Queue() {
            _front = null;
            _rear  = null;
            _count = 0;
        }

        /** Esqueleto: true solo si no hay nodos. */
        public bool is_empty {
            get { return _front == null; }
        }

        /** Esqueleto: número de nodos (el centinela es -1 mientras sea esqueleto). */
        public int size {
            get { return _count; }
        }

        /** Esqueleto: valor del frente, o -1 cuando está vacía. No muta. */
        public int peek {
            get { return _front != null ? _front.value : -1; }
        }

        /** Esqueleto: encola por el final. O(1). Sin resultado de fallo. */
        public void enqueue(int value) {
            Node new_rear = new Node(value);
            if (_rear != null) {
                _rear.next = new_rear;
            } else {
                _front = new_rear;
            }
            _rear = new_rear;
            _count++;
        }

        /**
         * Esqueleto: desencola el valor del frente, o -1 cuando está vacía. O(1).
         */
        public int dequeue() {
            if (_front != null) {
                int value = _front.value;
                _front = _front.next;
                if (_front == null) {
                    _rear = null;
                }
                _count--;
                return value;
            }
            return -1;
        }
    }
}
