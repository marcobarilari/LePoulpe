%test speakers

% pause(3)

pacedByUser = false;

waitForAWhile = 0.1;

waitForSwtich = 1;

direction = 'leftward'; %'rightward' - 'leftward' / 'upward' - 'downward'

%% prepare sounds to be played
fs = 44100;
nbSpeakers = 1;

saveAsWav = 1;

duration = .5;

nbRepetition = 1;

outSound = generateNoise('pink', duration, saveAsWav, fs);

[soundArray] = cutSoundArray(outSound, 'pinknoise', fs, nbSpeakers, 0);

% soundArray{1} = audioread(fullfile('..', 'input/3s_tone11.wav'));

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
        
        speakerIdx = generateMotionSpeakerArray('upward');
        
end

pressSpaceForMeOrWait(pacedByUser, waitForAWhile)

for iSpeaker = 1:1000  %length(speakerIdx)
    
%     speakerToTest = speakerIdx(iSpeaker);

speakerToTest = 18


    playOneSpeaker(axesToTest, ...
        speakerToTest, ...
        soundArray, ...
        nbRepetition, ...
        waitForSwtich);
    
end
