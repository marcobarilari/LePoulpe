% (C) Copyright 2021 Marco Barilari

run(fullfile('..', 'initLePoulpe.m'));

saveCutAudio = 0;

pacedByUser = true;

waitForAWhile = 1;

waitForSwtich = 0;

waitAfter = 2;

nbRepetitions = 1;

nbCycles = 2;

soundPath = fullfile(fileparts(mfilename('fullpath')), '..', ...
    ['input' filesep 'noise_motion']);

% list the sounds be played
soundsToPlay = { 'pink_1p5_ramp25ms.wav', ...
                };  

% spatial frequency as as "play every x speakers"
spatialFreq = [3];

% build the speaker arrays for each direction
speakerIdxRightward = generateMotionSpeakerArray('rightward');

speakerIdxLeftward = generateMotionSpeakerArray('leftward');

speakerIdxDownward = generateMotionSpeakerArray('downward');

speakerIdxUpward = generateMotionSpeakerArray('upward');

for iSpatialFreq = 1:length(spatialFreq)

    % select the speakers for the specific spatial frequency
    selcetSpeakers = 1: spatialFreq(iSpatialFreq):31;

    selectedSPeakersLeftward = speakerIdxLeftward(selcetSpeakers);

    selectedSPeakersRightward = speakerIdxRightward(selcetSpeakers);
    
    nbSpeakers = length(selectedSPeakersLeftward);

for iDuration = 1:size(soundsToPlay, 2)
    
    % loadAudio
    [outSound, fs] = audioread(fullfile(soundPath, soundsToPlay{iDuration}));

    % cutAudio
    [soundArray] = cutSoundArray(outSound, 'pinknoise', fs, nbSpeakers, saveCutAudio);

    pressSpaceForMeOrWait(pacedByUser, waitForAWhile)

    for i = 1:nbCycles

        playMotionSound('horizontal', ...
            selectedSPeakersRightward, ...
            soundArray, ...
            nbRepetitions, ...
            waitForSwtich);

        WaitSecs(waitAfter)

        playMotionSound('horizontal', ...
            selectedSPeakersLeftward, ...
            soundArray, ...
            nbRepetitions, ...
            waitForSwtich);

        WaitSecs(waitAfter)

%         playMotionSound('vertical', ...
%             speakerIdxDownward, ...
%             soundArray, ...
%             nbRepetitions, ...
%             waitForSwtich);
% 
%         WaitSecs(waitAfter)
% 
%         playMotionSound('vertical', ...
%             speakerIdxUpward, ...
%             soundArray, ...
%             nbRepetitions, ...
%             waitForSwtich);
% 
%         WaitSecs(waitAfter)

    end

end

end