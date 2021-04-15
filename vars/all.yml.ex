# Example file only!
# Copy this file to vars/all.yml and uncomment to use

# list of samples paths
#  loaded in:
#   - supercollider startup.scd
#   - vscode/tidalcycles extension sample browser

#custom_sample_paths: [ "/home/user/foo/",
#                       "/home/user/bar/" ]

# source samples from git repositories
# Individual samples keep the audio files in the top directory of the repository
#git_sample_individuals: 
#    - { livecode_name: flbass, git_url: "https://github.com/cleary/samples-flbass.git" }
#    - { livecode_name: cbow, git_url: "https://github.com/cleary/samples-cello-bowed.git" }
#    - { livecode_name: cpluck, git_url: "https://github.com/cleary/samples-cello-plucked.git" }
#    - { livecode_name: uku, git_url: "https://github.com/thgrund/samples-ukulele.git" }
#    - { livecode_name: eride, git_url: "https://github.com/abalone1969/eRide.git" }
#    - { livecode_name: ebongos, git_url: "https://github.com/abalone1969/ebongos.git" }

# Sample sets have the audio files contained in multiple subdirs of the repository
#git_sample_sets: 
#    - https://github.com/yaxu/dirt-jv1080.git
#    - https://github.com/yaxu/dirt-impulse.git
#    - https://github.com/dktr0/estuary-samples.git
#    - https://github.com/dktr0/supercontinent.git
#    - https://github.com/dktr0/cybernetic-samples.git
#    - https://github.com/cleary/samples-hydrogen-drums

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

# install and configure various ugens, currently supported:
#  * mutable-instruments (ref https://github.com/v7b1/mi-UGens)
#sc_ugens: [ 
#            "mutable-instruments"
#          ]
