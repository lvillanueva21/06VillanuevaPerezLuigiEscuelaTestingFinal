# Proyecto de Pruebas Automatizadas con Karate usando Petstore

Este proyecto contiene pruebas automatizadas para la API pública **Petstore Swagger** usando **Karate y Maven**. Incluye casos **HappyPath** y **UnhappyPath** para los módulos **STORE** y **USER**.

**Autor:** Luigi Villanueva Perez

---

## Prerrequisitos
- **Java 17**
- **Apache Maven**
- Variables recomendadas:
  - `JAVA_HOME` (JDK 17)
  - `M2_HOME` (Maven)

---

## Configuración
- `karate-config.js` define `apiPetStore` (base URL).
- Los datos y bodies se leen desde archivos **JSON** con `read()`.
- Runner único para 2 feature: `UsersRunner.java` (ejecuta `store` y `users`).

---

## Ejecución de pruebas

### Ejecutar todos los test
mvn clean test -Dtest=UsersRunner -Dkarate.options="--tags @regresion"

### Ejecutar solo STORE o solo USER
mvn clean test -Dtest=UsersRunner -Dkarate.options="--tags @store"  
mvn clean test -Dtest=UsersRunner -Dkarate.options="--tags @user"

### Ejecutar solo HappyPath o UnhappyPath
mvn clean test -Dtest=UsersRunner -Dkarate.options="--tags @happypath"  
mvn clean test -Dtest=UsersRunner -Dkarate.options="--tags @unhappypath"

### Ejecutar un test específico
mvn clean test -Dtest=UsersRunner -Dkarate.options="--tags @TEST-5"

---

## Casos automatizados

### STORE (`store.feature`)
- **TEST-1:** `GET /store/inventory` → valida 200 e imprime inventario por estado.
- **TEST-2:** `POST /store/order` → crea orden con JSON, valida 200 y campos con `match`.
- **TEST-3:** `GET /store/order/{id}` → consulta orden creada (usa `call read(@crearOrden)`), valida 200.
- **TEST-4 (Unhappy):** `GET /store/order/999999` → valida 404 (orden no encontrada).
- **TEST-5:** `DELETE /store/order/{id}` → elimina orden creada y confirma con `GET` que devuelve 404.

### USER (`users.feature`)
- **TEST-6:** `POST /user/createWithList` → crea lista de usuarios desde JSON, valida 200.
- **TEST-7:** `GET /user/{username}` → consulta usuario creado (usa `call read(@createWithList)`), valida 200.
- **TEST-8:** `PUT /user/{username}` → actualiza usuario y confirma con `GET`, valida 200.
- **TEST-9:** `DELETE /user/{username}` → elimina usuario y confirma con `GET` que devuelve 404.
- **TEST-10:** `GET /user/login` → Petstore demo responde 200 incluso con datos inválidos (referencia).
- **TEST-11:** `GET /user/logout` → valida 200.
- **TEST-12:** `POST /user/createWithArray` → crea lista desde array JSON, valida 200.
- **TEST-13:** `POST /user` → crea un usuario desde JSON, valida 200.
- **TEST-14 (Unhappy):** `GET /user/{username}` inexistente → valida 404.
- **TEST-15 (Unhappy):** `DELETE /user/{username}` inexistente → valida 404.

---

## Notas
- Petstore es una API pública: los datos consultados varían, es mejor hacer POST de datos propios para hacer pruebas GET o DELETE y así evitar fallos.
- Algunas consultas get siempre devuelven 200 indpendiente del dato que se envíe para la consulta, esto es propio de repositorios publicos.
- Datos JSON: Se utilizan para mantener la privacidad de los test, se recomienda utilizar datos ficticios.