% configure paths 
fieldTripPath   = 'P:\Sein_Jeung\Project_BIDS\Workshops\Workshop_2024_MoBI\Tools\fieldtrip-20240515'; 
xdfFileName     = 'P:\Sein_Jeung\Project_BIDS\Workshops\Workshop_2024_MoBI\Hands-on\data\sourcedata\1\control_body.xdf';
bidsFolder      = 'P:\Sein_Jeung\Project_BIDS\Workshops\Workshop_2024_MoBI\Hands-on\data\bidsdata';

% add fieldtrip 
addpath(fieldTripPath)
ft_defaults
[filepath,~,~] = fileparts(which('ft_defaults'));
addpath(fullfile(filepath, 'external', 'xdf'))

% 1. load and inspect xdf
%--------------------------------------------------------------------------
streams                         = load_xdf(xdfFileName);
[streamNames, channelMetaData]  = xdf_inspect(streams); 

% keep track of data modalities (find entries from output)
% indices are better found this way because stream order may differ between
% recordings 

EEGStreamName           = 'BrainVision RDA'; 
EEGStreamInd            = find(strcmp(streamNames, EEGStreamName)); 

EventStreamName         = 'ExperimentMarkerStream'; 
EventStreamInd          = find(strcmp(streamNames, EventStreamName)); 

MotionStreamName        = 'headRigid';
MotionStreamInd         = find(strcmp(streamNames, MotionStreamName)); 

% 2. convert streams to fieldtrip data structs  
%--------------------------------------------------------------------------
EEGftData           = stream_to_ft(streams{EEGStreamInd}); 
MotionftData        = stream_to_ft(streams{MotionStreamInd}); 

% 3. enter generic metadata
%--------------------------------------------------------------------------
cfg                                         = [];
cfg.bidsroot                                = bidsFolder;
cfg.sub                                     = '001';
cfg.task                                    = 'SpotRotation';
cfg.scans.acq_time                          = datetime('now');
cfg.InstitutionName                         = 'Technische Universitaet zu Berlin';
cfg.InstitutionalDepartmentName             = 'Biological Psychology and Neuroergonomics';
cfg.InstitutionAddress                      = 'Strasse des 17. Juni 135, 10623, Berlin, Germany';
cfg.TaskDescription                         = 'Participants equipped with VR HMD rotated either physically or using a joystick.';
 
% required for dataset_description.json
cfg.dataset_description.Name                = 'EEG and motion capture data set for a full-body/joystick rotation task';
cfg.dataset_description.BIDSVersion         = 'unofficial extension';

% optional for dataset_description.json
cfg.dataset_description.License             = 'CC0';
cfg.dataset_description.Authors             = {"Gramann, K.", "Hohlefeld, F.U.", "Gehrke, L.", "Klug, M"};
cfg.dataset_description.Acknowledgements    = 'n/a';
cfg.dataset_description.Funding             = {""};
cfg.dataset_description.ReferencesAndLinks  = {"Human cortical dynamics during full-body heading changes"};
cfg.dataset_description.DatasetDOI          = 'https://doi.org/10.1038/s41598-021-97749-8';

% 4. enter eeg metadata and feed to data2bids function
%--------------------------------------------------------------------------
cfg.datatype = 'eeg';
cfg.eeg.Manufacturer                = 'BrainProducts';
cfg.eeg.ManufacturersModelName      = 'n/a';
cfg.eeg.PowerLineFrequency          = 50; 
cfg.eeg.EEGReference                = 'REF'; 
cfg.eeg.SoftwareFilters             = 'n/a'; 
data2bids(cfg, EEGftData);

% 5. enter motion metadata 
%--------------------------------------------------------------------------
cfg.datatype    = 'motion'; 
cfg             = rmfield(cfg, 'eeg'); 

cfg.tracksys = 'HTCVive';

cfg.motion.TrackingSystemName          = 'HTCVive';
cfg.motion.DeviceSerialNumber          = 'n/a';
cfg.motion.SoftwareVersions            = 'n/a';
cfg.motion.Manufacturer                = 'HTC';
cfg.motion.ManufacturersModelName      = 'Vive Pro';

% specify channel details, this overrides the details in the original data structure
cfg.channels = [];
cfg.channels.name = {
  'HTCVive_posX'
  'HTCVive_posY'
  'HTCVive_posZ'
  'HTCVive_quatX' 
  'HTCVive_quatY'
  'HTCVive_quatZ'
  'HTCVive_quatW'
  'HTCVive_ori'
  };
cfg.channels.component= {
  'x'
  'y'
  'z'
  'quat_x'
  'quat_y'
  'quat_z'
  'quat_w'
  'n/a'
  };
cfg.channels.type = {
  'POS'
  'POS'
  'POS'
  'ORI'
  'ORI'
  'ORI'
  'ORI'
  'MISC'
  };
cfg.channels.units = {
  'm'
  'm'
  'm'
  'n/a'
  'n/a'
  'n/a'
  'n/a'
  'n/a'
  };

cfg.channels.tracked_point = {
  'head'
  'head'
  'head'
  'head'
  'head'
  'head'
  'head'
  'head'
  };

% rename the channels in the data to match with channels.tsv
MotionftData.label = cfg.channels.name;
data2bids(cfg, MotionftData);
