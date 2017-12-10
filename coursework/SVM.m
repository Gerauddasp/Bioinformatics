clear all;
load('Features');

% Normalize datas
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

classes = unique(Labels);

idx = TrainLabels(TrainLabels==classes(1));
SVMModel1 = fitcsvm(TrainSet(TrainLabels==classes(1),:),idx,...
    'KernelScale','auto');
[~,scores1] = predict(SVMModel1,TestSet);


idx = TrainLabels(TrainLabels==classes(2));
SVMModel2 = fitcsvm(TrainSet(TrainLabels==classes(2),:),idx,...
    'KernelScale','auto');
[~,scores2] = predict(SVMModel2,TestSet);

idx = TrainLabels(TrainLabels==classes(3));
SVMModel3 = fitcsvm(TrainSet(TrainLabels==classes(3),:),idx,...
    'KernelScale','auto');
[~,scores3] = predict(SVMModel3,TestSet);

idx = TrainLabels(TrainLabels==classes(4));
SVMModel4 = fitcsvm(TrainSet(TrainLabels==classes(4),:),idx,...
    'KernelScale','auto');
[~,scores4] = predict(SVMModel4,TestSet);

SCORES = [scores1, scores2, scores3, scores4];

mp = mean(SCORES);
sp = std(SCORES);
SCORES = bsxfun(@minus, SCORES, mp);
SCORES = bsxfun(@rdivide, SCORES, sp);

[proba ,predictions] = max(SCORES,[],2);

ConfMat = confusionmat(TestLabels, predictions)

[F1score, Accuracy] = Scores(ConfMat);


fprintf('Total Accuracy: %f\n', Accuracy *100);
fprintf('Total F1 score: %f\n', F1score * 100);