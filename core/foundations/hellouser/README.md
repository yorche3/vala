# Hello, User! — Vala

Implementación de la especificación [02_Hello_User](https://yorche3.github.io/programming_languages/core/foundations/02_Hello_User/) en **Vala**, con un enfoque manual y minimalista.

Solicita un nombre mediante la entrada estándar y muestra un saludo personalizado.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`HelloUser.vala`](HelloUser.vala) | Código fuente: solicita un nombre, lo lee desde `stdin` y muestra un saludo. |

**Estructura de directorios esperada:**

```text
hellouser/
├── HelloUser.vala  # Código fuente
└── README.md       # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se creó manualmente, sin Meson, Autotools ni herramientas de scaffolding. Vala se traduce a código C y después se compila a un ejecutable nativo mediante `valac`.

**EN:** The project was created manually, without Meson, Autotools, or scaffolding tools. Vala is translated to C and then compiled into a native executable through `valac`.

El flujo del programa es:

1. Mostrar el prompt con `stdout.printf` sin salto de línea.
2. Leer una línea con `stdin.read_line()`.
3. Formatear el nombre en el saludo.
4. Escribir el saludo con salto de línea.

The program flow is:

1. Display the prompt with `stdout.printf` without a newline.
2. Read one line with `stdin.read_line()`.
3. Format the name into the greeting.
4. Write the greeting with a newline.

### Inicialización / Initialization

1. Crear la estructura de directorios:

   ```bash
   mkdir -p vala/core/foundations/hellouser
   ```

2. Escribir el archivo `HelloUser.vala` con el código fuente.

3. Compilarlo con `valac` y ejecutar el binario generado.

---

## 📄 Archivos de configuración clave / Key Configuration Files

No se requieren archivos de configuración para este ejercicio.

```vala
public class HelloUser : Object {
    static int main(string[] args) {
        stdout.printf("Enter your name: ");
        string? name = stdin.read_line();
        stdout.printf("Hello, %s!\n", name);
        return 0;
    }
}
```

| Elemento | Propósito |
|----------|-----------|
| `public class HelloUser` | Declara la clase principal del ejemplo. |
| `static int main(...)` | Define el punto de entrada del ejecutable. |
| `stdout.printf(...)` | Escribe texto formateado en la salida estándar. |
| `stdin.read_line()` | Lee una línea desde la entrada estándar. |
| `string? name` | Representa el nombre leído como una cadena nullable. |
| `%s` | Inserta el nombre en la cadena de saludo. |

> **ES:** El primer `printf` no añade un salto de línea, por lo que el prompt y la entrada aparecen en la misma línea.
> **EN:** The first `printf` does not add a newline, so the prompt and input appear on the same line.

---

## 🚀 Compilación y ejecución / Build & Run

### Requisitos / Requirements

- **Vala 0.56.16**.
- `valac`, el compilador de Vala.
- GLib/GObject, utilizado por la clase base `Object` y las APIs de entrada/salida.

Verificar la instalación:

```bash
valac --version
```

Salida verificada:

```text
Vala 0.56.16
```

### Compilar y ejecutar / Compile and run

```bash
cd vala/core/foundations/hellouser
valac HelloUser.vala -o HelloUser
printf 'Ada\n' | ./HelloUser
```

Para evitar crear el binario dentro del proyecto:

```bash
valac HelloUser.vala -o /tmp/vala-hellouser
printf 'Ada\n' | /tmp/vala-hellouser
```

### Salida esperada / Expected output

Con la entrada `Ada`, la salida verificada es:

```text
Enter your name: Hello, Ada!
```

La ejecución y compilación fueron verificadas con Vala 0.56.16 en Linux/WSL2.

The compilation and execution were verified with Vala 0.56.16 on Linux/WSL2.

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** Vala requiere un método `main` como punto de entrada del ejecutable.
- **EN:** Vala requires a `main` method as the executable entry point.
- **ES:** `stdin.read_line()` elimina el salto de línea final de la entrada.
- **EN:** `stdin.read_line()` removes the final newline from the input.
- **ES:** El primer `stdout.printf` conserva el cursor en la misma línea; el segundo añade `\n` al saludo.
- **EN:** The first `stdout.printf` keeps the cursor on the same line; the second adds `\n` to the greeting.
- **ES:** La compilación puede mostrar warnings de headers de GLib; no impidieron generar ni ejecutar el binario durante esta verificación.
- **EN:** Compilation may show warnings from GLib headers; they did not prevent the binary from being generated and executed during this verification.
- **ES:** El ejecutable generado es un artefacto de compilación y no forma parte del código fuente del ejercicio.
- **EN:** The generated executable is a build artifact and is not part of the exercise source code.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://github.com/yorche3/programming_languages)*
