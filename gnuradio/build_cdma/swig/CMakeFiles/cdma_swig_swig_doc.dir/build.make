# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.5

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/petr/Projects/Bajer/gnuradio/gr-cdma

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/petr/Projects/Bajer/gnuradio/build_cdma

# Utility rule file for cdma_swig_swig_doc.

# Include the progress variables for this target.
include swig/CMakeFiles/cdma_swig_swig_doc.dir/progress.make

swig/CMakeFiles/cdma_swig_swig_doc: swig/cdma_swig_doc.i


swig/cdma_swig_doc.i: swig/cdma_swig_doc_swig_docs/xml/index.xml
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/petr/Projects/Bajer/gnuradio/build_cdma/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Generating python docstrings for cdma_swig_doc"
	cd /home/petr/Projects/Bajer/gnuradio/gr-cdma/docs/doxygen && /usr/bin/python2 -B /home/petr/Projects/Bajer/gnuradio/gr-cdma/docs/doxygen/swig_doc.py /home/petr/Projects/Bajer/gnuradio/build_cdma/swig/cdma_swig_doc_swig_docs/xml /home/petr/Projects/Bajer/gnuradio/build_cdma/swig/cdma_swig_doc.i

swig/cdma_swig_doc_swig_docs/xml/index.xml: swig/_cdma_swig_doc_tag
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/petr/Projects/Bajer/gnuradio/build_cdma/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Generating doxygen xml for cdma_swig_doc docs"
	cd /home/petr/Projects/Bajer/gnuradio/build_cdma/swig && ./_cdma_swig_doc_tag
	cd /home/petr/Projects/Bajer/gnuradio/build_cdma/swig && /usr/bin/doxygen /home/petr/Projects/Bajer/gnuradio/build_cdma/swig/cdma_swig_doc_swig_docs/Doxyfile

cdma_swig_swig_doc: swig/CMakeFiles/cdma_swig_swig_doc
cdma_swig_swig_doc: swig/cdma_swig_doc.i
cdma_swig_swig_doc: swig/cdma_swig_doc_swig_docs/xml/index.xml
cdma_swig_swig_doc: swig/CMakeFiles/cdma_swig_swig_doc.dir/build.make

.PHONY : cdma_swig_swig_doc

# Rule to build all files generated by this target.
swig/CMakeFiles/cdma_swig_swig_doc.dir/build: cdma_swig_swig_doc

.PHONY : swig/CMakeFiles/cdma_swig_swig_doc.dir/build

swig/CMakeFiles/cdma_swig_swig_doc.dir/clean:
	cd /home/petr/Projects/Bajer/gnuradio/build_cdma/swig && $(CMAKE_COMMAND) -P CMakeFiles/cdma_swig_swig_doc.dir/cmake_clean.cmake
.PHONY : swig/CMakeFiles/cdma_swig_swig_doc.dir/clean

swig/CMakeFiles/cdma_swig_swig_doc.dir/depend:
	cd /home/petr/Projects/Bajer/gnuradio/build_cdma && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/petr/Projects/Bajer/gnuradio/gr-cdma /home/petr/Projects/Bajer/gnuradio/gr-cdma/swig /home/petr/Projects/Bajer/gnuradio/build_cdma /home/petr/Projects/Bajer/gnuradio/build_cdma/swig /home/petr/Projects/Bajer/gnuradio/build_cdma/swig/CMakeFiles/cdma_swig_swig_doc.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : swig/CMakeFiles/cdma_swig_swig_doc.dir/depend

