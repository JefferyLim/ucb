%Chunksize and hopsize for 25 songs per category
chunkSize_i = 1:25;
chunkSize_j = 1:25;
hopSize = 25;

%Load coefficients of mfcc and npcp if it is not in the workspace already
if ~exist('mfcc', 'var')
    [mfcc, npcp] = loadCoefficients;
end

for gam = 30
%Compute the distances
[D_mfcc, D_npcp] = computeDistance(gam, mfcc, npcp);

averageD_mfcc = zeros(6,6);
averageD_npcp = zeros(6,6);

%Calculating the averages of D_mfcc and D_npcp
for i = 1:6
    for j = 1:6
        averageD_mfcc(i,j) = mean(mean(D_mfcc(chunkSize_i, chunkSize_j)));
        averageD_npcp(i,j) = mean(mean(D_npcp(chunkSize_i, chunkSize_j)));

        chunkSize_j = chunkSize_j + hopSize;
    end;
    chunkSize_i = chunkSize_i + hopSize;
    chunkSize_j = 1:25;
end;

%Graphing the average distance matrix
scale = {'classical', 'electronic' , 'jazz', 'punk', 'rock', 'world' };
figure(1);
subplot(1,2,1);
imagesc(averageD_mfcc);
title('Average MFCC Distances');
colorbar; colormap jet;set(gca, 'XtickLabel', scale(:), 'YtickLabel', scale(:));

subplot(1,2,2);
imagesc(averageD_npcp);
title('Average NPCP Distances');
colorbar; colormap jet;set(gca, 'XtickLabel', scale(:), 'YtickLabel', scale(:));

saveImage('length', 240);

end;



