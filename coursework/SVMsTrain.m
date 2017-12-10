% Here we train an ensmble learning that consist of 8 SVM classifier join
% with a KNN

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

% SVM
SVMModel1 = fitcsvm(set,indx,...
    'BoxConstraint',1,...
    'KernelScale','auto');
SVMModel1 = fitSVMPosterior(SVMModel1);
[~,score11] = predict(SVMModel1,tset);

[~,score11] = max(score11,[],2);

ConfMat = confusionmat(tindx, score11);

[F1score, Accuracy] = Scores(ConfMat);
% fprintf('Total Accuracy: %f\n', Accuracy *100);
% fprintf('Total F1 score: %f\n', F1score * 100);

[~,results] = predict(SVMModel1,TestSet);
[~,results] = max(results,[],2);

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

% SVM
SVMModel2 = fitcsvm(set,indx,...
    'BoxConstraint',0.5,...
    'KernelScale','auto');
SVMModel2 = fitSVMPosterior(SVMModel2);
[~,score11] = predict(SVMModel2,tset);
score11=[score11(:,1), zeros(length(score11),1), score11(:,2)];

[~,score11] = max(score11,[],2);

ConfMat = confusionmat(tindx, score11);

[F1score, Accuracy] = Scores(ConfMat);
% fprintf('Total Accuracy: %f\n', Accuracy *100);
% fprintf('Total F1 score: %f\n', F1score * 100);


[~,results] = predict(SVMModel2,TestSet);
results=[results(:,1), zeros(length(results),1), results(:,2)];
[~,results] = max(results,[],2);


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

% SVM
SVMModel3 = fitcsvm(set,indx,...
    'BoxConstraint',1,...
    'KernelScale','auto');
SVMModel3 = fitSVMPosterior(SVMModel3);
[~,score11] = predict(SVMModel3,tset);
score11=[score11(:,1), zeros(length(score11),1),zeros(length(score11),1), score11(:,2)];

[~,score11] = max(score11,[],2);

ConfMat = confusionmat(tindx, score11);

[F1score, Accuracy] = Scores(ConfMat);
% fprintf('Total Accuracy: %f\n', Accuracy *100);
% fprintf('Total F1 score: %f\n', F1score * 100);

[~,results] = predict(SVMModel3,TestSet);
results=[results(:,1), zeros(length(results),1),zeros(length(results),1), results(:,2)];
[~,results] = max(results,[],2);


SCORE = [SCORE, results];

%% Two vs Three
%display('Two vs Three')
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

% SVM
SVMModel4 = fitcsvm(set,indx,...
    'BoxConstraint',0.7,...
    'KernelScale','auto');
SVMModel4 = fitSVMPosterior(SVMModel4);
[~,score11] = predict(SVMModel4,tset);
score11=[zeros(length(score11),1),score11(:,1), score11(:,2)];

[~,score11] = max(score11,[],2);

ConfMat = confusionmat(tindx, score11);

[F1score, Accuracy] = Scores(ConfMat);
% fprintf('Total Accuracy: %f\n', Accuracy *100);
% fprintf('Total F1 score: %f\n', F1score * 100);

[~,results] = predict(SVMModel4,TestSet);
results=[zeros(length(results),1),results(:,1), results(:,2)];
[~,results] = max(results,[],2);


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

% SVM
SVMModel5 = fitcsvm(set,indx,...
    'BoxConstraint',1,...
    'KernelScale','auto');
SVMModel5 = fitSVMPosterior(SVMModel5);
[~,score11] = predict(SVMModel5,tset);
score11=[zeros(length(score11),1),score11(:,1),zeros(length(score11),1), score11(:,2)];
[~,score11] = max(score11,[],2);

ConfMat = confusionmat(tindx, score11);

[F1score, Accuracy] = Scores(ConfMat);
% fprintf('Total Accuracy: %f\n', Accuracy *100);
% fprintf('Total F1 score: %f\n', F1score * 100);

[~,results] = predict(SVMModel5,TestSet);
results=[zeros(length(results),1),results(:,1),zeros(length(results),1) ,results(:,2)];
[~,results] = max(results,[],2);


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

% SVM
SVMModel6 = fitcsvm(set,indx,...
    'BoxConstraint',0.7,...
    'KernelScale','auto');
SVMModel6 = fitSVMPosterior(SVMModel6);
[~,score11] = predict(SVMModel6,tset);
score11=[zeros(length(score11),1),zeros(length(score11),1),score11(:,1), score11(:,2)];
[~,score11] = max(score11,[],2);

ConfMat = confusionmat(tindx, score11);

[F1score, Accuracy] = Scores(ConfMat);
% fprintf('Total Accuracy: %f\n', Accuracy *100);
% fprintf('Total F1 score: %f\n', F1score * 100);

[~,results] = predict(SVMModel6,TestSet);
results=[zeros(length(results),1),zeros(length(results),1),results(:,1), results(:,2)];
[~,results] = max(results,[],2);


SCORE = [SCORE, results];
predictionsVal = mode(SCORE,2);
CrossValConf(:,:,i) = confusionmat(TestLabels, predictionsVal);
end
ConfMatInd = mean(CrossValConf,3);
%% predict
%display('predict')

predictions(:,1) = predict(SVMModel1,GlobalTestSet);
predictions(:,2) = predict(SVMModel2,GlobalTestSet);
predictions(:,3) = predict(SVMModel3,GlobalTestSet);
predictions(:,4) = predict(SVMModel4,GlobalTestSet);
predictions(:,5) = predict(SVMModel5,GlobalTestSet);
predictions(:,6) = predict(SVMModel6,GlobalTestSet);
predictions = mode(predictions,2);

ConfMat = confusionmat(GlobalTestLabels, predictions);

[F1score, Accuracy] = Scores(ConfMat);


% fprintf('Total Accuracy: %f\n', Accuracy *100);
% 
% fprintf('Total F1 score: %f\n\n', F1score * 100);



