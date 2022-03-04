run(fullfile('..', 'initLePoulpe.m'));

saveCutAudio = 0;

pacedByUser = true;

waitForAWhile = 1;

waitForSwtich = 3;

waitAfter = 2;

nbRepetitions = 1;

nbCycles = 2;

nbSpeakers = 31;

nbSpeakersOn = 6 ; %3

soundPath = fullfile(fileparts(mfilename('fullpath')), '..', ...
    ['input' filesep 'noise_motion']);


soundsToPlay = { 'pink_1p5_ramp25ms.wav', ...
                 'pink_1p2_ramp25ms.wav', ...
                 'pink_0p250_ramp25ms.wav  '};

% build the speaker arrays for each direction
speakerIdxRightward = generateMotionSpeakerArray('rightward');

speakerIdxLeftward = generateMotionSpeakerArray('leftward');

speakerIdxDownward = generateMotionSpeakerArray('downward');

speakerIdxUpward = generateMotionSpeakerArray('upward');

jumpSpeakerOn = nbSpeakersOn*2;

idxFirstSpeakerOn = 1:jumpSpeakerOn:nbSpeakers;

idxFirstSpeakerOff = idxFirstSpeakerOn + nbSpeakersOn;

idxFirstSpeakerOff = idxFirstSpeakerOff(idxFirstSpeakerOff < nbSpeakers);

speakersOff = [];

for iSpeaker = 1:length(idxFirstSpeakerOff)

    speakersOff = [ speakersOff idxFirstSpeakerOff(iSpeaker):idxFirstSpeakerOff(iSpeaker) +  (nbSpeakersOn - 1) ]; 
    
end

speakersOff = speakersOff(speakersOff < nbSpeakers);
            
for iDuration = 1:size(soundsToPlay, 2)
    % loadAudio
    
    [outSound, fs] = audioread(fullfile(soundPath, soundsToPlay{iDuration}));
    
    % cutAudio
    
    [soundArray] = cutSoundArray(outSound, 'pinknoise', fs, nbSpeakers, saveCutAudio);
    
    silence = zeros(1, size(soundArray{1}, 2));
    
    for iSpeakerOff = 1:length(speakersOff)
        
        soundArray{1, speakersOff(iSpeakerOff)} = silence;
    
    end
    
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
        
    end
    
end
