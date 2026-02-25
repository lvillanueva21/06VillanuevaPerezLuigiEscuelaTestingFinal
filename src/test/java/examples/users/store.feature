@regresion
Feature: Automatizar el backend de Pet Store - STORE

  Background:
    * url apiPetStore
    * def jsonCrearOrden = read('classpath:examples/jsonData/crearOrden.json')

  @TEST-1 @happypath @store
  Scenario: Verificar el inventario de mascotas - OK
    Given path 'store/inventory'
    When method get
    Then status 200
    And print response


  @TEST-2 @happypath @store @crearOrden
  Scenario: Verificar la creación de una orden en Pet Store - OK
    Given path 'store/order'
    And request jsonCrearOrden
    When method post
    Then status 200
    And match response.id == jsonCrearOrden.id
    And match response.petId == jsonCrearOrden.petId
    And match response.quantity == jsonCrearOrden.quantity
    And match response.status == jsonCrearOrden.status
    And match response.complete == jsonCrearOrden.complete
    * def orderId = response.id
    And print response


  @TEST-3 @happypath @store
  Scenario: Consultar la orden creada por ID - OK
    * def data = call read('classpath:examples/users/store.feature@crearOrden')
    Given path 'store/order/' + data.orderId
    When method get
    Then status 200
    And match response.id == data.orderId
    And print response


  @TEST-4 @unhappypath @store
  Scenario: Consultar una orden inexistente - ERROR 404
    Given path 'store/order/' + '999999'
    When method get
    Then status 404
    And print response


  @TEST-5 @happypath @store
  Scenario: Eliminar la orden creada por ID - OK
    * def data = call read('classpath:examples/users/store.feature@crearOrden')
    * def orderId = data.orderId

    Given path 'store/order/' + orderId
    When method delete
    Then assert responseStatus == 200 || responseStatus == 204
    And print response

    Given path 'store/order/' + orderId
    When method get
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
