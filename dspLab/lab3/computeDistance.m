function [D_mfcc, D_npcp] = computeDistance(gam, mfcc, npcp)
addpath(genpath('results/'));

%Preallocate the matrices
D_mfcc = zeros(length(mfcc), length(mfcc));
D_npcp = D_mfcc;

%Analyze the KLDistances
for i = 1:length(mfcc) 
    fprintf('Analyzing Data at gam: %d : %3.2f%%\n', gam, i/length(mfcc)*100); %Status Bar
    for j = 1:i
        %Retrieve the two sets of data
        mfcc_i = mfcc{i};
        npcp_i = npcp{i};
        
        mfcc_j = mfcc{j};
        npcp_j = npcp{j};
        
        %Calculate the KLDistances
        D_mfcc(i,j) = KLDistance(mfcc_i, mfcc_j, gam);
        D_npcp(i,j) = KLDistance(npcp_i, npcp_j, gam);
        
        %Since i -> j is the same as j -> i
        D_mfcc(j,i) =  D_mfcc(i,j);
        D_npcp(j,i) = D_npcp(i,j);
        
    end
end

end