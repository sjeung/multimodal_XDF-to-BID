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


Slides from presentation about LSL to BIDS conversion : https://docs.google.com/presentation/d/183mtdsQl2GG-ijWJDyYqht7YIfVvb4e2YBcvvTyJSkw/edit?usp=sharing

# Note 
Now only basic features are demonstrated for providing a "starting point" - documentation & updated to show how to deal with time synch between streams 
