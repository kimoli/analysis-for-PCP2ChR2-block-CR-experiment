function plotExtVsBlockExtData(sessions, mouseidx)

%% gather data
basedir = ['\\blinklab\data\users\okim\behavior\', sessions.mice{1,mouseidx}, '\'];

[normalExtinction.cradjamp, normalExtinction.traces, normalExtinction.session]...
    = fetchAndConcatData(basedir, sessions.unpExtBL, mouseidx, 0,...
    [], [], []);
[normalExtinction.cradjamp, normalExtinction.traces, normalExtinction.session]...
    = fetchAndConcatData(basedir, sessions.unpExt, mouseidx, 2,...
    normalExtinction.cradjamp, normalExtinction.traces, normalExtinction.session);

[blockExtinction.cradjamp, blockExtinction.traces, blockExtinction.session]...
    = fetchAndConcatData(basedir, sessions.blockExtBL, mouseidx, 0,...
    [], [], []);
[blockExtinction.cradjamp, blockExtinction.traces, blockExtinction.session]...
    = fetchAndConcatData(basedir, sessions.lasBlockCR, mouseidx, 2,...
    blockExtinction.cradjamp, blockExtinction.traces, blockExtinction.session);
[blockExtinction.cradjamp, blockExtinction.traces, blockExtinction.session]...
    = fetchAndConcatData(basedir, sessions.extTest, mouseidx, 12,...
    blockExtinction.cradjamp, blockExtinction.traces, blockExtinction.session);

%% session-wide summary
figure
subplot(4,1,1)
hold on
startHere = 1;
sessnums = unique(normalExtinction.session);
for i = 1:max(sessnums)
    thisSession = sessnums(i,1);
    theseVals = normalExtinction.cradjamp(normalExtinction.session==thisSession,1);
    if i<3
        scatter(startHere:(startHere+length(theseVals)-1), theseVals, 3, 'MarkerFaceColor', [0 0 0], 'MarkerEdgeColor', [0 0 0])
    else
        scatter(startHere:(startHere+length(theseVals)-1), theseVals, 3, 'MarkerFaceColor', [0 0 1], 'MarkerEdgeColor', [0 0 1])
    end
    startHere = startHere+length(theseVals);
    plot([startHere-0.5 startHere-0.5], [0 1], 'Color', [0 0 0], 'LineStyle', ':')
end
set(gca, 'TickDir', 'out')
xlim([0 startHere+200])
ylim([0 1])
ylabel('CR Adj Amp')
title(sessions.mice{1,mouseidx})

subplot(4,1,2)
hold on
startHere = 0;
sessnums = unique(normalExtinction.session);
for i = 1:max(sessnums)
    thisSession = sessnums(i,1);
    meanTrace = mean(normalExtinction.traces(normalExtinction.session==thisSession,:));
    if i<3
        colorrgb = [0 0 0];
    else
        colorrgb = [0 0 1];
    end
    plot(startHere:(startHere+50), meanTrace(1,40:90), 'Color', colorrgb)
    startHere = startHere+51;
    plot([startHere-0.5 startHere-0.5], [0 1], 'Color', [0 0 0], 'LineStyle', ':')
end
set(gca, 'TickDir', 'out')
xlim([0 startHere+51])
ylim([0 1])
ylabel('FEC')

subplot(4,1,3)
hold on
startHere = 1;
sessnums = unique(blockExtinction.session);
for i = 1:max(sessnums)
    thisSession = sessnums(i,1);
    theseVals = blockExtinction.cradjamp(blockExtinction.session==thisSession,1);
    if i<3
        scatter(startHere:(startHere+length(theseVals)-1), theseVals, 3, 'MarkerFaceColor', [0 0 0], 'MarkerEdgeColor', [0 0 0])
    elseif i<13
        scatter(startHere:(startHere+length(theseVals)-1), theseVals, 3, 'MarkerFaceColor', [0 0 1], 'MarkerEdgeColor', [0 0 1])
    else
        scatter(startHere:(startHere+length(theseVals)-1), theseVals, 3, 'MarkerFaceColor', [0 0 0], 'MarkerEdgeColor', [0 0 0])
    end
    startHere = startHere+length(theseVals);
    plot([startHere-0.5 startHere-0.5], [0 1], 'Color', [0 0 0], 'LineStyle', ':')
end
set(gca, 'TickDir', 'out')
xlim([0 startHere])
ylim([0 1])
ylabel('CR Adj Amp')

subplot(4,1,4)
hold on
startHere = 0;
sessnums = unique(blockExtinction.session);
for i = 1:max(sessnums)
    thisSession = sessnums(i,1);
    meanTrace = mean(blockExtinction.traces(blockExtinction.session==thisSession,:));
    if i<3
        colorrgb = [0 0 0];
    elseif i<13
        colorrgb = [0 0 1];
    else
        colorrgb = [0 0 0];
    end
    plot(startHere:(startHere+50), meanTrace(1,40:90), 'Color', colorrgb)
    startHere = startHere+51;
    plot([startHere-0.5 startHere-0.5], [0 1], 'Color', [0 0 0], 'LineStyle', ':')
end
set(gca, 'TickDir', 'out')
xlim([0 startHere])
ylim([0 1])
ylabel('FEC')

%% compare eyelid traces during the first and last blocks of normal extinction day 10 and the test day
figure
hold on
lastExtTraces = normalExtinction.traces(normalExtinction.session==12,:);
lastBaselineTraces = blockExtinction.traces(normalExtinction.session==2,:);
lastBlockExtTraces = blockExtinction.traces(blockExtinction.session==12,:);
extTestTraces = blockExtinction.traces(blockExtinction.session==13,:);
plot(0:5:(160*5), mean(lastExtTraces(1:10, 40:200)))
plot(0:5:(160*5), mean(lastBaselineTraces(1:10, 40:200)))
plot(0:5:(160*5), mean(lastBlockExtTraces(1:10, 40:200)))
plot(0:5:(160*5), mean(extTestTraces(1:10, 40:200)))
ylim([0 1])
ylabel('FEC')
xlabel('time from CS onset (ms')
try
    extTestTraces2 = blockExtinction.traces(blockExtinction.session==14,:);
    plot(0:5:(160*5), mean(extTestTraces2(1:10, 40:200)))
    plot([210 210], [0 1], 'Color', [0 0 0], 'LineStyle', ':')
    legend('final unpaired extinction session', 'final baseline session', 'final block CR session', 'post-test', 'post-test 2', 'omitted puff', 'location', 'EastOutside')
catch ME
    plot([210 210], [0 1], 'Color', [0 0 0], 'LineStyle', ':')
    legend('final unpaired extinction session', 'final baseline session', 'final block CR session', 'post-test', 'omitted puff', 'location', 'EastOutside')
end
title([sessions.mice{1,mouseidx}, ' mean traces (first 10 trials of listed sessions)'])
end