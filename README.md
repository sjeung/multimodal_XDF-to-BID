This repository contains example scripts to demonstrate inspection and reformatting of multimodal data contained in XDF files. 

Prerequisite 
1. Matlab version 2020 or higher
2. Have FieldTrip installed : download here https://www.fieldtriptoolbox.org/download/
For JSONLab/table reading/data2bids function 

Example source data files used in the scripts are provided here : https://drive.google.com/drive/folders/14V6bMa0JMK6vjm1d9s5pSpx6MHWl_xrA?usp=sharing


The proposed workflow 
1. Inspect stream contents to identify relevant streams and channels (in MoBIS_handson_1_xdf2bids.m)
2. Convert into pseudo-BIDS (also in MoBIS_handson_1_xdf2bids.m)
3. Validate (https://bids-standard.github.io/bids-validator/) and retouch (in MoBIDS_handsone_2_touchup.m)


Slides from presentation about LSL to BIDS conversion : https://docs.google.com/presentation/d/183mtdsQl2GG-ijWJDyYqht7YIfVvb4e2YBcvvTyJSkw/edit?usp=sharing
