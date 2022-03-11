% (C) Copyright 2017 Stephanie Cattoir
% (C) Copyright 2021 CPP LePoulpe developers

function playMotionSound_moreSpeakers(opt, axis, speakerIdx, soundArray, nbRepetition, waitForSwtich)

  % This script play a provided sound (cut in chunks one per each speaker) in subsequent speakers
  % to create motion a motionn perception inn both the horizontal and vertical axes
  %
  % NativeInstrument to Matlab arm/speaker correspondance:
  %
  %  Horizontal arm (left to right)
  %  - NI: 'PXI1Slot2' ao0-14  ; Matlab: 1:15 left arm (left to center)
  %  - NI: 'PXI1Slot2' ao15-30 ; Matlab: 31:16 right arm (center to right)
  %
  %  Vertical arm (up to down)
  %  - NI: 'PXI1Slot3' ao0-14  ; Matlab: 1:14 upper arm (up to center)
  %  - NI: 'PXI1Slot3' ao30-15 ; Matlab: 31:16 lower arm (center to down)

  if nargin < 4

    nbRepetition = 1;

  end

  if length(speakerIdx) ~= size(soundArray, 2)

    error('The nb of sound chunks ar not equal to the nb of speakers selected')

  end

  % set sound intensity
  amp = 1;

  % set how many speakers are supposed to be played
  nbSpeakers = size(soundArray, 2);

  % set sample rate
  sampleRate = 44100;

  % sec
  gap_init = 0;
  gap_init = gap_init * sampleRate;

  switch axis

    % name: NI analog card slot
    % value: make the switch between arms (0 = horizontal ; 1 = vertical)

    case 'horizontal'

    name = 'PXI1Slot2';
    value = 0;

    case 'vertical'

    name = 'PXI1Slot3';
    value = 1;

  end

  for iRepetition = 1:nbRepetition

    % -------------------------------------- HELP NEEDED HERE --------------------------------------

    %% init the NI analog card

    AOLR = analogoutput('nidaq', name);
    out_AO = daqhwinfo(AOLR);
    addchannel(AOLR, 0:30);

    dio = digitalio('nidaq', 'PXI1Slot3');
    addline (dio, 0:7, 'out');
    putvalue(dio.Line(1), value);

    % AnalogLeftRight
    out_ranges = get(AOLR.Channel, 'OutputRange'); %%% this seems to be unused %%%
    setverify(AOLR.Channel, 'OutputRange', [-5 5]);
    setverify(AOLR.Channel, 'UnitsRange', [-5 5]);
    set(AOLR, 'TriggerType', 'Manual');

    AOLR.SampleRate = 44100; %%% this could be a repetition of `set(AOLR, 'SampleRate', 44100);` %%%
    set(AOLR, 'SampleRate', 44100);

    % ----------------------------------------------------------------------------------------------
    WaitSecs(waitForSwtich);

    %% prepare the sound to be loaded in the NI analog card

    % set the sound idx to be played in sequence
    soundIdx = [1:nbSpeakers];

    % build a corresponding matrix for speaker idx and sound idx:
    % - first raw for the speaker
    % - second raw for the sounds/audio
    speakerSoundCouple = [speakerIdx; soundIdx];

    % take the length (in sample rate) of the first chunkns as reference (probably not ideal)
    soundChunkLength = length(soundArray{speakerSoundCouple(2, 1)});

    % pre-allocate space to the matrix to be feeded to the NI analog card
    data = zeros(soundChunkLength, 31);

    endPoint = 0;
    
    % make wav matrix with gaps and sounds and designated speakers
    for iSpeaker = 1:length(speakerIdx)

      % build the final matrix to play at once `data(time, speakerIdx)`
      startPoint = endPoint + 1;

      endPoint = startPoint + length(soundArray{soundIdx(iSpeaker)}) - 1;
      
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      
      segmentArray = soundArray(iSpeaker:(iSpeaker + opt.nbSpeakersOn - 1));
      
      bellLength = size(segmentArray{1}, 2) * size(segmentArray,2);
      
      gaussianRamp = makeGaussianRamp(bellLength);
      
      gaussianRamp = gaussianRamp(1 : length(soundArray{soundIdx(iSpeaker)}) * size(segmentArray, 2));
      
      [rampArray] = cutSoundArray(gaussianRamp, 'gauss', 44100, opt.nbSpeakersOn, 0);
               
      segmentRamped = cell2mat(segmentArray).*gaussianRamp;
      
      segmentRampedArray = cutSoundArray(segmentRamped, 'segmentRamped', 44100, opt.nbSpeakersOn, 0);

      
%       figure(1)
%       plot(segmentArrayRamped)
%       ylim([-.8 .8])
%       
%       for iSeg = 1:size(segmentArray, 2)
%           
%           subplot(1, 6, iSeg);
%           
%          
%           plot(segmentRampedArray{iSeg})
%           ylim([-.8 .8])
%           
%       end

      
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      
      for iSegmentSpeaker = 1:size(segmentArray, 2) 

        data(startPoint:endPoint, speakerIdx(iSpeaker + iSegmentSpeaker - 1)) = amp * segmentRampedArray{soundIdx(iSegmentSpeaker)};   % *2 looks like amplifier here

      end
      
    end

    % GRAPH of the speaker order
    % x: spkeare idx;
    % y: time in descending order
    % figure;
    % imagesc(data)

    dur = size(data, 1) / 44100; % in sec

    %% feed the matrix sound into the NI analog card and play it
    
    % queue the NI analog card job
    putdata(AOLR, data);

    % start AO, issue a manual trigger, and wait for the device object to stop running
    start(AOLR);

    trigger(AOLR);

    wait(AOLR, dur + 1);

    % clear all the variables to make space
    delete(dio);
    clear dio;

    delete(AOLR);
    clear AO;

  end

end
