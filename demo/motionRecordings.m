% (C) Copyright 2021 Marco Barilari

      
      
run(fullfile('..', 'initLePoulpe.m'));

waitForAWhile = 3;

saveCutAudio = 0;

saveCutAudio = 0;

saveCutAudio = 0;

pacedByUser = true;

  
waitForSwtich = 3;

waitAfter = 1.5;

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

soundsToPlay = { 'pink_0p85_ramp25ms.wav', ...
    'pink_0p8_ramp25ms.wav'};
 
for iDuration = 1:size(soundsToPlay, 2)
    % loadAudio
    
    [outSound, fs] = audioread(fullfile(soundPath, soundsToPlay{iDuration}));
    
    % cutAudio
    
    [soundArray] = cutSoundArray(outSound, 'pinknoise', fs, nbSpeakers, saveCutAudio);
    
    pause(waitAfter)

    for i = 1:nbCycles
        
        playMotionSound('horizontal', ...
            speakerIdxRightward, ...
            soundArray, ...
            nbRepetitions, ...
            waitForSwtich);
        
          
        playMotionSound('horizontal', ...
            speakerIdxLeftward, ...
            soundArray, ...
            nbRepetitions, ...
            waitForSwtich);
        
        pause(waitAfter)        
        
        playMotionSound('vertical', ...
            speakerIdxDownward, ...
            soundArray, ...
            nbRepetitions, ...
            waitForSwtich);
         
        pause(waitAfter)
        
        playMotionSound('vertical', ...
            speakerIdxUpward, ...
            soundArray, ...
            nbRepetitions, ...
            waitForSwtich);
        
        pause(waitAfter)
        
    end
    
end
