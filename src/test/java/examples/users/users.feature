@regresion
Feature: Automatizar el backend de Pet Store - USER

  Background:
    * url apiPetStore
    * def jsonCrearUsuariosLista = read('classpath:examples/jsonData/crearUsuariosLista.json')
    * def jsonActualizarUsuario = read('classpath:examples/jsonData/actualizarUsuario.json')
    * def jsonLoginUsuario = read('classpath:examples/jsonData/loginUsuario.json')
    * def jsonCrearUsuariosArray = read('classpath:examples/jsonData/crearUsuariosArray.json')
    * def jsonCrearUsuario = read('classpath:examples/jsonData/crearUsuario.json')


  @TEST-6 @happypath @user @createWithList
  Scenario: Crear lista de usuarios con createWithList - OK
    Given path 'user/createWithList'
    And request jsonCrearUsuariosLista
    When method post
    Then status 200
    And print response
    * def username = jsonCrearUsuariosLista[0].username


  @TEST-7 @happypath @user
  Scenario: Consultar usuario por username - OK
    * def data = call read('classpath:examples/users/users.feature@createWithList')
    Given path 'user/' + data.username
    When method get
    Then status 200
    And match response.username == data.username
    And print response


  @TEST-8 @happypath @user
  Scenario: Actualizar usuario por username - OK
    * def data = call read('classpath:examples/users/users.feature@createWithList')

    Given path 'user/' + data.username
    And request jsonActualizarUsuario
    When method put
    Then status 200
    And print response

    Given path 'user/' + data.username
    When method get
    Then status 200
    And match response.username == data.username
    And print response


  @TEST-9 @happypath @user
  Scenario: Eliminar usuario por username - OK
    * def data = call read('classpath:examples/users/users.feature@createWithList')

    Given path 'user/' + data.username
    When method delete
    Then status 200
    And print response

    Given path 'user/' + data.username
    When method get
    Then status 404
    And print response


  @TEST-10 @happypath @user
  Scenario: Login de usuario - OK
    Given path 'user/login'
    And param username = jsonLoginUsuario.username
    And param password = jsonLoginUsuario.password
    When method get
    Then status 200
    And print response


  @TEST-11 @happypath @user
  Scenario: Logout de usuario - OK
    Given path 'user/logout'
    When method get
    Then status 200
    And print response


  @TEST-12 @happypath @user @createWithArray
  Scenario: Crear usuarios con createWithArray - OK
    Given path 'user/createWithArray'
    And request jsonCrearUsuariosArray
    When method post
    Then status 200
    And print response


  @TEST-13 @happypath @user @crearUsuario
  Scenario: Crear un usuario - OK
    Given path 'user'
    And request jsonCrearUsuario
    When method post
    Then status 200
    And print response
    * def username = jsonCrearUsuario.username


  @TEST-14 @unhappypath @user
  Scenario: Consultar usuario inexistente - ERROR 404
    Given path 'user/' + 'usuario_que_no_esta_en_petstore'
    When method get
    Then status 404
    And print response


  @TEST-15 @unhappypath @user
  Scenario: Eliminar usuario inexistente - ERROR 404
    Given path 'user/' + 'usuario_que_no_esta_en_petstore'
    When method delete
    Then status 404
    And print response


  #Ejecutar todos los test de STORE y USER

  #mvn clean test -Dtest=UsersRunner -Dkarate.options="--tags @regresion"

  #Ejecutar solo STORE o solo USER

  #mvn clean test -Dtest=UsersRunner -Dkarate.options="--tags @store"
  #mvn clean test -Dtest=UsersRunner -Dkarate.options="--tags @user"

  #Ejecutar solo HappyPath o UnhappyPath

  #mvn clean test -Dtest=UsersRunner -Dkarate.options="--tags @happypath"
  #mvn clean test -Dtest=UsersRunner -Dkarate.options="--tags @unhappypath"

  #Ejecutar un test especifico

  #mvn clean test -Dtest=UsersRunner -Dkarate.options="--tags @TEST-5"

