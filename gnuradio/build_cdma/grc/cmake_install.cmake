# Install script for directory: /home/petr/Projects/Bajer/gnuradio/gr-cdma/grc

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gnuradio/grc/blocks" TYPE FILE FILES
    "/home/petr/Projects/Bajer/gnuradio/gr-cdma/grc/cdma_chopper.xml"
    "/home/petr/Projects/Bajer/gnuradio/gr-cdma/grc/cdma_vector_insert2.xml"
    "/home/petr/Projects/Bajer/gnuradio/gr-cdma/grc/cdma_message_probe.xml"
    "/home/petr/Projects/Bajer/gnuradio/gr-cdma/grc/cdma_packet_headerparser_b2.xml"
    "/home/petr/Projects/Bajer/gnuradio/gr-cdma/grc/cdma_packet_headerparser_b2_default.xml"
    "/home/petr/Projects/Bajer/gnuradio/gr-cdma/grc/cdma_flag_gen.xml"
    "/home/petr/Projects/Bajer/gnuradio/gr-cdma/grc/cdma_kronecker_filter.xml"
    "/home/petr/Projects/Bajer/gnuradio/gr-cdma/grc/cdma_freq_timing_estimator.xml"
    "/home/petr/Projects/Bajer/gnuradio/gr-cdma/grc/cdma_amp_var_est.xml"
    "/home/petr/Projects/Bajer/gnuradio/gr-cdma/grc/cdma_switched_peak_detector_fb.xml"
    "/home/petr/Projects/Bajer/gnuradio/gr-cdma/grc/cdma_pac_err_cal.xml"
    )
endif()

