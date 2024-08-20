This repository contains example scripts to demonstrate inspection and reformatting of multimodal data contained in XDF files. 
Example specifically shows how to do it for EEG & Motion data. 

# Prerequisite 
1. Matlab version 2020 or higher
2. Have FieldTrip installed : download [here](https://www.fieldtriptoolbox.org/download/) 
For JSONLab/table reading/data2bids function 

Example source data files used in the scripts are provided here on [GDrive](https://drive.google.com/drive/folders/14V6bMa0JMK6vjm1d9s5pSpx6MHWl_xrA?usp=sharing)


# Workflow 
1. Inspect stream contents to identify relevant streams and channels (in MoBIS_handson_1_xdf2bids.m)
2. Convert into pseudo-BIDS (also in MoBIS_handson_1_xdf2bids.m)
3. Validate by dragging and dropping output folder into [BIDS-validator](https://bids-standard.github.io/bids-validator/) and retouch (in MoBIDS_handsone_2_touchup.m), repeat the cycle until validator give your an OK 

# Time synchronisation
## Aligning multiple data streams 
Simultaneous recordings of different data modalities can be synchronised with each other using the acq_time column in scans.tsv, expressing the offset between recording onsets. 
## Latency channel 
If sample-by-sample time stamps are present in the data set, a latency channel containing precise timeing information can be stored together with motion or other physiological data. This is particularly useful when the timing of sampling is not regular, causing deviations from the nominal sampling rate. 
## Events 
If events are aligned with one of the data types, for example, EEG, one can apply the same principle to align the events with other, simultaneously recorded data types. For instance, if EEG stream started 1 second earlier than the motion stream, and the first event was recorded at 4 seconds after the onset of EEG stream, the timing of that event will correspond to 3 seconds after the onset of the motion stream. 

