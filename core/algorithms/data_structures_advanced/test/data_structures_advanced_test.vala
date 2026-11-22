using DataStructuresAdvanced;

private void expect_int(string case_name, string subject, int actual, int expected) {
    Test.message("%s should equal %d in %s; got %d", subject, expected, case_name, actual);
    assert(actual == expected);
}

private void expect_bool(string case_name, string subject, bool actual, bool expected) {
    Test.message("%s should be %s in %s; got %s",
                 subject,
                 expected.to_string(),
                 case_name,
                 actual.to_string());
    assert(actual == expected);
}

private void expect_absent(string case_name, string subject, DataStructuresAdvanced.TreeNode? actual) {
    Test.message("%s should be absent in %s", subject, case_name);
    assert(actual == null);
}

private void expect_linked_value(string case_name, string subject, DataStructuresAdvanced.TreeNode? actual, int expected) {
    Test.message("%s should be present in %s", subject, case_name);
    assert(actual != null);
    expect_int(case_name, subject + ".value", actual.value, expected);
}

private void expect_neighbours(string case_name, string subject, int[] actual, int[] expected) {
    Test.message("%s should equal %d neighbours in %s", subject, expected.length, case_name);
    assert(actual.length == expected.length);
    for (int i = 0; i < expected.length; i++) {
        Test.message("%s should have %d at position %d in %s", subject, expected[i], i, case_name);
        assert(actual[i] == expected[i]);
    }
}

private void expect_graph_neighbours(string case_name, string subject, Graph graph, int label, int[] expected) {
    bool found;
    int[] actual = graph.get_neighbors(label, out found);
    assert(found);
    expect_neighbours(case_name, subject, actual, expected);
}

private void expect_graph_neighbours_absent(string case_name, string subject, Graph graph, int label) {
    Test.message("%s should be the failure indicator in %s", subject, case_name);
    bool found;
    graph.get_neighbors(label, out found);
    assert(!found);
}

private void expect_tree_present(string case_name, BinaryTree tree, int[] values) {
    foreach (int value in values) {
        expect_bool(case_name, "BinaryTree.contains(%d)".printf(value), tree.contains(value), true);
    }
}

private void expect_tree_inserts(string case_name, BinaryTree tree, int[] values) {
    foreach (int value in values) {
        expect_bool(case_name, "BinaryTree.insert(%d)".printf(value), tree.insert(value), true);
    }
}

private void expect_graph_counts(string case_name, Graph graph, int vertices, int edges) {
    expect_int(case_name, "Graph.vertex_count", graph.vertex_count, vertices);
    expect_int(case_name, "Graph.edge_count", graph.edge_count, edges);
}

private void expect_graph_vertices(string case_name, Graph graph, int[] labels) {
    foreach (int label in labels) {
        expect_bool(case_name, "Graph.add_vertex(%d)".printf(label), graph.add_vertex(label), true);
    }
}

private void test_tree_node_create() {
    string case_name = "create-tree-node";
    DataStructuresAdvanced.TreeNode node = new DataStructuresAdvanced.TreeNode(10);
    expect_int(case_name, "TreeNode.value", node.value, 10);
}

private void test_tree_node_absent_links() {
    string case_name = "absent-initial-links";
    DataStructuresAdvanced.TreeNode node = new DataStructuresAdvanced.TreeNode(10);
    expect_absent(case_name, "TreeNode.left", node.left);
    expect_absent(case_name, "TreeNode.right", node.right);
}

private void test_tree_node_link_children() {
    string case_name = "link-two-children";
    DataStructuresAdvanced.TreeNode parent = new DataStructuresAdvanced.TreeNode(10);
    parent.left = new DataStructuresAdvanced.TreeNode(20);
    parent.right = new DataStructuresAdvanced.TreeNode(30);
    expect_linked_value(case_name, "TreeNode.left", parent.left, 20);
    expect_linked_value(case_name, "TreeNode.right", parent.right, 30);
}

private void test_tree_node_traverse() {
    string case_name = "traverse-each-link";
    DataStructuresAdvanced.TreeNode parent = new DataStructuresAdvanced.TreeNode(10);
    parent.left = new DataStructuresAdvanced.TreeNode(20);
    parent.right = new DataStructuresAdvanced.TreeNode(30);
    expect_linked_value(case_name, "TreeNode.left", parent.left, 20);
    expect_linked_value(case_name, "TreeNode.right", parent.right, 30);
    expect_absent(case_name, "left child left", parent.left.left);
    expect_absent(case_name, "left child right", parent.left.right);
    expect_absent(case_name, "right child left", parent.right.left);
    expect_absent(case_name, "right child right", parent.right.right);
}

private void test_tree_node_unlink() {
    string case_name = "unlink-children";
    DataStructuresAdvanced.TreeNode parent = new DataStructuresAdvanced.TreeNode(10);
    parent.left = new DataStructuresAdvanced.TreeNode(20);
    parent.right = new DataStructuresAdvanced.TreeNode(30);
    parent.left = null;
    expect_absent(case_name, "TreeNode.left after clearing left", parent.left);
    expect_int(case_name, "TreeNode.value after clearing left", parent.value, 10);
    expect_linked_value(case_name, "TreeNode.right after clearing left", parent.right, 30);
    parent.right = null;
    expect_absent(case_name, "TreeNode.left after clearing right", parent.left);
    expect_absent(case_name, "TreeNode.right after clearing right", parent.right);
    expect_int(case_name, "TreeNode.value after clearing right", parent.value, 10);
}

private void test_tree_create_empty() {
    string case_name = "create-empty";
    BinaryTree tree = new BinaryTree();
    expect_bool(case_name, "BinaryTree.is_empty", tree.is_empty, true);
    expect_int(case_name, "BinaryTree.size", tree.size, 0);
    expect_bool(case_name, "BinaryTree.contains(50)", tree.contains(50), false);
}

private void test_tree_insert_root() {
    string case_name = "insert-root";
    BinaryTree tree = new BinaryTree();
    expect_bool(case_name, "BinaryTree.insert(50)", tree.insert(50), true);
    expect_int(case_name, "BinaryTree.size", tree.size, 1);
    expect_bool(case_name, "BinaryTree.is_empty", tree.is_empty, false);
    expect_bool(case_name, "BinaryTree.contains(50)", tree.contains(50), true);
}

private void test_tree_insert_lower_higher() {
    string case_name = "insert-lower-and-higher";
    BinaryTree tree = new BinaryTree();
    expect_tree_inserts(case_name, tree, {50, 30, 70});
    expect_int(case_name, "BinaryTree.size", tree.size, 3);
    expect_tree_present(case_name, tree, {50, 30, 70});
}

private void test_tree_multilevel() {
    string case_name = "multilevel-branches";
    BinaryTree tree = new BinaryTree();
    expect_tree_inserts(case_name, tree, {50, 30, 70, 20, 40});
    expect_tree_present(case_name, tree, {50, 30, 70, 20, 40});
    expect_int(case_name, "BinaryTree.size", tree.size, 5);
}

private void test_tree_missing_value() {
    string case_name = "missing-value-nonempty";
    BinaryTree tree = new BinaryTree();
    expect_bool(case_name, "BinaryTree.insert(50)", tree.insert(50), true);
    expect_bool(case_name, "BinaryTree.contains(99)", tree.contains(99), false);
    expect_int(case_name, "BinaryTree.size", tree.size, 1);
    expect_bool(case_name, "BinaryTree.contains(50)", tree.contains(50), true);
}

private void test_tree_duplicate() {
    string case_name = "idempotent-duplicate";
    BinaryTree tree = new BinaryTree();
    expect_tree_inserts(case_name, tree, {50, 30, 70, 30});
    expect_int(case_name, "BinaryTree.size", tree.size, 3);
    expect_tree_present(case_name, tree, {50, 30, 70});
}

private void test_tree_ordered() {
    string case_name = "ordered-insertions";
    BinaryTree tree = new BinaryTree();
    expect_tree_inserts(case_name, tree, {20, 30, 40, 50, 70});
    expect_int(case_name, "BinaryTree.size", tree.size, 5);
    expect_tree_present(case_name, tree, {20, 30, 40, 50, 70});
    expect_bool(case_name, "BinaryTree.contains(99)", tree.contains(99), false);
}

private void test_graph_create_empty() {
    string case_name = "create-empty";
    Graph graph = new Graph();
    expect_bool(case_name, "Graph.is_empty", graph.is_empty, true);
    expect_graph_counts(case_name, graph, 0, 0);
    expect_bool(case_name, "Graph.has_edge(10,30)", graph.has_edge(10, 30), false);
    expect_graph_neighbours_absent(case_name, "Graph.get_neighbors(10)", graph, 10);
}

private void test_graph_isolated_vertex() {
    string case_name = "isolated-vertex";
    Graph graph = new Graph();
    expect_bool(case_name, "Graph.add_vertex(10)", graph.add_vertex(10), true);
    expect_bool(case_name, "Graph.is_empty", graph.is_empty, false);
    expect_graph_counts(case_name, graph, 1, 0);
    expect_graph_neighbours(case_name, "Graph.get_neighbors(10)", graph, 10, {});
}

private void test_graph_directed_edge() {
    string case_name = "nonconsecutive-labels-directed-edge";
    Graph graph = new Graph();
    expect_graph_vertices(case_name, graph, {10, 70});
    expect_bool(case_name, "Graph.add_edge(10,70)", graph.add_edge(10, 70), true);
    expect_bool(case_name, "Graph.has_edge(10,70)", graph.has_edge(10, 70), true);
    expect_bool(case_name, "Graph.has_edge(70,10)", graph.has_edge(70, 10), false);
    expect_graph_counts(case_name, graph, 2, 1);
}

private void test_graph_duplicate_vertex() {
    string case_name = "duplicate-vertex-preserves-adjacency";
    Graph graph = new Graph();
    expect_graph_vertices(case_name, graph, {10, 30});
    expect_bool(case_name, "Graph.add_edge(10,30)", graph.add_edge(10, 30), true);
    expect_bool(case_name, "Graph.add_vertex(10) again", graph.add_vertex(10), true);
    expect_graph_counts(case_name, graph, 2, 1);
    expect_graph_neighbours(case_name, "Graph.get_neighbors(10)", graph, 10, {30});
}

private void test_graph_duplicate_edge() {
    string case_name = "duplicate-edge";
    Graph graph = new Graph();
    expect_graph_vertices(case_name, graph, {10, 30});
    expect_bool(case_name, "Graph.add_edge(10,30) first", graph.add_edge(10, 30), true);
    expect_bool(case_name, "Graph.add_edge(10,30) second", graph.add_edge(10, 30), true);
    expect_graph_counts(case_name, graph, 2, 1);
    expect_graph_neighbours(case_name, "Graph.get_neighbors(10)", graph, 10, {30});
}

private void test_graph_missing_endpoint() {
    string case_name = "missing-endpoint-without-mutation";
    Graph graph = new Graph();
    expect_graph_vertices(case_name, graph, {10, 30});
    expect_bool(case_name, "Graph.add_edge(10,30)", graph.add_edge(10, 30), true);
    expect_bool(case_name, "Graph.add_edge(10,99)", graph.add_edge(10, 99), false);
    expect_bool(case_name, "Graph.add_edge(99,10)", graph.add_edge(99, 10), false);
    expect_bool(case_name, "Graph.add_edge(98,99)", graph.add_edge(98, 99), false);
    expect_bool(case_name, "Graph.add_edge(99,99)", graph.add_edge(99, 99), false);
    expect_graph_counts(case_name, graph, 2, 1);
    expect_graph_neighbours(case_name, "Graph.get_neighbors(10)", graph, 10, {30});
    expect_graph_neighbours(case_name, "Graph.get_neighbors(30)", graph, 30, {});
    expect_bool(case_name, "Graph.has_edge(10,99)", graph.has_edge(10, 99), false);
    expect_bool(case_name, "Graph.has_edge(99,10)", graph.has_edge(99, 10), false);
    expect_bool(case_name, "Graph.has_edge(98,99)", graph.has_edge(98, 99), false);
    expect_bool(case_name, "Graph.has_edge(99,99)", graph.has_edge(99, 99), false);
    expect_graph_neighbours_absent(case_name, "Graph.get_neighbors(98)", graph, 98);
    expect_graph_neighbours_absent(case_name, "Graph.get_neighbors(99)", graph, 99);
}

private void test_graph_sorted_neighbours() {
    string case_name = "sorted-neighbours-and-counts";
    Graph graph = new Graph();
    expect_graph_vertices(case_name, graph, {10, 30, 50, 70});
    expect_bool(case_name, "Graph.add_edge(10,70)", graph.add_edge(10, 70), true);
    expect_bool(case_name, "Graph.add_edge(10,30)", graph.add_edge(10, 30), true);
    expect_bool(case_name, "Graph.add_edge(10,50)", graph.add_edge(10, 50), true);
    expect_bool(case_name, "Graph.add_edge(30,50)", graph.add_edge(30, 50), true);
    expect_graph_neighbours(case_name, "Graph.get_neighbors(10)", graph, 10, {30, 50, 70});
    expect_graph_neighbours(case_name, "Graph.get_neighbors(30)", graph, 30, {50});
    expect_graph_neighbours(case_name, "Graph.get_neighbors(50)", graph, 50, {});
    expect_graph_neighbours(case_name, "Graph.get_neighbors(70)", graph, 70, {});
    expect_graph_counts(case_name, graph, 4, 4);
}

private void test_graph_missing_edge() {
    string case_name = "missing-edge-query";
    Graph graph = new Graph();
    expect_graph_vertices(case_name, graph, {10, 30});
    expect_bool(case_name, "Graph.has_edge(10,30)", graph.has_edge(10, 30), false);
    expect_graph_counts(case_name, graph, 2, 0);
    expect_bool(case_name, "Graph.is_empty", graph.is_empty, false);
}

private void test_graph_missing_vertex_neighbours() {
    string case_name = "neighbours-of-missing-vertex";
    Graph graph = new Graph();
    expect_bool(case_name, "Graph.add_vertex(10)", graph.add_vertex(10), true);
    expect_graph_neighbours_absent(case_name, "Graph.get_neighbors(99)", graph, 99);
    expect_graph_neighbours(case_name, "Graph.get_neighbors(10)", graph, 10, {});
    expect_graph_counts(case_name, graph, 1, 0);
}

private void test_graph_self_loop() {
    string case_name = "self-loop-and-duplicate";
    Graph graph = new Graph();
    expect_bool(case_name, "Graph.add_vertex(10)", graph.add_vertex(10), true);
    expect_bool(case_name, "Graph.add_edge(10,10) first", graph.add_edge(10, 10), true);
    expect_bool(case_name, "Graph.add_edge(10,10) second", graph.add_edge(10, 10), true);
    expect_bool(case_name, "Graph.has_edge(10,10)", graph.has_edge(10, 10), true);
    expect_graph_neighbours(case_name, "Graph.get_neighbors(10)", graph, 10, {10});
    expect_graph_counts(case_name, graph, 1, 1);
}

private void test_graph_neighbour_isolation() {
    string case_name = "neighbour-result-isolation";
    Graph graph = new Graph();
    expect_graph_vertices(case_name, graph, {10, 30, 50});
    expect_bool(case_name, "Graph.add_edge(10,30)", graph.add_edge(10, 30), true);
    bool saved_found;
    int[] saved = graph.get_neighbors(10, out saved_found);
    assert(saved_found);
    bool copy_found;
    int[] copy = graph.get_neighbors(10, out copy_found);
    assert(copy_found);
    copy[0] = 99;
    expect_neighbours(case_name, "saved neighbours after changing copy", saved, {30});
    expect_graph_neighbours(case_name, "Graph.get_neighbors(10) after changing copy",
                            graph, 10, {30});
    expect_bool(case_name, "Graph.add_edge(10,50)", graph.add_edge(10, 50), true);
    expect_neighbours(case_name, "saved neighbours after later edge", saved, {30});
    expect_graph_neighbours(case_name, "fresh Graph.get_neighbors(10)", graph, 10, {30, 50});
    expect_graph_counts(case_name, graph, 3, 2);
}

public int main(string[] args) {
    Test.init(ref args);
    Test.add_func("/data_structures_advanced/tree_node/create", test_tree_node_create);
    Test.add_func("/data_structures_advanced/tree_node/absent_links", test_tree_node_absent_links);
    Test.add_func("/data_structures_advanced/tree_node/link_children", test_tree_node_link_children);
    Test.add_func("/data_structures_advanced/tree_node/traverse", test_tree_node_traverse);
    Test.add_func("/data_structures_advanced/tree_node/unlink", test_tree_node_unlink);
    Test.add_func("/data_structures_advanced/binary_tree/create_empty", test_tree_create_empty);
    Test.add_func("/data_structures_advanced/binary_tree/insert_root", test_tree_insert_root);
    Test.add_func("/data_structures_advanced/binary_tree/insert_lower_higher", test_tree_insert_lower_higher);
    Test.add_func("/data_structures_advanced/binary_tree/multilevel", test_tree_multilevel);
    Test.add_func("/data_structures_advanced/binary_tree/missing_value", test_tree_missing_value);
    Test.add_func("/data_structures_advanced/binary_tree/duplicate", test_tree_duplicate);
    Test.add_func("/data_structures_advanced/binary_tree/ordered", test_tree_ordered);
    Test.add_func("/data_structures_advanced/graph/create_empty", test_graph_create_empty);
    Test.add_func("/data_structures_advanced/graph/isolated_vertex", test_graph_isolated_vertex);
    Test.add_func("/data_structures_advanced/graph/directed_edge", test_graph_directed_edge);
    Test.add_func("/data_structures_advanced/graph/duplicate_vertex", test_graph_duplicate_vertex);
    Test.add_func("/data_structures_advanced/graph/duplicate_edge", test_graph_duplicate_edge);
    Test.add_func("/data_structures_advanced/graph/missing_endpoint", test_graph_missing_endpoint);
    Test.add_func("/data_structures_advanced/graph/sorted_neighbours", test_graph_sorted_neighbours);
    Test.add_func("/data_structures_advanced/graph/missing_edge", test_graph_missing_edge);
    Test.add_func("/data_structures_advanced/graph/missing_vertex_neighbours", test_graph_missing_vertex_neighbours);
    Test.add_func("/data_structures_advanced/graph/self_loop", test_graph_self_loop);
    Test.add_func("/data_structures_advanced/graph/neighbour_isolation", test_graph_neighbour_isolation);
    return Test.run();
}
