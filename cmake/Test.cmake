OPTION(ALL_TESTING "Test all modules" OFF)
OPTION(STANDARD_TESTING "Test the standard api modules" OFF)
OPTION(MONGO_TESTING "Test the mongo api modules" OFF)
OPTION(REDIS_TESTING "Test the redis api modules" OFF)

IF (ALL_TESTING OR STANDARD_TESTING OR MONGO_TESTING OR REDIS_TESTING)
    SET(CMAKE_CXX_FLAGS "-g -O0 -Wall ${CMAKE_C_FLAGS} -fprofile-arcs -ftest-coverage")
    SET(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fprofile-arcs -ftest-coverage")
    SET(CMAKE_CXX_OUTPUT_EXTENSION_REPLACE 1)

    FIND_PACKAGE(Boost COMPONENTS unit_test_framework REQUIRED)

    SET(
        REQUIRED_LIBRARIES
        ${Boost_UNIT_TEST_FRAMEWORK_LIBRARY}
        ${REQUIRED_LIBRARIES}
    )

    ENABLE_TESTING()

    INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR}/src)
    LINK_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR}/src)

    INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR}/example)
    LINK_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR}/example)
ENDIF()

IF (STANDARD_TESTING OR ALL_TESTING)
    # Config Tests
    ADD_EXECUTABLE(ConfigTest ${CMAKE_CURRENT_SOURCE_DIR}/test/Standard/Config.test.cpp)
    TARGET_LINK_LIBRARIES(ConfigTest ${REQUIRED_LIBRARIES})
    TARGET_COMPILE_DEFINITIONS(ConfigTest PRIVATE BOOST_TEST_DYN_LINK)
    ADD_TEST(TestConfig ConfigTest)

    # Server Data Tests
    ADD_EXECUTABLE(ServerDataTest ${CMAKE_CURRENT_SOURCE_DIR}/test/Standard/ServerData.test.cpp)
    TARGET_LINK_LIBRARIES(ServerDataTest ${REQUIRED_LIBRARIES})
    TARGET_COMPILE_DEFINITIONS(ServerDataTest PRIVATE BOOST_TEST_DYN_LINK)
    ADD_TEST(TestServerData ServerDataTest)
ENDIF()

IF (MONGO_TESTING OR ALL_TESTING)
    ADD_EXECUTABLE(MongoShellTest ${CMAKE_CURRENT_SOURCE_DIR}/test/Standard/Mongo.shell.test.cpp)
    TARGET_LINK_LIBRARIES(MongoShellTest ${REQUIRED_LIBRARIES})
    TARGET_COMPILE_DEFINITIONS(MongoShellTest PRIVATE BOOST_TEST_DYN_LINK)
    ADD_TEST(TestMongoShell MongoShellTest)
ENDIF()


IF (REDIS_TESTING OR ALL_TESTING)
    ADD_EXECUTABLE(RedisShellTest ${CMAKE_CURRENT_SOURCE_DIR}/test/Standard/Redis.shell.test.cpp)
    TARGET_LINK_LIBRARIES(RedisShellTest ${REQUIRED_LIBRARIES})
    TARGET_COMPILE_DEFINITIONS(RedisShellTest PRIVATE BOOST_TEST_DYN_LINK)
    ADD_TEST(TestRedisShell RedisShellTest)
ENDIF()
