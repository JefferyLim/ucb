figure(1);

chunkx = 1:25;
chunky = 1:25;
hop = 25;
scale = {'classical', 'electronic' , 'jazz', 'punk', 'rock', 'world' };


for i = 1:6
    subplot(3,2,i);
    histogram(D_mfcc(chunkx, chunky));
    title(scale(i));
    chunkx = chunkx+25;
    chunky = chunky+25;
end

saveImage('histogram.png', '');
