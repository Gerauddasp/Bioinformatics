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

t = templateTree('minleaf',5);
tic
rusTree = fitensemble(TrainSet,TrainLabels,'RUSBoost',1000,t,...
    'LearnRate',0.1,'nprint',100);
toc

% figure;
% tic
% plot(loss(rusTree,TestSet,TestLabels,'mode','cumulative'));
% toc
% grid on;
% xlabel('Number of trees');
% ylabel('Test classification error');


predictions = predict(rusTree,TestSet);

ConfMat = confusionmat(TestLabels, predictions)

[F1score, Accuracy] = Scores(ConfMat);


fprintf('Total Accuracy: %f\n', Accuracy *100);
fprintf('Total F1 score: %f\n', F1score * 100);


