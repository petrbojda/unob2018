import configparser
import argparse
import logging
import logging.config
import numpy as np


def setup_cnf_file_parser(cnf_file):
    # Reads the configuration file
    config = configparser.ConfigParser()
    config.read(cnf_file)  # "../setup.cnf"

    # Read a path to a folder with python modules
    try:
        path_home = config.get('paths', 'home_dir')
    except configparser.NoOptionError as err:
        print("The path to a home folder of the project is not defined.", err)
        path_home = ".."
    except configparser.NoSectionError as err:
        print("The section which defines paths to folders missing.", err)
        path_home = ".."

    # Read a path to an analysis folder
    try:
        path_analysis = config.get('paths', 'analysis_dir')
    except configparser.NoOptionError as err:
        print("The path to a folder containing the project's data not defined.", err)
        path_analysis = "analysis"
    except configparser.NoSectionError as err:
        print("The section which defines paths to folders missing.", err)
        path_analysis = "analysis"

    # Read a path to a folder with data
    try:
        path_data = config.get('paths', 'data_dir')
    except configparser.NoOptionError as err:
        print("The path to a folder containing the project's data not defined.", err)
        path_data = "data"
    except configparser.NoSectionError as err:
        print("The section which defines paths to folders missing.", err)
        path_data = "data"

    # Read a path to a folder with config files
    try:
        path_cnf = config.get('paths', 'config_dir')
    except configparser.NoOptionError as err:
        print("The path to a folder containing the project's configuration files not defined.", err)
        path_cnf = "cfg"
    except configparser.NoSectionError as err:
        print("The section which defines paths to folders missing.", err)
        path_cnf = "cfg"

    # Read a path to a folder with data
    try:
        path_log = config.get('paths', 'logger_dir')
    except configparser.NoOptionError as err:
        print("The path to a folder containing the project's log files not defined.", err)
        path_log = "log"
    except configparser.NoSectionError as err:
        print("The section which defines paths to folders missing.", err)
        path_log = "log"

    # Read a name of the csv file where a sequence of the ssrg states is stored
    try:
        filename_state = config.get('filenames', 'ssrg_state_output_filename')
    except configparser.NoOptionError as err:
        print("The filename of a coder status csv output not defined.", err)
        filename_state = "coder_state_output.csv"
    except configparser.NoSectionError as err:
        print("The section which defines filenames missing.", err)
        filename_state = "coder_state_output.csv"
    # Read a name of the csv file where the coder output is stored
    try:
        filename_code = config.get('filenames', 'coder_output_filename')
    except configparser.NoOptionError as err:
        print("The filename of a coder outputting sequence in a csv format is not defined.", err)
        filename_code = "coder_sequence_output.csv"
    except configparser.NoSectionError as err:
        print("The section which defines filenames missing.", err)
        filename_code = "coder_sequence_output.csv"
    # Read a name of the cnf file to configure coder and analysis
    try:
        filename_cnf = config.get('filenames', 'config_filename')
    except configparser.NoOptionError as err:
        print("The filename of cnf file to configure coder and analysis not defined.", err)
        filename_cnf = "analysis.cnf"
    except configparser.NoSectionError as err:
        print("The section which defines filenames missing.", err)
        filename_cnf = "analysis.cnf"
    # Read a name of the cnf file to setup basic paths to files
    try:
        filename_setup = config.get('filenames', 'setup_filename')
    except configparser.NoOptionError as err:
        print("The filename of cnf file to setup basic paths not defined.", err)
        filename_setup = "setup.cnf"
    except configparser.NoSectionError as err:
        print("The section which defines filenames missing.", err)
        filename_setup = "setup.cnf"
    # Read a name of the cnf file to configure a plotting
    try:
        filename_plt_cnf = config.get('filenames', 'plotting_filename')
    except configparser.NoOptionError as err:
        print("The filename of cnf file to configure a plotting not defined.", err)
        filename_plt_cnf = "plotting.cnf"
    except configparser.NoSectionError as err:
        print("The section which defines filenames missing.", err)
        filename_plt_cnf = "plotting.cnf"

    setup_data = {"data_path": path_home + '/' + path_analysis + '/' + path_data,
                  "data_state": path_home + '/' + path_analysis + '/' + path_data + '/' + filename_state,
                  "data_code": path_home + '/' + path_analysis + '/' + path_data + '/' + filename_code,
                  "setup":path_home + '/' + path_analysis + '/' + path_cnf + '/' + filename_setup,
                  "cnf": path_home + '/' + path_analysis + '/' + path_cnf + '/' + filename_cnf,
                  "plt": path_home + '/' + path_analysis + '/' + path_cnf + '/' + filename_plt_cnf}
    return setup_data


def parse_CMDLine():
    # Parses a set of input arguments coming from a command line
    parser = argparse.ArgumentParser(
        description='''
                            SSRG based pseudorandom sequence
                            generator and its analysis.''')
    #      Read command line arguments to get a scenario
    parser.add_argument("-s", "--setup_file", help='''Define a path and filename to 
                                                      initial setup cnf file.''')
    argv = parser.parse_args()

    if argv.setup_file:
        setup_file = argv.setup_file
    else:
        setup_file = "setup.cnf"

    return setup_file


def logger_setup(cnf_logger_file):
    logging.config.fileConfig(cnf_logger_file)
    logger = logging.getLogger(__name__)
    logger.info("Logger implemented for analysis")

def analysis_cnf_file_parser(cnf_file):
    #TODO: add configurations for two coders and different king of coders (Kasami, etc)

    logger = logging.getLogger(__name__)
    logger.debug("Parsing of the file %s started.", cnf_file)

    # Reads the configuration file
    config = configparser.ConfigParser()
    config.read(cnf_file)  # "../analysis.cnf"
    logger.debug("sections in a cnf file: %s ", config.sections())

    # configure logging options
    try:
        analysis_setup = {"chip_rate": float(config.get('baseband', 'chip_rate'))}
    except configparser.NoOptionError as err:
        print("The path to a log config file is not defined in a main config file; ", err)
        analysis_setup = {"chip_rate": 0.0}
    except configparser.NoSectionError as err:
        print("The section which defines a path to a log config file missing in a main config file; ", err)
        analysis_setup = {"chip_rate": 0.0}

    oversampling_factor = float(config.get('baseband', 'oversampling_factor'))
    n_o_periods = int(config.get('coder', 'number_of_periods'))
    ssrg_init = np.matrix(np.fromstring(config.get('coder', 'ssrg_init'), dtype=int, sep=','))
    poly_degree = ssrg_init.size
    ssrg_fb = np.matrix(np.fromstring(config.get('coder', 'ssrg_fb'), dtype=int, sep=','))

    tau = float(config.get('signaling', 'time_accelerating_factor'))
    td = float(config.get('signaling', 'time_offset'))


    code_period = 2**poly_degree - 1
    n_o_samples = n_o_periods * code_period * oversampling_factor

    analysis_setup.update({
                      "oversampling_factor": oversampling_factor,
                      "poly_degree": poly_degree,
                      "ssrg_init": ssrg_init,
                      "ssrg_fb": ssrg_fb,
                      "n_o_periods": n_o_periods,
                      "code_period":code_period,
                      "n_o_samples":n_o_samples,
                      "time_accelerating_factor": tau,
                      "time_offset": td})

    return analysis_setup


def plotting_cnf_file_parser(cnf_file):
    # Reads the configuration file
    config = configparser.ConfigParser()
    config.read(cnf_file)  # "../plotting.cnf"

    plotting_switch = config.get('plotting', 'plotting_switch').lower()
    save_plots = config.get('plotting', 'save_plots').lower()
    show_plots = config.get('plotting', 'show_plots').lower()
    plot_saving_format = config.get('plotting', 'plot_saving_format').lower()

    if plotting_switch == 'on':
        plotting_switch_b = True
    else:
        plotting_switch_b = False

    if save_plots == 'on':
        save_plots_b = True
    else:
        save_plots_b = False

    if show_plots == 'on':
        show_plots_b = True
    else:
        show_plots_b = False

    plotting_setup = {"plotting": plotting_switch_b,
                      "save_plots": save_plots_b,
                      "show_plots": show_plots_b,
                      "plot_saving_format": plot_saving_format}
    return plotting_setup

def cnf_file_read(cnf_file):
    # Read the configuration file
    config = configparser.ConfigParser()
    config.read(cnf_file)  # "./setup.cnf"

    # Get a path to a folder with data
    try:
        conf_data = {"radar_datafile": config.get('Datasets', 'radar_01')}
    except configparser.NoOptionError as err:
        print("The path to radar data file is not defined in a main config file; ", err)
        conf_data.update({"radar_datafile": 0})
    except configparser.NoSectionError as err:
        print("The section which defines path to the radar data file missing in a main config file; ", err)
        conf_data.update({"radar_datafile": 0})

    try:
        conf_data.update({"dgps_datafile": config.get('Datasets', 'dgps_01')})
    except configparser.NoOptionError as err:
        print("The path to DGPS data file is not defined in a main config file; ", err)
        conf_data.update({"dgps_datafile": 0})
    except configparser.NoSectionError as err:
        print("The section which defines path to the DGPS data file missing in a main config file; ", err)
        conf_data.update({"dgps_datafile": 0})

    # Get list of parameters in a radar detection point
    try:
        conf_data.update({"radar_detection_attributes": config.get('RADAR_detections', 'attributes')})
    except configparser.NoOptionError as err:
        print("The attributes of the radar detections are not defined in a main config file; ", err)
        conf_data.update({"radar_detection_attributes": 0})
    except configparser.NoSectionError as err:
        print("The section which defines attributes of the radar detections missing in a main config file; ", err)
        conf_data.update({"radar_detection_attributes": 0})

    # Get list of parameters in a dgps reference point
    try:
        conf_data.update({"DGPS_reference_attributes": config.get('DGPS_references', 'attributes')})
    except configparser.NoOptionError as err:
        print("The attributes of the DGPS references are not defined in a main config file; ", err)
        conf_data.update({"DGPS_reference_attributes": 0})
    except configparser.NoSectionError as err:
        print("The section which defines attributes of the DGPS references missing in a main config file; ", err)
        conf_data.update({"DGPS_reference_attributes": 0})

    # configure logging options
    try:
        conf_data.update({"log_config_filename": config.get('LOG_file', 'cfg_filename')})
    except configparser.NoOptionError as err:
        print("The path to a log config file is not defined in a main config file; ", err)
        conf_data.update({"log_config_filename": 0})
    except configparser.NoSectionError as err:
        print("The section which defines a path to a log config file missing in a main config file; ", err)
        conf_data.update({"log_config_filename": 0})

        # Get a format of a csv file
    try:
        conf_data.update({"radar_csv_header": config.get('CSV_Headers', 'detections_XY')})
    except configparser.NoOptionError as err:
        print("The format of the radar CSV file is not defined in a main config file; ", err)
        conf_data.update({"radar_csv_header": 0})
    except configparser.NoSectionError as err:
        print("The section which would describe radar CSV file missing in a main config file; ", err)
        conf_data.update({"radar_csv_header": 0})

    try:
        conf_data.update({"dgps_csv_header": config.get('CSV_Headers', 'references_XY')})
    except configparser.NoOptionError as err:
        print("The format of the DGPS CSV file is not defined in a main config file; ", err)
        conf_data.update({"dgps_csv_header": 0})
    except configparser.NoSectionError as err:
        print("The section which would describe DGPS CSV file missing in a main config file; ", err)
        conf_data.update({"dgps_csv_header": 0})

    print(conf_data)
    return conf_data
