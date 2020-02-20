function [cradjampStore, tracesStore, sessnumStore] = fetchAndConcatData(...
    trials, basedir, phasesessions, mouseidx, addToSess,...
    cradjampStore, tracesStore, sessnumStore)


for b = 1:size(phasesessions,1)
    daydir = strcat(basedir, phasesessions{b,mouseidx});
    cd(daydir)
    load('trialdata.mat')
    
    csTrials = trials.c_csdur > 0;
    checkThese = trials.eyelidpos(csTrials,:);
    baseline = nan(sum(csTrials),1);
    cradjamp = nan(sum(csTrials),1);
    stable = nan(sum(csTrials),1);
    adjtraces  = nan(sum(csTrials),size(checkThese,2));
    for c = 1:sum(csTrials)
        baseline(c,1) = mean(checkThese(c,1:39));
        cradjamp(c,1) = max(checkThese(c,76:82))-baseline(c,1);
        adjtraces(c,:) = checkThese(c,:) - baseline(c,1);
        if max(checkThese(c,1:39))<0.4
            stable(c,1) = 1;
        else
            stable(c,1) = 0;
        end
    end
    
    if size(adjtraces,2)<340
        addme = nan(size(adjtraces,1), 340-size(adjtraces,2));
        adjtraces = [adjtraces, addme];
    end
    
    sessnum = ones(sum(stable),1)*(b+addToSess);
    cradjampStore = [cradjampStore; cradjamp(stable==1)];
    tracesStore = [tracesStore; adjtraces(stable==1, :)];
    sessnumStore = [sessnumStore; sessnum];
end

end