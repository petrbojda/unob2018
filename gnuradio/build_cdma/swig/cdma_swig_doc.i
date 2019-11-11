
/*
 * This file was automatically generated using swig_doc.py.
 *
 * Any changes to it will be lost next time it is regenerated.
 */




%feature("docstring") gr::cdma::amp_var_est "Assumes as input a constant complex signal with complex noise s[i]=(A+j B) + (wr[i]+j wi[i]) Estimates the signal power on the real part A^2 and real noise variance sigma^2.

First convert the input stream from complex type to real type, so r[i]=A + wr[i]. 
Then split the stream into two branches: 
 1) Pass the first branch through a single-pole IIR filter (averaging), square the result, and obtain an estimate of the signal power A^2. 
 2) Square the second branch, pass the result through a single-pole IIR filter, subtract the estimated signal power and obtain an estimate of the noise power sigma^2.
 
 For the IIR filter, the parameter alpha controls the averaging length. See equation below: 
 y[i] = (1-alpha)*y[i-1] + alpha*x[i]."

%feature("docstring") gr::cdma::amp_var_est::make "Return a shared_ptr to a new instance of cdma::amp_var_est.

To avoid accidental use of raw pointers, cdma::amp_var_est's constructor is in a private implementation class. cdma::amp_var_est::make is the public interface for creating new instances.

Params: (alpha)"

%feature("docstring") gr::cdma::amp_var_est::alpha "

Params: (NONE)"

%feature("docstring") gr::cdma::amp_var_est::set_alpha "

Params: (k)"

%feature("docstring") gr::cdma::chopper "Chop the input data stream according to the flags in the input control stream.

When flag is detected in the control stream, the chopper start to chop. The chopper outputs a copy of length_out items from the input stream to the output stream per chop.
The chopper consumes length_in items from the input and control streams.
Typically the flags are periodic and length_out>=length_in. Therefore, there exist three cases.
Case 1: period <= length_in <= length_out 
For example, with length_in=4, length_out=5, period=3, the input and output streams will look like 
input:-->abcdefghijklmn...
flags:-->10010010010010... (period=3)
outputs:>abcdeghijkmn...

Case 2: length_in <= period <= length_out 
For example, with length_in=4, length_out=6, period=5, the input and output streams will look like 
input:-->abcdefghijklmn...
flags:-->100001000010000... (period=5)
outputs:>abcdeffghijkklmnop...

Case 3: length_in <=length_out <= period 
For example, with length_in=4, length_out=6, period=7, the input and output streams will look like 
input:-->abcdefghijklmnopqrst...
flags:-->100000010000001000000...(periold=7) 
outputs:>abcdefhijklmonqrst..."

%feature("docstring") gr::cdma::chopper::make "Return a shared_ptr to a new instance of cdma::chopper.

To avoid accidental use of raw pointers, cdma::chopper's constructor is in a private implementation class. cdma::chopper::make is the public interface for creating new instances.

Params: (length_out, length_in, vector_length)"

%feature("docstring") gr::cdma::flag_gen "This block either passes through the input stream (assumed to be zeros or ones) when its internal state is acq=1, or it outputs a stream of zeros with periodic ones (with given period) when its internal state is acq=0.

The purpose of this block is to be used right after the timing/frequency acquisition block. The timing/frequency acquisition block outputs a stream of 0s and 1s, with 1s indicating the begining of a cdma frame.
When the system is in acquisition mode (acq=1), the flag_gen block just passes through its input stream, which comes from the timing/frequency acquisition block.
When the system is in tracking mode (acq=0), the timing/frequency acquisition block is not supposed to produce any meaningful output flags. In this case, the flag_gen block produces periodical flags (with given period equal to the frame length) starting from the last flag produced by the timing/frequency acquisition block, in order to provide timing information for the remaining of the system.
 For example, when period is 4 the input and output streams will look like:
acq:--->111111000000000...
input:->010100000000000...
output:>010100010001000...
where the first 1 in the input and output is for example due to a false acquisition."

%feature("docstring") gr::cdma::flag_gen::make "Return a shared_ptr to a new instance of cdma::flag_gen.

To avoid accidental use of raw pointers, cdma::flag_gen's constructor is in a private implementation class. cdma::flag_gen::make is the public interface for creating new instances.

Params: (period, acq)"

%feature("docstring") gr::cdma::flag_gen::set_acq "

Params: (acq)"

%feature("docstring") gr::cdma::pac_err_cal "<+description of block+>"

%feature("docstring") gr::cdma::pac_err_cal::make "Return a shared_ptr to a new instance of cdma::pac_err_cal.

To avoid accidental use of raw pointers, cdma::pac_err_cal's constructor is in a private implementation class. cdma::pac_err_cal::make is the public interface for creating new instances.

Params: (winsize, cycsize, pkt_num_tag)"

%feature("docstring") gr::cdma::pac_err_cal::set_winsize "

Params: (k)"

%feature("docstring") gr::cdma::pac_err_cal::set_cycsize "

Params: (t)"

%feature("docstring") gr::cdma::pac_err_cal::set_pkt_num_tag "

Params: (str)"

%feature("docstring") gr::cdma::packet_header2 "Default header formatter for digital packet transmission.

For bursty/packetized digital transmission, packets are usually prepended with a packet header, containing the number of bytes etc. This class is not a block, but a tool to create these packet header.

This is a default packet header (see header_formatter()) for a description on the header format). To create other header, derive packet header creator classes from this function.

gr::digital::packet_headergenerator_bb uses header generators derived from this class to create packet headers from data streams."

%feature("docstring") gr::cdma::packet_header2::packet_header2 "

Params: (header_len, len_tag_key, num_tag_key, bits_per_byte, tcm_type, tcm_type_key)"

%feature("docstring") gr::cdma::packet_header2::~packet_header2 "

Params: (NONE)"

%feature("docstring") gr::cdma::packet_header2::set_tcm_type "

Params: (tcm_type)"

%feature("docstring") gr::cdma::packet_header2::num_tag_key "

Params: (NONE)"

%feature("docstring") gr::cdma::packet_header2::header_formatter "Encodes the header information in the given tags into bits and places them into .

Uses the following header format: Bits 0-11: The packet length (what was stored in the tag with key ) Bits 12-15: The trellis coded modulation type Bits 16-27: The header number (counts up everytime this function is called) Bit 28-35: 8-Bit CRC All other bits: Are set to zero

If the header length is smaller than 36, bits are simply left out. For this reason, they always start with the LSB.

However, it is recommended to stay above 36 Bits, in order to have a working CRC.

Params: (packet_len, out, tags)"

%feature("docstring") gr::cdma::packet_header2::header_parser "Inverse function to header_formatter().

Reads the bit stream in  and writes a corresponding tag into .

Params: (header, tags)"

%feature("docstring") gr::cdma::packet_header2::make "

Params: (header_len, len_tag_key, num_tag_key, bits_per_byte, tcm_type, tcm_tag_key)"

%feature("docstring") gr::cdma::packet_headerparser_b2 "Post header metadata as a PMT.

In a sense, this is the inverse block to packet_headergenerator_bb. The difference is, the parsed header is not output as a stream, but as a PMT dictionary, which is published to message port with the id \"header_data\".

The dictionary consists of the tags created by the header formatter object. You should be able to use the exact same formatter object as used on the Tx side in the packet_headergenerator_bb.

If only a header length is given, this block uses the default header format."

%feature("docstring") gr::cdma::packet_headerparser_b2::make "

Params: (header_formatter)"

%feature("docstring") gr::cdma::switched_peak_detector_fb "<+description of block+>"

%feature("docstring") gr::cdma::switched_peak_detector_fb::make "Return a shared_ptr to a new instance of cdma::switched_peak_detector_fb.

To avoid accidental use of raw pointers, cdma::switched_peak_detector_fb's constructor is in a private implementation class. cdma::switched_peak_detector_fb::make is the public interface for creating new instances.

Params: (threshold_factor_rise, threshold_factor_fall, look_ahead, alpha, on)"

%feature("docstring") gr::cdma::switched_peak_detector_fb::set_threshold_factor_rise "

Params: (thr)"

%feature("docstring") gr::cdma::switched_peak_detector_fb::set_threshold_factor_fall "

Params: (thr)"

%feature("docstring") gr::cdma::switched_peak_detector_fb::set_look_ahead "

Params: (look)"

%feature("docstring") gr::cdma::switched_peak_detector_fb::set_alpha "

Params: (alpha)"

%feature("docstring") gr::cdma::switched_peak_detector_fb::set_on "

Params: (on)"

%feature("docstring") gr::cdma::switched_peak_detector_fb::threshold_factor_rise "

Params: (NONE)"

%feature("docstring") gr::cdma::switched_peak_detector_fb::threshold_factor_fall "

Params: (NONE)"

%feature("docstring") gr::cdma::switched_peak_detector_fb::look_ahead "

Params: (NONE)"

%feature("docstring") gr::cdma::switched_peak_detector_fb::alpha "

Params: (NONE)"

%feature("docstring") gr::cdma::switched_peak_detector_fb::on "

Params: (NONE)"

%feature("docstring") gr::cdma::vector_insert2 "Insert a specified (complex) vector periodically in the (complex) input stream.

For example, with data=(x,y), periodicity=3, and offset=1, the input and output streams will look like 
input: abcdefghijk... 
output: axybcdxyefgxyhijxyk..."

%feature("docstring") gr::cdma::vector_insert2::make "Return a shared_ptr to a new instance of cdma::vector_insert2.

To avoid accidental use of raw pointers, cdma::vector_insert2's constructor is in a private implementation class. cdma::vector_insert2::make is the public interface for creating new instances.

Params: (data, periodicity, offset)"