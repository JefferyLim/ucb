function [ confusion ] = genreClassifier(distance, genres, fitType)
%Genre Classifier

confusion = zeros(6, 6);

%Cross Valid by removing 5 entries per class
[indicies] = crossvalind('KFold',genres, 5);

%Go through all the data set
for i = 1:5
        train = find(indicies ~= i, 120);
        test = find(indicies == i, 30);
        
        %KNN or SVM
        if(strcmp(fitType, 'knn'))
            Mdl = fitcknn(distance(train,:), genres(train), 'NumNeighbors', 5, 'Standardize', 1);
        elseif(strcmp(fitType, 'svm'))
            Mdl = fitcecoc(distance(train,:), genres(train));
        end
            
        %Predict using the test class
        class = predict(Mdl, distance(test, :));
      
        %Takes the predicted classes and organizes them
        L = 1;
        for j = 1:6
            for k = 1:5
                switch char(class(L))
                    case {'classical'}
                        input = 1;
                    case {'electronic'}
                        input = 2;
                    case {'jazz'}
                        input = 3;
                    case {'punk'}
                        input = 4;
                    case {'rock'}
                        input = 5;
                    case {'world'}
                        input = 6;
                end

                confusion(j, input) = confusion(j, input) + 1;
                L = L + 1;
            end
        end
end

