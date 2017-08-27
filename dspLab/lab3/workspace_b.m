%Chunksize and hopsize for 25 songs per category

hopSize = 25;

%Load coefficients of mfcc and npcp if it is not in the workspace already
if ~exist('mfcc', 'var')
    [mfcc, npcp] = loadCoefficients;
end

for gam = .05
    
chunkSize_i = 1:25;
chunkSize_j = 1:25;

%Compute the distances
[D_mfcc, D_npcp] = computeDistance(gam, mfcc, npcp);

%plots
figure(1);
subplot(1,2,1);
imagesc((D_mfcc));

title('MFCC Distance Matrix');xlabel('Songs');ylabel('Songs');
colorbar; 

subplot(1,2,2);
imagesc((D_npcp));

title('NPCP Distance Matrix');xlabel('Songs');ylabel('Songs');
colorbar;

saveImage('gamma_.png', num2str(gam*10));

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

chunkSize_i = 1:25;
chunkSize_j = 1:25;

%Normalizing the average
averageD_mfcc = averageD_mfcc/max(max(averageD_mfcc));
averageD_npcp = averageD_npcp/max(max(averageD_npcp));

%Math in order to determine the max separation values between the
%distance
for i = 1:6
    maxSep_mfcc(i, gam*10) =  max(averageD_mfcc(i,:)) - max(averageD_mfcc(i, averageD_mfcc(i,:)<max(averageD_mfcc(i,:))));
    maxSep_npcp(i, gam*10) =  max(averageD_npcp(i,:)) - max(averageD_npcp(i, averageD_npcp(i,:)<max(averageD_npcp(i,:))));
end

%Graphing the average distance matrix
genre = {'classical', 'electronic' , 'jazz', 'punk', 'rock', 'world' };
figure(2);
subplot(1,2,1);
imagesc(averageD_mfcc);
title('Average MFCC Distances');
colorbar; colormap jet;set(gca, 'XtickLabel', genre(:), 'YtickLabel', genre(:));

subplot(1,2,2);
imagesc(averageD_npcp);
title('Average NPCP Distances');
colorbar; colormap jet;set(gca, 'XtickLabel', genre(:), 'YtickLabel', genre(:));

saveImage('average_.png', num2str(gam*10));

end;



