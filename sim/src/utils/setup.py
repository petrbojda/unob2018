import configparser
import argparse
import logging
import logging.config
import numpy as np

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


def setup_cnf_file_parser(cnf_file):
    # Reads the configuration file
    config = configparser.ConfigParser()
    config.read(cnf_file)  # "../setup.cnf"

# Folder settings
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

# Filenames settings
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
    # Read a name of the cnf file to configure analysis
    try:
        filename_analysis_cnf = config.get('filenames', 'analysis_config_filename')
    except configparser.NoOptionError as err:
        print("The filename of cnf file to configure coder and analysis not defined.", err)
        filename_analysis_cnf = "analysis.cnf"
    except configparser.NoSectionError as err:
        print("The section which defines filenames missing.", err)
        filename_analysis_cnf = "analysis.cnf"
    # Read a name of the cnf file to configure coder
    try:
        filename_coder_cnf = config.get('filenames', 'coder_config_filename')
    except configparser.NoOptionError as err:
        print("The filename of cnf file to configure coder  not defined.", err)
        filename_coder_cnf = "coder.cnf"
    except configparser.NoSectionError as err:
        print("The section which defines filenames missing.", err)
        filename_coder_cnf = "coder.cnf"
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
                  "analysis_cnf": path_home + '/' + path_analysis + '/' + path_cnf + '/' + filename_analysis_cnf,
                  "coder_cnf": path_home + '/' + path_analysis + '/' + path_cnf + '/' + filename_coder_cnf,
                  "plt": path_home + '/' + path_analysis + '/' + path_cnf + '/' + filename_plt_cnf}
    return setup_data


def analysis_cnf_file_parser(cnf_file):
    #TODO: add configurations for two coders and different king of coders (Kasami, etc)

    logger = logging.getLogger(__name__)
    logger.debug("Parsing of the file %s started.", cnf_file)

    # Reads the configuration file
    config = configparser.ConfigParser()
    config.read(cnf_file)  # "../analysis.cnf"
    analysis_config_sections = config.sections()
    logger.debug("sections in a cnf file: %s ", analysis_config_sections)

    logger.debug("configuring a baseband section", analysis_config_sections)
    if "baseband" in analysis_config_sections:
        logger.debug("baseband section exists")
        try:
            analysis_setup = {"chip_rate": float(config.get('baseband', 'chip_rate'))}
        except configparser.NoOptionError as err:
            analysis_setup = {"chip_rate": 1e3}
            logger.warning("A chip rate not specified in the baseband section, default value is set: %s %s",
                           analysis_setup["chiprate"], err)

        try:
            analysis_setup.update({"oversampling_factor": float(config.get('baseband', 'oversampling_factor'))})
        except configparser.NoOptionError as err:
            analysis_setup.update({"oversampling_factor": 16.0})
            logger.warning("An oversampling factor not specified in the baseband section, default value is set: %s %s",
                           analysis_setup["chiprate"], err)
    else:
        analysis_setup = {"chip_rate": 1e3,
                          "oversampling_factor": 16.0}
        logger.warning("A baseband section not defined in the config file %s, ",  cnf_file)
        logger.warning("default values are set: chip rate = %s oversampling factor = %s",
                      analysis_setup["chiprate"], analysis_setup["oversampling_factor"])

    logger.debug("configuring a signaling section", analysis_config_sections)
    if "signaling" in analysis_config_sections:
        logger.debug("signaling section exists")
        try:
            analysis_setup = {"time_accelerating_factor": float(config.get('signaling', 'time_accelerating_factor'))}
        except configparser.NoOptionError as err:
            analysis_setup = {"time_accelerating_factor": 1.0}
            logger.warning("A time accelerating factor not specified in the signaling section, "
                           "default value is set: %s %s",
                           analysis_setup["time_accelerating_factor"], err)
        try:
            analysis_setup.update({"time_offset": float(config.get('signaling', 'time_offset'))})
        except configparser.NoOptionError as err:
            analysis_setup.update({"time_offset": 0.0})
            logger.warning("A time_offset not specified in the signaling section, default value is set: %s %s",
                           analysis_setup["time_offset"], err)
        try:
            analysis_setup.update({"pulse_shape": config.get('signaling', 'pulse_shape')})
        except configparser.NoOptionError as err:
            analysis_setup.update({"pulse_shape": "rect"})
            logger.warning("A pulse_shape not specified in the signaling section, default value is set: %s %s",
                           analysis_setup["pulse_shape"], err)
    else:
        analysis_setup = {"time_accelerating_factor": 1.0,
                          "time_offset": 0.0,
                          "pulse_shape": "rect"}
        logger.warning("A signaling section not defined in the config file %s, ", cnf_file)
        logger.warning("default values are set: time_accelerating_factor = %s time_offset = %s pulse_shape = %s",
                       analysis_setup["time_accelerating_factor"], analysis_setup["time_offset"],
                       analysis_setup["pulse_shape"])

    logger.debug("configuring a type-of-analysis section", analysis_config_sections)
    if "type" in analysis_config_sections:
        logger.debug("A type-of-analysis section exists in a %s file.", cnf_file)
        try:
            auto_correlation_switch = config.get('type', 'auto_correlation').lower()
        except configparser.NoOptionError as err:
            auto_correlation_switch = 'off'
            logger.warning("An auto-correlation-option is not specified in the signaling section")
            logger.warning("Auto-correlation analysis is switched off. %s ", err)
        try:
            cross_correlation_switch = config.get('type', 'cross_correlation').lower()
        except configparser.NoOptionError as err:
            cross_correlation_switch = 'off'
            logger.warning("A cross-correlation-option is not specified in the signaling section")
            logger.warning("Cross-correlation analysis is switched off. %s ", err)
        try:
            spectral_analysis_switch = config.get('type', 'spectral_analysis').lower()
        except configparser.NoOptionError as err:
            spectral_analysis_switch = 'off'
            logger.warning("A spectral-analysis-option is not specified in the signaling section")
            logger.warning("Spectral-analysis analysis is switched off. %s ", err)

        if auto_correlation_switch == 'on':
            auto_correlation_switch_b = True
        else:
            auto_correlation_switch_b = False

        if cross_correlation_switch == 'on':
            cross_correlation_switch_b = True
        else:
            cross_correlation_switch_b = False

        if spectral_analysis_switch == 'on':
            spectral_analysis_switch_b = True
        else:
            spectral_analysis_switch_b = False
    else:
        logger.warning("A type-of-analysis section is not defined in the config file %s, ", cnf_file)
        logger.warning("All analyses are switched off.")
        auto_correlation_switch_b = False
        cross_correlation_switch_b = False
        spectral_analysis_switch_b = False

    analysis_setup.update({"auto_correlation_switch": auto_correlation_switch_b,
                           "cross_correlation_switch": cross_correlation_switch_b,
                           "spectral_analysis_switch": spectral_analysis_switch_b})
    return analysis_setup


def coder_cnf_file_parser(cnf_file):
    # TODO: add configurations for two coders and different king of coders (Kasami, etc)

    logger = logging.getLogger(__name__)
    logger.debug("Parsing of the file %s started.", cnf_file)

    # Reads the configuration file
    config = configparser.ConfigParser()
    config.read(cnf_file)  # "../coder.cnf"
    coder_config_sections = config.sections()
    logger.debug("sections in a cnf file: %s ", coder_config_sections)
    if len(coder_config_sections)>1:
        logger.warning("more than one type of the coder is specified in a file %s", cnf_file)

    if "ssrg" in coder_config_sections:

        n_o_periods = int(config.get('coder', 'number_of_periods'))
        ssrg_init = np.matrix(np.fromstring(config.get('coder', 'ssrg_init'), dtype=int, sep=','))
        poly_degree = ssrg_init.size
        ssrg_fb = np.matrix(np.fromstring(config.get('coder', 'ssrg_fb'), dtype=int, sep=','))
        logger.debug("Setting the SSRG coder parameters.")

        tau = float(config.get('signaling', 'time_accelerating_factor'))
        td = float(config.get('signaling', 'time_offset'))


        code_period = 2**poly_degree - 1
    # TODO: Rewrite the number of samples to be generated - now each baseband and coder settings are separate
    # n_o_samples = n_o_periods * code_period * analysis_setup["oversampling_factor"]
    # SOLUTION: n_o_samples will not be computed in a parser but inside of the main analysis function

        coder_setup = {   "type": "ssrg",
                          "poly_degree": poly_degree,
                          "ssrg_init": ssrg_init,
                          "ssrg_fb": ssrg_fb,
                          "n_o_periods": n_o_periods,
                          "code_period":code_period,
                          "time_accelerating_factor": tau,
                          "time_offset": td}
    else:
        coder_setup = {"type": "not_selected"}

    return coder_setup


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

