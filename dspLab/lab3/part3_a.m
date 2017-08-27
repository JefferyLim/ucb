close all;
clear;

%Adding the path of data into the current directory
addpath(genpath('data/'));

%Load all tracks
classical = dir('data/classical/*.wav');
electronic = dir('data/electronic/*.wav');
jazz = dir('data/jazz/*.wav');
punk = dir('data/punk/*.wav');
rock = dir('data/rock/*.wav');
world = dir('data/world/*.wav');

%Put each music genre in its own row
music = [classical, electronic, jazz, punk, rock, world];
music_labels = {'classical';'electronic'; 'jazz'; 'punk'; 'rock'; 'world'};

%Define frame size
mfcc_frameSize = 512;
npcp_frameSize = 4096;

%Define 2 minute clip lengths
clipLength = 120;

%Status report
statusbar = 1;
totalbar = size(music,1) * size(music,2);

for i=1:size(music,2)
    for j = 1:size(music,1)
        
    fprintf('Percent done: %3.2f%%\n', statusbar/totalbar * 100); %Status Bar
    statusbar = statusbar + 1;
    
    %obtain the song and clip the song 
    [wav, fs] = audioread(music(j, i).name);
    if length(wav) < 120
            clipLength = floor(length(wav1)/fs);
        else
            clipLength = 120;
    end;
    
    wav = audioclip(wav,fs, clipLength);

    %compute the mfcc coefficients with 512 samples and a kaiser window
    mfcc = fmeyer_mfcc(wav, fs, mfcc_frameSize, hann(mfcc_frameSize));
    npcp = mychroma(wav', fs, npcp_frameSize);
    
    %Remapping mfcc to different notes
    t = zeros(1,36);
    t(1)   = 1; t(7:8)   = 5; t(15:18)= 9;
    t(2)   = 2; t(9:10) = 6; t(19:23) = 10;
    t(3:4) = 3; t(11:12) = 7; t(24:29) = 11;
    t(5:6) = 4; t(13:14) = 8; t(30:36) = 12;

    mel = zeros(12, length(mfcc));
    for k=1:12,
        mel(k,:) = sum(mfcc(t==k,:),1);
    end
    mfcc = mel;
    
    %Write mfcc data
    fid = fopen(char(strcat('results/mfcc/', strcat(strcat(music_labels(i), num2str(j)), '.dat'))), 'wt');
    for k = 1:size(mfcc,1)
        fprintf(fid, '%d ', mfcc(k,:));
        fprintf(fid, '\n');
    end
    fclose(fid);
    
    %Write npcp data
    fid = fopen(char(strcat('results/npcp/', strcat(strcat(music_labels(i), num2str(j)), '.dat'))), 'wt');
    for k = 1:size(npcp,1)
        fprintf(fid, '%d ', npcp(k, :));
        fprintf(fid, '\n');
    end
    fclose(fid);
    
    end;
end;

clear;