clear all;

load('Features');
MSet = mean(Set);
STDSet = std(Set);
Set = bsxfun(@minus, Set, MSet);
Set = bsxfun(@rdivide, Set, STDSet);

%Shuffle set
Permutations = randperm(size(Set,1));
Set = Set(Permutations,:);
Labels = Labels(Permutations);


Trainsize = round( 0.65 * length(Labels) );

TrainSet = Set(1:Trainsize,:);
TrainLabels = Labels(1:Trainsize);

TestSet = Set(Trainsize+1:end,:);
TestLabels = Labels(Trainsize+1:end);

% cost = ...
% [0,1,1,2;...
%  2,0,1,2;...
%  1.5,1,0,2;...
%  2,1,1,0];
    

mdl = fitcknn(TrainSet,TrainLabels,'NSMethod','exhaustive',...
    'Distance','seuclidean','BreakTies','nearest','IncludeTies',true);
mdl.NumNeighbors = 3;
rloss = resubLoss(mdl);
cvmdl = crossval(mdl);
kloss = kfoldLoss(cvmdl);

predictions = predict(mdl,TestSet);

ConfMat = confusionmat(TestLabels, predictions)

[F1score, Accuracy] = Scores(ConfMat);


fprintf('Total Accuracy: %f\n', Accuracy *100);
fprintf('Total F1 score: %f\n', F1score * 100);




