# Hello, World! — Vala

Implementación de la especificación [01_Hello_World](https://yorche3.github.io/programming_languages/core/foundations/01_Hello_World/) en **Vala**, con un enfoque manual y minimalista.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`helloworld.vala`](helloworld.vala) | Código fuente: define `HelloWorld` e imprime un saludo en la salida estándar. |

**Estructura de directorios esperada:**

```text
helloworld/
├── helloworld.vala  # Código fuente
└── README.md        # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se creó manualmente, sin Meson, Autotools ni herramientas de scaffolding. Vala se traduce a código C y después se compila a un ejecutable nativo mediante `valac`.

**EN:** The project was created manually, without Meson, Autotools, or scaffolding tools. Vala is translated to C and then compiled into a native executable through `valac`.

### Inicialización / Initialization

1. Crear la estructura de directorios:

   ```bash
   mkdir -p vala/core/foundations/helloworld
   ```

2. Escribir el archivo `helloworld.vala` con el código fuente.

3. Compilarlo con `valac` y ejecutar el binario generado.

---

## 📄 Archivos de configuración clave / Key Configuration Files

No se requieren archivos de configuración para este ejercicio.

```vala
public class HelloWorld : Object {
    static int main(string[] args) {
        print("Hello, World! from Vala!\n");
        return 0;
    }
}
```

| Elemento | Propósito |
|----------|-----------|
| `public class HelloWorld` | Declara la clase principal del ejemplo. |
| `: Object` | Usa la clase base de GObject disponible en Vala. |
| `static int main(...)` | Define el punto de entrada del ejecutable. |
| `print(...)` | Escribe el saludo en la salida estándar. |
| `return 0` | Indica que la ejecución terminó correctamente. |

---

## 🚀 Compilación y ejecución / Build & Run

### Requisitos / Requirements

- **Vala 0.56.16**.
- `valac`, el compilador de Vala.
- GLib/GObject, utilizado por la clase base `Object`.

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
cd vala/core/foundations/helloworld
valac helloworld.vala -o helloworld
./helloworld
```

Para evitar crear el binario dentro del proyecto:

```bash
valac helloworld.vala -o /tmp/vala-helloworld
/tmp/vala-helloworld
```

### Salida esperada / Expected output

```text
Hello, World! from Vala!
```

La salida fue verificada compilando con `valac` y ejecutando el binario nativo generado en Linux/WSL2.

The output was verified by compiling with `valac` and running the generated native binary on Linux/WSL2.

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** Vala requiere un método `main` como punto de entrada del ejecutable.
- **EN:** Vala requires a `main` method as the executable entry point.
- **ES:** `valac` genera código C intermedio y lo compila usando el toolchain nativo disponible.
- **EN:** `valac` generates intermediate C code and compiles it using the available native toolchain.
- **ES:** La compilación puede mostrar warnings provenientes de headers de GLib; en esta verificación no impidieron generar ni ejecutar el binario.
- **EN:** Compilation may show warnings originating from GLib headers; in this verification they did not prevent the binary from being generated and executed.
- **ES:** El ejecutable generado es un artefacto de compilación y no forma parte del código fuente del ejercicio.
- **EN:** The generated executable is a build artifact and is not part of the exercise source code.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://github.com/yorche3/programming_languages)*
