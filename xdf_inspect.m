function [streamNames, channelMetaData] = xdf_inspect(streams)
% XDF metadata should follow the specification on pages below
% 
% https://github.com/sccn/xdf/wiki/MoCap-Meta-Data
% https://github.com/sccn/xdf/wiki/EEG-Meta-Data

% max. number of channels to disply
cMax = 5; 

% inspect source data 
streamNames     = {}; 
channelMetaData = {}; 

for Si = 1:numel(streams)
    
    disp(['Stream ' num2str(Si) ' name : ' streams{Si}.info.name])
    streamNames{end+1} = streams{Si}.info.name; 
    
    if isfield(streams{Si}.info.desc, 'channels')
       
        nChan = numel(streams{Si}.info.desc.channels.channel); 
        disp([num2str(nChan) ' channels were found'])
        
        cInd = 1;
        while cInd <= nChan && cInd <= cMax 
            
            if ~isfield(streams{Si}.info.desc.channels.channel{cInd}, 'label')
                warning('Channel info is missing "label" field, manually add metadata')
                streams{Si}.info.desc.channels.channel{cInd}.label = 'n/a'; 
            end
            if ~isfield(streams{Si}.info.desc.channels.channel{cInd}, 'type')
                warning('Channel info is missing "type" field, manually add metadata')
                streams{Si}.info.desc.channels.channel{cInd}.type = 'n/a';
            end
            if ~isfield(streams{Si}.info.desc.channels.channel{cInd}, 'unit')
                warning('Channel info is missing "unit" field, manually add metadata')
                streams{Si}.info.desc.channels.channel{cInd}.unit = 'n/a';
            end
            
            disp([streams{Si}.info.desc.channels.channel{cInd}.label, ...
                ', type ' streams{Si}.info.desc.channels.channel{cInd}.type... 
                ', unit ' streams{Si}.info.desc.channels.channel{cInd}.unit])
            cInd = cInd + 1;
            if cInd > nChan || cInd > cMax
                disp('...')
            end
        end
        
        channelMetaData{end+1} = streams{Si}.info.desc.channels.channel; 
        
    else 
        disp('No channel info provided')
         channelMetaData{end+1} = []; 
    end
end

end
