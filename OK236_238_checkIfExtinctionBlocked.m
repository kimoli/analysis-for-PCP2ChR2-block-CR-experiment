%% establish record of what sessions are what
% 236 is col 1, 238 is col 2
sessions.mice = {'OK236', 'OK238'};
sessions.extTest{1,1} = '200219';
sessions.extTest{1,2} = '200219';

temp = {'200209'; '200210'; '200211'; '200212'; ...
    '200213'; '200214'; '200215'; '200216'; '200217'; '200218'};
sessions.lasBlockCR = populateCell(temp,{},1);

temp = {'200209'; '200210'; '200211'; '200212'; ...
    '200213'; '200214'; '200215'; '200216'; '200217'; '200218'};
sessions.lasBlockCR = populateCell(temp,sessions.lasBlockCR,2);

sessions.blockExtBL = populateCell({'200207'; '200208'},{},1);
sessions.blockExtBL = populateCell({'200207'; '200208'},sessions.blockExtBL,2);

temp = {'200123'; '200124'; '200125'; '200126'; '200127';...
    '200128'; '200129'; '200130'; '200131'; '200201'};
sessions.unpExt = populateCell(temp,{},1);

temp = {'200122'; '200123'; '200124'; '200125'; '200126';...
    '200127'; '200128'; '200129'; '200130'; '200131'};
sessions.unpExt = populateCell(temp,sessions.unpExt,2);

sessions.unpExtBL = populateCell({'200120'; '200122'},{},1); % need to check if backup failed for 200121
sessions.unpExtBL = populateCell({'200120'; '200120'},sessions.unpExtBL,2);

%% plot data for each mouse alone
% plot CR amplitude and traces across sessions for extinction & extinction
% plus laser
plotExtVsBlockExtData(sessions, trials, 1)
plotExtVsBlockExtData(sessions, trials, 2)


