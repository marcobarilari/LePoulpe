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

% select the speakers for the specific spatial frequency

spatialFreq = {'low', 'high'};

lowSpatialFreqIdxLeftward = 1:5:31;

speakerIdxLeftwardLowSpatialFreq = speakerIdxLeftward(lowSpatialFreqIdxLeftward);

lowSpatialFreqIdxRightward = 31:-5:1;

speakerIdxRightwardLowSpatialFreq = speakerIdxLeftward(lowSpatialFreqIdxRightward);

highSpatialFreqIdxLeftward = 1:3:31;

speakerIdxLeftwardHighSpatialFreq = speakerIdxLeftward(highSpatialFreqIdxLeftward);

highSpatialFreqIdxRightward = 31:-3:1;

speakerIdxRightwardHighSpatialFreq = speakerIdxLeftward(highSpatialFreqIdxRightward);

% list the sounds be played
soundsToPlay = { 'pink_0p8_ramp25ms.wav', ...
                };

for iSpatialFreq = 1:length(spatialFreq)

    switch spatialFreq{iSpatialFreq}
        
        case 'low' 
            
            speakerIdxRightward = speakerIdxRightwardLowSpatialFreq;
            
            speakerIdxLeftward = speakerIdxLeftwardLowSpatialFreq;
            
        case 'high'
            
            speakerIdxRightward = speakerIdxRightwardHighSpatialFreq;
            
            speakerIdxLeftward = speakerIdxLeftwardHighSpatialFreq;
            
    end
    

    nbSpeakers = length(speakerIdxRightward);

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

        playMotionSound('vertical', ...
            speakerIdxDownward, ...
            soundArray, ...
            nbRepetitions, ...
            waitForSwtich);

        WaitSecs(waitAfter)

        playMotionSound('vertical', ...
            speakerIdxUpward, ...
            soundArray, ...
            nbRepetitions, ...
            waitForSwtich);

        WaitSecs(waitAfter)

    end

end

end