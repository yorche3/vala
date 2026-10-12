using DataStructuresBasics;

private delegate void CaseRunner(string case_name);

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

private void expect_absent(string case_name, string subject, DataStructuresBasics.Node? actual) {
    Test.message("%s should be absent in %s", subject, case_name);
    assert(actual == null);
}

private void run_cases(string subject, string[] case_names, CaseRunner runner) {
    foreach (unowned string case_name in case_names) {
        Test.message("%s should satisfy %s", subject, case_name);
        runner(case_name);
    }
}

private void test_node() {
    int first_node_input = 10;
    int first_node_expected_value = 10;
    int second_node_input = 20;
    int second_node_expected_value = 20;
    string[] case_names = {
        "initialize-and-observe-value-link",
        "initialize-link-and-traverse"
    };
    DataStructuresBasics.Node? first_node = null;

    run_cases("Node", case_names, (case_name) => {
        if (case_name == "initialize-and-observe-value-link") {
            first_node = new DataStructuresBasics.Node(first_node_input);
            expect_int(case_name, "Node.value", first_node.value, first_node_expected_value);
            expect_absent(case_name, "Node.next", first_node.next);
        } else {
            DataStructuresBasics.Node second_node = new DataStructuresBasics.Node(second_node_input);
            first_node.next = second_node;
            expect_int(case_name, "Node.next.value", first_node.next.value,
                       second_node_expected_value);
            expect_absent(case_name, "linked node next", second_node.next);
        }
    });
}

private void test_linked_list() {
    int head_input = 5;
    int first_tail_input = 10;
    int second_tail_input = 20;
    int repeated_tail_input = 10;
    int absent_value_input = 99;
    int expected_populated_size = 4;
    int expected_head_after_insert = 5;
    int expected_size_after_delete = 3;
    int expected_empty_size = 0;
    int failure_indicator = -1;
    string[] case_names = {
        "empty-state",
        "insert-at-both-ends",
        "delete-first-occurrence",
        "absent-value",
        "empty-the-list"
    };
    LinkedList list = new LinkedList();

    run_cases("LinkedList", case_names, (case_name) => {
        if (case_name == "empty-state") {
            expect_bool(case_name, "LinkedList.is_empty", list.is_empty, true);
            expect_int(case_name, "LinkedList.size", list.size, expected_empty_size);
            expect_int(case_name, "LinkedList.head", list.head, failure_indicator);
        } else if (case_name == "insert-at-both-ends") {
            list.insert_tail(first_tail_input);
            list.insert_tail(second_tail_input);
            list.insert_head(head_input);
            list.insert_tail(repeated_tail_input);
            expect_int(case_name, "LinkedList.size", list.size, expected_populated_size);
            expect_int(case_name, "LinkedList.head", list.head, expected_head_after_insert);
        } else if (case_name == "delete-first-occurrence") {
            expect_bool(case_name, "LinkedList.delete", list.delete(first_tail_input), true);
            expect_int(case_name, "LinkedList.head", list.head, expected_head_after_insert);
            expect_int(case_name, "LinkedList.size", list.size, expected_size_after_delete);
        } else if (case_name == "absent-value") {
            expect_bool(case_name, "LinkedList.delete", list.delete(absent_value_input), false);
            expect_int(case_name, "LinkedList.head", list.head, expected_head_after_insert);
            expect_int(case_name, "LinkedList.size", list.size, expected_size_after_delete);
        } else {
            expect_bool(case_name, "LinkedList.delete(head)", list.delete(head_input), true);
            expect_bool(case_name, "LinkedList.delete(middle)", list.delete(second_tail_input), true);
            expect_bool(case_name, "LinkedList.delete(tail)", list.delete(repeated_tail_input), true);
            expect_bool(case_name, "LinkedList.is_empty", list.is_empty, true);
            expect_int(case_name, "LinkedList.size", list.size, expected_empty_size);
            expect_int(case_name, "LinkedList.head", list.head, failure_indicator);
        }
    });
}

private void test_stack() {
    int first_input = 10;
    int second_input = 20;
    int third_input = 30;
    int reused_input = 40;
    int expected_size = 3;
    int expected_empty_size = 0;
    int failure_indicator = -1;
    string[] case_names = {
        "empty-state-and-failed-removal",
        "lifo-and-non-mutating-peek",
        "removal-and-reuse",
        "empty-after-removal"
    };
    Stack stack = new Stack();

    run_cases("Stack", case_names, (case_name) => {
        if (case_name == "empty-state-and-failed-removal") {
            expect_bool(case_name, "Stack.is_empty", stack.is_empty, true);
            expect_int(case_name, "Stack.size", stack.size, expected_empty_size);
            expect_int(case_name, "Stack.peek", stack.peek, failure_indicator);
            expect_int(case_name, "Stack.pop", stack.pop(), failure_indicator);
        } else if (case_name == "lifo-and-non-mutating-peek") {
            stack.push(first_input);
            stack.push(second_input);
            stack.push(third_input);
            expect_int(case_name, "Stack.peek", stack.peek, third_input);
            expect_int(case_name, "Stack.size", stack.size, expected_size);
        } else if (case_name == "removal-and-reuse") {
            expect_int(case_name, "first Stack.pop", stack.pop(), third_input);
            stack.push(reused_input);
            expect_int(case_name, "second Stack.pop", stack.pop(), reused_input);
            expect_int(case_name, "third Stack.pop", stack.pop(), second_input);
            expect_int(case_name, "fourth Stack.pop", stack.pop(), first_input);
            expect_bool(case_name, "Stack.is_empty", stack.is_empty, true);
            expect_int(case_name, "Stack.size", stack.size, expected_empty_size);
        } else {
            expect_int(case_name, "Stack.pop", stack.pop(), failure_indicator);
            expect_bool(case_name, "Stack.is_empty", stack.is_empty, true);
        }
    });
}

private void test_queue() {
    int first_input = 10;
    int second_input = 20;
    int third_input = 30;
    int reused_input = 40;
    int expected_size = 3;
    int expected_empty_size = 0;
    int failure_indicator = -1;
    string[] case_names = {
        "empty-state-and-failed-removal",
        "fifo-and-non-mutating-peek",
        "removal-and-reuse",
        "empty-after-removal"
    };
    DataStructuresBasics.Queue queue = new DataStructuresBasics.Queue();

    run_cases("Queue", case_names, (case_name) => {
        if (case_name == "empty-state-and-failed-removal") {
            expect_bool(case_name, "Queue.is_empty", queue.is_empty, true);
            expect_int(case_name, "Queue.size", queue.size, expected_empty_size);
            expect_int(case_name, "Queue.peek", queue.peek, failure_indicator);
            expect_int(case_name, "Queue.dequeue", queue.dequeue(), failure_indicator);
        } else if (case_name == "fifo-and-non-mutating-peek") {
            queue.enqueue(first_input);
            queue.enqueue(second_input);
            queue.enqueue(third_input);
            expect_int(case_name, "Queue.peek", queue.peek, first_input);
            expect_int(case_name, "Queue.size", queue.size, expected_size);
        } else if (case_name == "removal-and-reuse") {
            expect_int(case_name, "first Queue.dequeue", queue.dequeue(), first_input);
            queue.enqueue(reused_input);
            expect_int(case_name, "second Queue.dequeue", queue.dequeue(), second_input);
            expect_int(case_name, "third Queue.dequeue", queue.dequeue(), third_input);
            expect_int(case_name, "fourth Queue.dequeue", queue.dequeue(), reused_input);
            expect_bool(case_name, "Queue.is_empty", queue.is_empty, true);
            expect_int(case_name, "Queue.size", queue.size, expected_empty_size);
        } else {
            expect_int(case_name, "Queue.dequeue", queue.dequeue(), failure_indicator);
            expect_bool(case_name, "Queue.is_empty", queue.is_empty, true);
        }
    });
}

public int main(string[] args) {
    Test.init(ref args);
    Test.add_func("/data_structures_basics/node", test_node);
    Test.add_func("/data_structures_basics/linked_list", test_linked_list);
    Test.add_func("/data_structures_basics/stack", test_stack);
    Test.add_func("/data_structures_basics/queue", test_queue);

    return Test.run();
}
