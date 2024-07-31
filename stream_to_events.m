
function outEvents = stream_to_events(inStreams, dataTimes)

outEvents = [];

for Si = 1:numel(inStreams)
    if iscell(inStreams{Si}.time_series)
        eventsInStream              = cell2struct(inStreams{Si}.time_series, 'value')';
        
        % remove linebreaks
        for i_event = find(contains(inStreams{Si}.time_series,char(10)))
            eventsInStream(i_event).value = strrep(eventsInStream(i_event).value,char(10),' ');
        end
        
        % remove tabs
        for i_event = find(contains(inStreams{Si}.time_series,char(9)))
            eventsInStream(i_event).value = strrep(eventsInStream(i_event).value,char(9),' ');
        end
        
        % remove other kinds of linebreaks
        for i_event = find(contains(inStreams{Si}.time_series,char(13)))
            eventsInStream(i_event).value = strrep(eventsInStream(i_event).value,char(13),' ');
        end
        
        [eventsInStream.type]       = deal(inStreams{Si}.info.type);
        times                       = num2cell(inStreams{Si}.time_stamps);
        [eventsInStream.timestamp]  = times{:};
        samples                     = cellfun(@(x) find(dataTimes >= x, 1,'first'), times, 'UniformOutput', false);
        [eventsInStream.sample]     = samples{:};
        [eventsInStream.offset]     = deal([]);
        [eventsInStream.duration]   = deal([]);
        outEvents = [outEvents eventsInStream];
    end
end

% sort events by sample
[~,I] = sort([outEvents.timestamp]);
outEvents   = outEvents(I);

% re-order fields to match ft events output
outEvents   = orderfields(outEvents, [2,1,3,4,5,6]);

end