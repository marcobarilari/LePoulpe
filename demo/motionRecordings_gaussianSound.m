run(fullfile('..', 'initLePoulpe.m'));

opt.saveCutAudio = 0;

opt.pacedByUser = true;

opt.waitForAWhile = 1;

opt.waitForSwtich = 3;

opt.waitAfter = 2;

opt.nbRepetitions = 1;

opt.nbCycles = 2;

opt.nbSpeakers = 31;

opt.nbSpeakersOn = 6 ; %3

opt.soundPath = fullfile(fileparts(mfilename('fullpath')), '..', ...
    ['input' filesep 'noise_motion']);


opt.soundsToPlay = { 'pink_1p2.wav'};

% build the speaker arrays for each direction
opt.speakerIdxRightward = generateMotionSpeakerArray('rightward');

opt.speakerIdxLeftward = generateMotionSpeakerArray('leftward');

opt.jumpSpeakerOn = opt.nbSpeakersOn*2;

opt.idxFirstSpeakerOn = 1:opt.jumpSpeakerOn:opt.nbSpeakers;

opt.idxFirstSpeakerOff = opt.idxFirstSpeakerOn + opt.nbSpeakersOn;

opt.idxFirstSpeakerOff = opt.idxFirstSpeakerOff(opt.idxFirstSpeakerOff < opt.nbSpeakers);

speakersOff = [];

for iSpeaker = 1:length(opt.idxFirstSpeakerOff)

    speakersOff = [ speakersOff opt.idxFirstSpeakerOff(iSpeaker):opt.idxFirstSpeakerOff(iSpeaker) +  (opt.nbSpeakersOn - 1) ]; 
    
end

speakersOff = speakersOff(speakersOff < opt.nbSpeakers);
            
for iDuration = 1:size(opt.soundsToPlay, 2)
    % loadAudio
    
    [outSound, fs] = audioread(fullfile(opt.soundPath, opt.soundsToPlay{iDuration}));
    
    % cutAudio
    
    [soundArray] = cutSoundArray(outSound, 'pinknoise', fs, opt.nbSpeakers, opt.saveCutAudio);
    
    silence = zeros(1, size(soundArray{1}, 2));
    
    for iSpeakerOff = 1:length(speakersOff)
        
        soundArray{1, speakersOff(iSpeakerOff)} = silence;
    
    end
    
    pressSpaceForMeOrWait(opt.pacedByUser, opt.waitForAWhile)
    
    for i = 1:opt.nbCycles
        
        playMotionSound_moreSpeakers('horizontal', ...
            opt.speakerIdxRightward, ...
            soundArray, ...
            opt.nbRepetitions, ...
            opt.waitForSwtich);
        
        WaitSecs(opt.waitAfter)
        
        playMotionSound_moreSpeakers('horizontal', ...
            opt.speakerIdxLeftward, ...
            soundArray, ...
            opt.nbRepetitions, ...
            opt.waitForSwtich);
        
        WaitSecs(opt.waitAfter)
        
    end
    
end
