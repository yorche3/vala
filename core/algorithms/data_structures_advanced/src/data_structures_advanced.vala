namespace DataStructuresAdvanced {
    public abstract class Node {
        protected Node(int value) {
        }

        public int value {
            get { return -1; }
        }
    }

    public class TreeNode : Node {
        public TreeNode(int value) {
            base(value);
        }

        public TreeNode? left {
            get { return null; }
            set { }
        }

        public TreeNode? right {
            get { return null; }
            set { }
        }
    }

    public class BinaryTree {
        public BinaryTree() {
        }

        public bool insert(int value) {
            return false;
        }

        public bool contains(int value) {
            return false;
        }

        public bool is_empty {
            get { return false; }
        }

        public int size {
            get { return -1; }
        }
    }

    internal class GraphNode : Node {
        internal GraphNode(int label) {
            base(label);
        }
    }

    public class Graph {
        public Graph() {
        }

        public bool add_vertex(int label) {
            return false;
        }

        public bool add_edge(int u, int v) {
            return false;
        }

        public bool has_edge(int u, int v) {
            return false;
        }

        public int[]? get_neighbors(int u) {
            return null;
        }

        public bool is_empty {
            get { return false; }
        }

        public int vertex_count {
            get { return -1; }
        }

        public int edge_count {
            get { return -1; }
        }
    }
}
