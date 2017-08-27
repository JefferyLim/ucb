%workspace to work with different classifier

%Genre names
genres = cell(1,150);
genres(1:25) = {'classical'};
genres(26:50) = {'electronic'};
genres(51:75) = {'jazz'};
genres(76:100) = {'punk'};
genres(101:125) = {'rock'};
genres(126:150) = {'world'};

%Pre Generation of confusion matrices
confusion = zeros(6, 6, 10);
confusionSVM = zeros(6, 6, 10);
meanConfusion =  zeros(6,6);
meanConfusionSVM = zeros(6,6);
stdConfusion =  zeros(6,6);
stdConfusionSVM = zeros(6,6);

for n = 1:10
    %Confusion matrix
    confusion(:,:,n) = genreClassifier(D_mfcc, genres, 'knn');
    %Confusion matrix for SVM
    confusionSVM(:,:,n) = genreClassifier(D_mfcc, genres, 'svm');
end

for i = 1:6
    for j = 1:6
        meanConfusion(i,j) =  mean(confusion(i,j,:));
        meanConfusionSVM(i,j) = mean(confusionSVM(i,j,:));
        stdConfusion(i,j) =  std(confusion(i,j,:));
        stdConfusionSVM(i,j) = std(confusionSVM(i,j,:));
    end
end

meanConfusion
meanConfusionSVM
