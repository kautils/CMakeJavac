### CMakeJavac
* wrapper of javac. compile *.java
  
### note
* JAVAC : path to javac
* SOURCE : -source arg
* TARGET : -target arg
* BOOTCLASSPATH -bootclasspath arg (android.jar)
* CLASSPATH : list for -classpath args  
* SOURCEPATH list for -sourcepath args   
* FILES : list of *.java    
* DESTINATION : destination for *.class
* WORKING_DIRECTORY : current path of execution. default value is CMAKE_CURRENT_LIST_DIR

```cmake
include(CMakeJavac.cmake)

file(GLOB_RECURSE __javas java/*.java)
file(GLOB_RECURSE __gen gen/*.java)
CMakeJavac( 
    JAVAC "${path_to_javac}"
    SOURCE 1.7
    TARGET 1.7
    BOOTCLASSPATH android.jar
    CLASSPATH libs/*
    SOURCEPATH java gen
    FILES ${__javas} ${__gen}    
    DESTINATION obj
    WORKING_DIRECTORY "${CMAKE_CURRENT_LIST_DIR}"
)
```


