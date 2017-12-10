function [score, Accuracy] = Scores(confusionMat)

for i=1:size(confusionMat,2)
    Precision(i) = confusionMat(i,i) / sum( confusionMat(:,i) );
    Recall(i) = confusionMat(i,i) / sum(confusionMat(i,:),2) ;

end

score = 2 * (Precision .* Recall) ./ (Precision + Recall);
score(isnan(score)) = 0;
score = mean(score);

Accuracy = sum(diag(confusionMat)) / sum(sum(confusionMat));

end