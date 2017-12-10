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

GlobalTrainSet = Set(1:Trainsize,:);
GlobalTrainLabels = Labels(1:Trainsize);

GlobalTestSet = Set(Trainsize+1:end,:);
GlobalTestLabels = Labels(Trainsize+1:end);

classes = unique(Labels);


k = 3;
Indices = crossvalind('Kfold',size(GlobalTrainSet,1),3);

for i=1:k
  SCORE = [];
  TrainSet = GlobalTrainSet(Indices ~=i,:);
  TrainLabels = GlobalTrainLabels(Indices ~= i );
  TestSet = GlobalTrainSet(Indices ==i,:);
  TestLabels = GlobalTrainLabels(Indices == i);

%% One vs Two
%display('One vs Two')
set1 = TrainSet(TrainLabels == 1,:);
set2 = TrainSet(TrainLabels == 2,:);
set = [set1; set2];

indx1 = TrainLabels(TrainLabels == 1);
indx2 = TrainLabels(TrainLabels == 2);
indx = [indx1; indx2];

tset1 = TestSet(TestLabels == 1,:);
tset2 = TestSet(TestLabels == 2,:);
tset = [tset1; tset2];

tindx1 = TestLabels(TestLabels == 1);
tindx2 = TestLabels(TestLabels == 2);
tindx = [tindx1; tindx2];

% KNN
mdl1 = fitcknn(set,indx,'NSMethod','exhaustive',...
    'Distance','seuclidean','BreakTies','nearest','IncludeTies',true);
mdl1.NumNeighbors = 3;
score12 = predict(mdl1,tset);

ConfMat = confusionmat(tindx, score12);

[F1score, Accuracy] = Scores(ConfMat);


% fprintf('Total Accuracy: %f\n', Accuracy *100);
% fprintf('Total F1 score: %f\n', F1score * 100);

results = predict(mdl1,TestSet);

SCORE = [SCORE, results];

%% One vs Three
%display('One vs Three')
set1 = TrainSet(TrainLabels == 1,:);
set2 = TrainSet(TrainLabels == 3,:);
set = [set1; set2];

indx1 = TrainLabels(TrainLabels == 1);
indx2 = TrainLabels(TrainLabels == 3);
indx = [indx1; indx2];

tset1 = TestSet(TestLabels == 1,:);
tset2 = TestSet(TestLabels == 3,:);
tset = [tset1; tset2];

tindx1 = TestLabels(TestLabels == 1);
tindx2 = TestLabels(TestLabels == 3);
tindx = [tindx1; tindx2];

% KNN
mdl2 = fitcknn(set,indx,'NSMethod','exhaustive',...
    'Distance','seuclidean','BreakTies','nearest','IncludeTies',true);
mdl2.NumNeighbors = 4;
score12 = predict(mdl2,tset);

ConfMat = confusionmat(tindx, score12);

[F1score, Accuracy] = Scores(ConfMat);
% fprintf('Total Accuracy: %f\n', Accuracy *100);
% fprintf('Total F1 score: %f\n', F1score * 100);

results = predict(mdl2,TestSet);

SCORE = [SCORE, results];


%% One vs Four
%display('One vs Four')
set1 = TrainSet(TrainLabels == 1,:);
set2 = TrainSet(TrainLabels == 4,:);
set = [set1; set2];

indx1 = TrainLabels(TrainLabels == 1);
indx2 = TrainLabels(TrainLabels == 4);
indx = [indx1; indx2];

tset1 = TestSet(TestLabels == 1,:);
tset2 = TestSet(TestLabels == 4,:);
tset = [tset1; tset2];

tindx1 = TestLabels(TestLabels == 1);
tindx2 = TestLabels(TestLabels == 4);
tindx = [tindx1; tindx2];

% KNN
mdl3 = fitcknn(set,indx,'NSMethod','exhaustive',...
    'Distance','seuclidean','BreakTies','nearest','IncludeTies',true);
mdl3.NumNeighbors = 5;
score12 = predict(mdl3,tset);

ConfMat = confusionmat(tindx, score12);

[F1score, Accuracy] = Scores(ConfMat);
% fprintf('Total Accuracy: %f\n', Accuracy *100);
% fprintf('Total F1 score: %f\n', F1score * 100);

results = predict(mdl3,TestSet);

SCORE = [SCORE, results];


%% Two vs Three
set1 = TrainSet(TrainLabels == 2,:);
set2 = TrainSet(TrainLabels == 3,:);
set = [set1; set2];

indx1 = TrainLabels(TrainLabels == 2);
indx2 = TrainLabels(TrainLabels == 3);
indx = [indx1; indx2];

tset1 = TestSet(TestLabels == 2,:);
tset2 = TestSet(TestLabels == 3,:);
tset = [tset1; tset2];

tindx1 = TestLabels(TestLabels == 2);
tindx2 = TestLabels(TestLabels == 3);
tindx = [tindx1; tindx2];

% KNN
mdl4 = fitcknn(set,indx,'NSMethod','exhaustive',...
    'Distance','seuclidean','BreakTies','nearest','IncludeTies',true);
mdl4.NumNeighbors = 2;
score12 = predict(mdl4,tset);

ConfMat = confusionmat(tindx, score12);

[F1score, Accuracy] = Scores(ConfMat);
% fprintf('Total Accuracy: %f\n', Accuracy *100);
% fprintf('Total F1 score: %f\n', F1score * 100);

results = predict(mdl4,TestSet);

SCORE = [SCORE, results];

%% Two vs Four
%display('Two vs Four')
set1 = TrainSet(TrainLabels == 2,:);
set2 = TrainSet(TrainLabels == 4,:);
set = [set1; set2];

indx1 = TrainLabels(TrainLabels == 2);
indx2 = TrainLabels(TrainLabels == 4);
indx = [indx1; indx2];

tset1 = TestSet(TestLabels == 2,:);
tset2 = TestSet(TestLabels == 4,:);
tset = [tset1; tset2];

tindx1 = TestLabels(TestLabels == 2);
tindx2 = TestLabels(TestLabels == 4);
tindx = [tindx1; tindx2];

% KNN
mdl5 = fitcknn(set,indx,'NSMethod','exhaustive',...
    'Distance','seuclidean','BreakTies','nearest','IncludeTies',true);
mdl5.NumNeighbors = 3;
score12 = predict(mdl5,tset);

ConfMat = confusionmat(tindx, score12);

[F1score, Accuracy] = Scores(ConfMat);
% fprintf('Total Accuracy: %f\n', Accuracy *100);
% fprintf('Total F1 score: %f\n', F1score * 100);

results = predict(mdl5,TestSet);

SCORE = [SCORE, results];

%% Three vs Four
%display('Three vs Four')
set1 = TrainSet(TrainLabels == 3,:);
set2 = TrainSet(TrainLabels == 4,:);
set = [set1; set2];

indx1 = TrainLabels(TrainLabels == 3);
indx2 = TrainLabels(TrainLabels == 4);
indx = [indx1; indx2];

tset1 = TestSet(TestLabels == 3,:);
tset2 = TestSet(TestLabels == 4,:);
tset = [tset1; tset2];

tindx1 = TestLabels(TestLabels == 3);
tindx2 = TestLabels(TestLabels == 4);
tindx = [tindx1; tindx2];

% KNN
mdl6 = fitcknn(set,indx,'NSMethod','exhaustive',...
    'Distance','seuclidean','BreakTies','nearest','IncludeTies',true);
mdl6.NumNeighbors = 3;
score12 = predict(mdl6,tset);

ConfMat = confusionmat(tindx, score12);

[F1score, Accuracy] = Scores(ConfMat);
% fprintf('Total Accuracy: %f\n', Accuracy *100);
% fprintf('Total F1 score: %f\n', F1score * 100);

results = predict(mdl6,TestSet);

SCORE = [SCORE, results];
predictionsVal = mode(SCORE,2);
CrossValConf(:,:,i) = confusionmat(TestLabels, predictionsVal);
end
ConfMatInd = mean(CrossValConf,3);
%% predict

predictions(:,1) = predict(mdl1,GlobalTestSet);
predictions(:,2) = predict(mdl2,GlobalTestSet);
predictions(:,3) = predict(mdl3,GlobalTestSet);
predictions(:,4) = predict(mdl4,GlobalTestSet);
predictions(:,5) = predict(mdl5,GlobalTestSet);
predictions(:,6) = predict(mdl6,GlobalTestSet);
predictions = mode(predictions,2);

ConfMat = confusionmat(GlobalTestLabels, predictions);

[F1score, Accuracy] = Scores(ConfMat);


% fprintf('Total Accuracy: %f\n', Accuracy *100);
% fprintf('Total F1 score: %f\n\n', F1score * 100);


