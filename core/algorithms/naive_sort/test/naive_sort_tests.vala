// Casos de prueba de la especificación 05_Naive_Sort.md
//
// Caso nulo omitido: en Vala `int[]` no admite `null` (el compilador avisa
// "Cannot pass null to non-null parameter type"; haría falta la anotación
// `int[]?`, que se formaliza en una fase posterior), así que una entrada nula no
// es representable y no hay indicador de fallo que comprobar. Se conservan los 7
// casos de la especificación.
//
// Aislamiento: los arrays de Vala se pasan por referencia y los tres algoritmos
// ordenan in-place, así que el helper crea los fixtures como arrays locales en
// cada llamada: ningún caso reutiliza un array ya ordenado.

delegate int[] SortFunc(int[] arr);

bool same_values(int[] actual, int[] expected) {
    if (actual.length != expected.length) {
        return false;
    }

    for (int i = 0; i < actual.length; i++) {
        if (actual[i] != expected[i]) {
            return false;
        }
    }

    return true;
}

// Helper compartido por caso: ejecuta la función y reporta con el mensaje del
// contrato cuando el resultado no coincide.
void check_case(string algorithm, SortFunc sort, string description, int[] input, int[] expected) {
    int[] actual = sort(input);

    if (!same_values(actual, expected)) {
        Test.message(@"$algorithm should sort $description");
        assert_not_reached();
    }
}

// Helper compartido: recibe el nombre del algoritmo y la función a probar, y
// ejecuta todos los casos con el mensaje descriptivo del contrato.
void assert_sorts_all_cases(string algorithm, SortFunc sort) {
    int[] standard_input = { 5, 2, 9, 1, 5, 6 };
    int[] standard_output = { 1, 2, 5, 5, 6, 9 };

    int[] sorted_input = { 1, 2, 3, 4, 5 };
    int[] sorted_output = { 1, 2, 3, 4, 5 };

    int[] reverse_input = { 5, 4, 3, 2, 1 };
    int[] reverse_output = { 1, 2, 3, 4, 5 };

    int[] identical_input = { 7, 7, 7, 7 };
    int[] identical_output = { 7, 7, 7, 7 };

    int[] negative_input = { 3, -1, 4, -5, 0 };
    int[] negative_output = { -5, -1, 0, 3, 4 };

    int[] single_input = { 42 };
    int[] single_output = { 42 };

    int[] empty_input = {};
    int[] empty_output = {};

    check_case(algorithm, sort, "an unsorted array", standard_input, standard_output);
    check_case(algorithm, sort, "an already sorted array", sorted_input, sorted_output);
    check_case(algorithm, sort, "a reverse ordered array", reverse_input, reverse_output);
    check_case(algorithm, sort, "an array of identical elements", identical_input, identical_output);
    check_case(algorithm, sort, "an array with negative numbers", negative_input, negative_output);
    check_case(algorithm, sort, "a single element array", single_input, single_output);
    check_case(algorithm, sort, "an empty array", empty_input, empty_output);
}

void test_selection_sort() {
    assert_sorts_all_cases("selection_sort", NaiveSort.selection_sort);
}

void test_bubble_sort() {
    assert_sorts_all_cases("bubble_sort", NaiveSort.bubble_sort);
}

void test_insertion_sort() {
    assert_sorts_all_cases("insertion_sort", NaiveSort.insertion_sort);
}

int main(string[] args) {
    Test.init(ref args);
    Test.add_func("/naive_sort/selection_sort", test_selection_sort);
    Test.add_func("/naive_sort/bubble_sort", test_bubble_sort);
    Test.add_func("/naive_sort/insertion_sort", test_insertion_sort);

    return Test.run();
}
