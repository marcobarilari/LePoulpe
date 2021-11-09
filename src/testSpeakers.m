%test speakers

pacedByUser = false;

waitForAWhile = 0;

waitForSwtich = 1;

axesToTest = 'horizontal'; % horizontal / vertical

direction = 'leftward'; %'rightward' - 'leftward' / 'upward' - 'downward'

%% prepare sounds to be played
fs = 44100;
nbSpeakers = 1;

saveAsWav = 1;

duration = 1;

nbRepetition = 1;

outSound = generateNoise('pink', duration, saveAsWav, fs);

[soundArray] = cutSoundArray(outSound, 'pinknoise', fs, nbSpeakers, 0);

switch direction
    
    case 'rightward'
        
        axesToTest = 'horizontal';
        
        speakerIdx = generateMotionSpeakerArray('rightward');
        
    case 'leftward'
        
        axesToTest = 'horizontal';
        
        speakerIdx = generateMotionSpeakerArray('leftward');
        
    case 'downward'
        
        axesToTest = 'vertical';
        
        speakerIdx = generateMotionSpeakerArray('downward');
        
    case 'upward'
        
        axesToTest = 'vertical';
        
        speakerIdx = generateMotionSpeakerArray('downward');
        
end

pressSpaceForMeOrWait(pacedByUser, waitForAWhile)

for iSpeaker = 1:length(speakerIdx)
    
    speakerToTest = speakerIdx(iSpeaker);
        
    playOneSpeaker(axesToTest, ...
        speakerToTest, ...
        soundArray, ...
        nbRepetition, ...
        waitForSwtich);
    
end
