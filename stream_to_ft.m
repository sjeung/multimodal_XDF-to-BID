function ftData = stream_to_ft(xdfStream)

% construct header
if ~isfield(xdfStream.info, 'effective_srate')
    hdr.Fs                  = str2double(xdfStream.info.sample_count)/(str2double(xdfStream.info.last_timestamp) - str2double(xdfStream.info.first_timestamp)); 
else
    hdr.Fs                  = xdfStream.info.effective_srate;
end

hdr.nFs                 = str2double(xdfStream.info.nominal_srate);
hdr.nSamplesPre         = 0;
hdr.nSamples            = length(xdfStream.time_stamps);
hdr.nTrials             = 1;
hdr.FirstTimeStamp      = xdfStream.time_stamps(1);
hdr.TimeStampPerSample  = (xdfStream.time_stamps(end)-xdfStream.time_stamps(1)) / (length(xdfStream.time_stamps) - 1);
if isfield(xdfStream.info.desc, 'channels')
    hdr.nChans    = numel(xdfStream.info.desc.channels.channel);
else
    hdr.nChans    = str2double(xdfStream.info.channel_count);
end

hdr.label       = cell(hdr.nChans, 1);
hdr.chantype    = cell(hdr.nChans, 1);
hdr.chanunit    = cell(hdr.nChans, 1);

prefix = xdfStream.info.name;
for j=1:hdr.nChans
    if isfield(xdfStream.info.desc, 'channels')
        hdr.label{j} = [prefix '_' xdfStream.info.desc.channels.channel{j}.label];
        
        try
            hdr.chantype{j} = xdfStream.info.desc.channels.channel{j}.type;
        catch
            disp([hdr.label{j} ' missing type'])
        end
        
        try
            hdr.chanunit{j} = xdfStream.info.desc.channels.channel{j}.unit;
        catch
            disp([hdr.label{j} ' missing unit'])
        end
    else
        % the stream does not contain continuously sampled data
        hdr.label{j} = num2str(j);
        hdr.chantype{j} = 'unknown';
        hdr.chanunit{j} = 'unknown';
    end
end

% keep the original header details
hdr.orig = xdfStream.info;

ftData.trial    = {xdfStream.time_series};
ftData.time     = {xdfStream.time_stamps};
ftData.hdr = hdr;
ftData.label = hdr.label;
end