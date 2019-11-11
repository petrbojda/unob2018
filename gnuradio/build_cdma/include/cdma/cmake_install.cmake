# Install script for directory: /home/petr/Projects/Bajer/gnuradio/gr-cdma/include/cdma

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/cdma" TYPE FILE FILES
    "/home/petr/Projects/Bajer/gnuradio/gr-cdma/include/cdma/api.h"
    "/home/petr/Projects/Bajer/gnuradio/gr-cdma/include/cdma/chopper.h"
    "/home/petr/Projects/Bajer/gnuradio/gr-cdma/include/cdma/vector_insert2.h"
    "/home/petr/Projects/Bajer/gnuradio/gr-cdma/include/cdma/packet_header2.h"
    "/home/petr/Projects/Bajer/gnuradio/gr-cdma/include/cdma/packet_headerparser_b2.h"
    "/home/petr/Projects/Bajer/gnuradio/gr-cdma/include/cdma/flag_gen.h"
    "/home/petr/Projects/Bajer/gnuradio/gr-cdma/include/cdma/amp_var_est.h"
    "/home/petr/Projects/Bajer/gnuradio/gr-cdma/include/cdma/switched_peak_detector_fb.h"
    "/home/petr/Projects/Bajer/gnuradio/gr-cdma/include/cdma/pac_err_cal.h"
    )
endif()

