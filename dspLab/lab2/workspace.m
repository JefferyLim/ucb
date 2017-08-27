%lab3 workspace
%all work to produce the images and plots for lab1 are contain in this
%workspace
close all

%Load all track names
tracks = dir('audio/*.wav');

N = 512;

for i=1:size(tracks)    
    %Read and clip audio
    [wav, fs] = audioread(strcat('audio/', tracks(i).name));
    [clippedWav] = clipAudio(wav, fs, 24);
    
    %obtain the clip size of the audio and the frame length
    clipL = size(clippedWav,1);
    nFrames = clipL/N;

    w = kaiser(N);
    %Calculating the fbanks and the mfcc
    
    [Hp] = fbanks(fs, N);
    [MFCC] = mfcc(clippedWav, N, w, Hp);
    
    %Gets rid of extra frames that are NANs
    MFCC = MFCC(:, 1:end-1);
    
    %New Overlapping Frame size
    overlapFrames = size(MFCC,2);
    
    figure(1);
    imagesc(0:24, 0:40, 10*log10(MFCC));set(gca,'ydir','normal'); title(strcat(tracks(i).name, ': MFCC')); colorbar
    xlabel('Seconds');ylabel('Filter');
      
    saveImage(tracks(i).name, '-mfcc');
    
    %Similarity Matrix
    [S] = similarity(MFCC);
    
    figure(2);
    imagesc(0:overlapFrames, 0:overlapFrames, S); title(strcat(tracks(i).name, ': Similarity'));colorbar
    xlabel('Frames');ylabel('Frames');
    
    saveImage(tracks(i).name, '-similarity');
    
    %Rhythm matrices
    [B] = rhythmB(S);
    [AR] = rhythmAR(S);
    [dAR] = dynamicRhythmAR(S);
    
    figure(3);
    subplot(3,1,1);
    plot(B);title(strcat(tracks(i).name, ': Rhythms'));
    xlabel('Lag (Frames)');ylabel('Magnitude');
    
    subplot(3,1,2);
    plot(AR);
    xlabel('Lag (Frames)');ylabel('Magnitude');
    
    subplot(3,1,3);
    imagesc((dAR));set(gca,'ydir','normal');colorbar;
    xlabel('Time');ylabel('Lag (Frames)');
    
    saveImage(tracks(i).name, '-Rhythm');
    
    %NPCP
    [NPCP] = npcp(clippedWav, fs, N, w);
    
    figure(4);
    imagesc(0:24, 1:12, 10*log10(NPCP));

    %Plot formating
    title(strcat(tracks(i).name, ': NPCP'));
    scale = {'A', 'A#', 'B', 'C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G' ,'G#'};
    colorbar;set(gca, 'Ytick', 1:12, 'YtickLabel', scale(:), 'YDir','normal');xlabel('Seconds');
    
    saveImage(tracks(i).name, '-NPCP');
    
end
