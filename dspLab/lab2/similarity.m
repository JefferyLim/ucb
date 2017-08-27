function [ S ] = similarity(mfcc)
%similarity(mfcc) - Takes and mfcc matrix and computes the similarity
%matrix when comparing the frames with each other

    nFrames = size(mfcc,2);

    S = zeros(nFrames, nFrames);

    for i = 1:nFrames
        for j = 1:nFrames
            S(i,j) = sum((mfcc(:,i).*mfcc(:,j))/(norm(mfcc(:,i))*norm(mfcc(:,j))));
        end
    end

end
