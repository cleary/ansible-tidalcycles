# list of samples paths
#  loaded in:
#   - supercollider startup.scd
#   - vscode/tidalcycles extension sample browser
#
#custom_sample_paths: [ "/home/user/foo/",
#                       "/home/user/bar/" ]

# modify common supercollider startup.scd defaults
# for complete list of available defaults check:
#   roles/tidal/defaults/main.yml
#   roles/tidal/templates/startup.scd.template
#
# uncomment to modify the number of supercollider outputs (hardware/DAW etc)
# note: superdirt orbit assignment is auto-calculated, ref https://tidalcycles.org/Separate_audio_outputs 
# sc_option_numOutputBusChannels: 2

# connect midi client(s) to send patterns to (hardware, software synths/plugins etc)
# see: https://tidalcycles.org/SuperDirt_MIDI_Tutorial
# In SuperCollider get the output of:
#   MIDIClient.init;
# Which will return a series Sources and Destinations in the following format:
#   MIDIEndPoint("full_name", "port_name")
# livecode_name is the name you'd like to use to refer to this midi device in your tidal code
# latency is optional, and defaults to 0
#
#custom_midi_clients:
#    - { livecode_name: midi0, full_name: Midi Through, port_name: Midi Through Port-0, latency: 0 }
#    - { livecode_name: midi1, full_name: Focusrite USB MIDI, port_name: Focusrite USB MIDI }
