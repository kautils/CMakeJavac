macro(CMakeJavac)
    
    set(${PROJECT_NAME}_m_evacu ${m})
    set(m ${PROJECT_NAME}.CMakeJavac)
    list(APPEND ${m}_unsetter 
            ${m}_DEBUG_VERBOSE ${m}_VERBOSE ${m}_BOOTCLASSPATH ${m}_JAVAC 
            ${m}_SOURCE ${m}_TARGET ${m}_DESTINATION ${m}_CLASSPATH 
            ${m}_SOURCEPATH ${m}_FILES ${m}_WORKING_DIRECTORY )
    
    cmake_parse_arguments(${m}
        "VERBOSE;DEBUG_VERBOSE" "BOOTCLASSPATH;JAVAC;SOURCE;TARGET;DESTINATION;WORKING_DIRECTORY" "CLASSPATH;SOURCEPATH;FILES" 
        ${ARGV}
    )
    
    if(NOT DEFINED ${m}_WORKING_DIRECTORY)
        set(${m}_WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR})
    endif()
    
    if(${${m}_DEBUG_VERBOSE})
        include(CMakePrintHelpers)
        foreach(__var ${${m}_unsetter})
            cmake_print_variables(${__var})
        endforeach()
    endif()
    
    list(APPEND ${m}_unsetter ${m}_echo ${m}_sourcepath"${${m}_delm}" ${m}_sourcepath ${m}_res ${m}_out ${m}_err)
    if(${${m}_VERBOSE})
        set(${m}_echo COMMAND_ECHO)
    endif()
    
    if(${CMAKE_HOST_SYSTEM_NAME} STREQUAL "Windows")
        set(${m}_delm ";")
    else()
        set(${m}_delm ":")
    endif()
    
    list(JOIN ${m}_CLASSPATH "${${m}_delm}" ${m}_CLASSPATH)
    list(JOIN ${m}_SOURCEPATH "${${m}_delm}" ${m}_SOURCEPATH)
    
    execute_process(
        COMMAND "${${m}_JAVAC}"
        -source ${${m}_SOURCE} 
        -target ${${m}_TARGET}
        -bootclasspath "${${m}_BOOTCLASSPATH}"    
        -cp "${${m}_CLASSPATH}"
        -sourcepath "${${m}_SOURCEPATH}"
        ${${m}_FILES}
        -d ${${m}_DESTINATION}
        ${${m}_echo}
        RESULT_VARIABLE ${m}_res
        OUTPUT_VARIABLE ${m}_out
        ERROR_VARIABLE ${m}_err
        WORKING_DIRECTORY ${${m}_WORKING_DIRECTORY}
    )
    
    if(NOT ${${m}_res} EQUAL 0)
        message("[result] ${${m}_res}")
        message("[output] ${${m}_out}")
        message("[error] ${${m}_err}")
        message(FATAL_ERROR "fail to compile")
    endif()
    
    
    foreach(__v ${${m}_unsetter})
        unset(${__v})
    endforeach()
    unset(${m}_unsetter)
    set(m ${${PROJECT_NAME}_m_evacu})
    
endmacro()
