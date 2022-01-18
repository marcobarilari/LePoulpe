run(fullfile('..', 'initLePoulpe.m'));

saveCutAudio = 0;

pacedByUser = true;

waitForAWhile = 1;

waitForSwtich = 3;

waitAfter = 2;

nbRepetitions = 1;

nbCycles = 2;

nbSpeakers = 31;

soundPath = fullfile(fileparts(mfilename('fullpath')), '..', ...
    ['input' filesep 'noise_motion']);

% build the speaker arrays for each direction
speakerIdxRightward = generateMotionSpeakerArray('rightward');

speakerIdxLeftward = generateMotionSpeakerArray('leftward');

speakerIdxDownward = generateMotionSpeakerArray('downward');

speakerIdxUpward = generateMotionSpeakerArray('upward');

soundsToPlay = {  'pink_0p250_ramp25ms.wav', ...
                'pink_0p1_ramp25ms.wav  '};

for iDuration = 1:size(soundsToPlay, 2)
    % loadAudio
    
    [outSound, fs] = audioread(fullfile(soundPath, soundsToPlay{iDuration}));
    
    % cutAudio
    
    [soundArray] = cutSoundArray(outSound, 'pinknoise', fs, nbSpeakers, saveCutAudio);
    
    pressSpaceForMeOrWait(pacedByUser, waitForAWhile)
    
    for i = 1:nbCycles
        
        playMotionSound('horizontal', ...
            speakerIdxRightward, ...
            soundArray, ...
            nbRepetitions, ...
            waitForSwtich);
        
        WaitSecs(waitAfter)
        
        playMotionSound('horizontal', ...
            speakerIdxLeftward, ...
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
