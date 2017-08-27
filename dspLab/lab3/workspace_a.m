%lab 3
%This workspace is necessary for loading alll the data for easier analysis
%and reuse. This needs to be run before workspace_b

close all;
clear;

%Adding the path of data into the current directory
addpath(genpath('audio/'));

%Load all tracks
classical = dir('audio/classical/*.wav');
electronic = dir('audio/electronic/*.wav');
jazz = dir('audio/jazz/*.wav');
punk = dir('audio/punk/*.wav');
rock = dir('audio/rock/*.wav');
world = dir('audio/world/*.wav');

%Put each music genre in its own row
music = [classical, electronic, jazz, punk, rock, world];
music_labels = {'classical';'electronic'; 'jazz'; 'punk'; 'rock'; 'world'};

%Define frame size
frameL = 512;
N = 512;

%Song Length
songL = 240;

%Status report
statusbar = 1;
totalbar = size(music,1) * size(music,2);

for i=1:size(music,2)
    for j = 1:size(music,1)
        
    fprintf('Percent done: %3.2f%%\n', statusbar/totalbar * 100); %Status Bar
    statusbar = statusbar + 1;
    
    %obtain the song and clip the song 
    [wav, fs] = audioread(music(j, i).name);
    if length(wav) < songL
            clipLength = floor(length(wav)/fs);
        else
            clipLength = songL;
    end;
    
    clippedWav = clipAudio(wav,fs, clipLength);
    
    w = kaiser(N);
    %Calculating the fbanks and the mfcc
    
    [Hp] = fbanks(fs, N);
    [MFCC] = mfcc(clippedWav, N, w, Hp);
    [NPCP] = npcp(clippedWav, fs, frameL, w);
    
    %Gets rid of extra frames that are NANs
    MFCC = MFCC(:, 1:end-1);
    
     %Remapping mfcc to different notes
    t = zeros(1,36);
    t(1)   = 1; t(7:8)   = 5; t(15:18)= 9;
    t(2)   = 2; t(9:10) = 6; t(19:23) = 10;
    t(3:4) = 3; t(11:12) = 7; t(24:29) = 11;
    t(5:6) = 4; t(13:14) = 8; t(30:36) = 12;

    mel = zeros(12, length(MFCC));
    for k=1:12,
        mel(k,:) = sum(MFCC(t==k,:),1);
    end
    MFCC = mel;
    
    %Write mfcc data
    fid = fopen(char(strcat('results/mfcc/', strcat(strcat(music_labels(i), num2str(j)), '.dat'))), 'wt');
    for k = 1:size(MFCC,1)
        fprintf(fid, '%d ', MFCC(k,:));
        fprintf(fid, '\n');
    end
    fclose(fid);
    
     %Write npcp data
    fid = fopen(char(strcat('results/npcp/', strcat(strcat(music_labels(i), num2str(j)), '.dat'))), 'wt');
    for k = 1:size(NPCP,1)
        fprintf(fid, '%d ', NPCP(k, :));
        fprintf(fid, '\n');
    end
    fclose(fid);
    
    end
end
