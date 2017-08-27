chunkSize_i = 1:25;
chunkSize_j = 1:25;
hopSize = 25;

%Load coefficients of mfcc and npcp
if ~exist('mfcc', 'var')
    [mfcc, npcp] = loadCoefficients;
end

for gam = 10:10:100
    %Computer the distances
    [D_mfcc, D_npcp] = computeDistance(gam, mfcc, npcp);
       
    %Calculating the averages of D_mfcc and D_npcp
    for i = 1:6
        for j = 1:6
            averageD_mfcc(i,j) = mean(mean(D_mfcc(chunkSize_i, chunkSize_j)));
            averageD_npcp(i,j) = mean(mean(D_npcp(chunkSize_i, chunkSize_j)));

            chunkSize_j = chunkSize_j + hopSize;
        end;
        chunkSize_i = chunkSize_i + hopSize;
        chunkSize_j = 1:25;
        
        %Calculate the maximum difference between the largest and second
        %largest value
       
    end;

    chunkSize_i = 1:25;
    chunkSize_j = 1:25;
    
    averageD_mfcc = averageD_mfcc/max(max(averageD_mfcc));
    averageD_npcp = averageD_npcp/max(max(averageD_npcp));
    
    for i = 1:6
        maxSep_mfcc(i, gam/10) =  max(averageD_mfcc(i,:)) - max(averageD_mfcc(i, averageD_mfcc(i,:)<max(averageD_mfcc(i,:))));
        maxSep_npcp(i, gam/10) =  max(averageD_npcp(i,:)) - max(averageD_npcp(i, averageD_npcp(i,:)<max(averageD_npcp(i,:))));
    end

    %Graphing the average distance matrix
    scale = {'classical', 'electronic' , 'jazz', 'punk', 'rock', 'world' };
    figure(1)
    subplot(1,2,1);
    imagesc(averageD_mfcc);
    title('Average MFCC Distances');
    colorbar; colormap jet;set(gca, 'XtickLabel', scale(:), 'YtickLabel', scale(:));

    subplot(1,2,2);
    imagesc(averageD_npcp);
    title('Average NPCP Distances');
    colorbar; colormap jet;set(gca, 'XtickLabel', scale(:), 'YtickLabel', scale(:));
  
end;



