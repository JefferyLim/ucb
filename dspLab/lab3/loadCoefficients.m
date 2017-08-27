function [mfcc, npcp] = loadCoefficients
%This function loads the mfcc and npcp dir and stores the data from the
%previous function. 
%Returns cell arrays of the imported data

mfcc_dir = dir('results/mfcc/*.dat');
npcp_dir = dir('results/npcp/*.dat');

%Import mfcc and npcp data
for i = 1:size(mfcc_dir)
    fprintf('Loading data: %3.2f%%\n', i/length(mfcc_dir)*100); %Status Bar
    mfcc{i} = importdata(strcat('results/mfcc/', mfcc_dir(i).name));
    npcp{i} = importdata(strcat('results/npcp/', npcp_dir(i).name));
end;
    
return;