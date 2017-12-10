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

TrainSet = Set(1:Trainsize,:);
TrainLabels = Labels(1:Trainsize);

TestSet = Set(Trainsize+1:end,:);
TestLabels = Labels(Trainsize+1:end);

classes = unique(Labels);

SCORE = [];

%% One vs Two
display('One vs Two')
set1 = TrainSet(TrainLabels == 1,:);
set2 = TrainSet(TrainLabels == 2,:);
set = [set1; set2];

indx1 = TrainLabels(TrainLabels == 1);
indx2 = TrainLabels(TrainLabels == 2);
indx = [indx1; indx2];

% SVM
SVMModel1 = fitcsvm(set,indx,...
    'BoxConstraint',1,...
    'KernelScale','auto');
SVMModel1 = fitSVMPosterior(SVMModel1);
[~,score12] = predict(SVMModel1,TestSet);

[~,score11] = max(score11,[],2);

% KNN
mdl1 = fitcknn(set,indx,'NSMethod','exhaustive',...
    'Distance','seuclidean','BreakTies','nearest','IncludeTies',true);
mdl1.NumNeighbors = 2;
score12 = predict(mdl1,TestSet);

SCORE = [SCORE, score11, score12];



%% One vs Three
display('One vs Three')
set1 = TrainSet(TrainLabels == 1,:);
set2 = TrainSet(TrainLabels == 3,:);
set = [set1; set2];

indx1 = TrainLabels(TrainLabels == 1);
indx2 = TrainLabels(TrainLabels == 3);
indx = [indx1; indx2];

% SVM
SVMModel2 = fitcsvm(set,indx,...
    'BoxConstraint',0.5,...
    'KernelScale','auto');
SVMModel2 = fitSVMPosterior(SVMModel2);
[~,score11] = predict(SVMModel2,TestSet);
score11=[score11(:,1), zeros(length(score11),1), score11(:,2)];

[~,score11] = max(score11,[],2);

% KNN
mdl2 = fitcknn(set,indx,'NSMethod','exhaustive',...
    'Distance','seuclidean','BreakTies','nearest','IncludeTies',true);
mdl2.NumNeighbors = 4;
score12 = predict(mdl2,TestSet);

SCORE = [SCORE, score11, score12];

%% One vs Four
display('One vs Four')
set1 = TrainSet(TrainLabels == 1,:);
set2 = TrainSet(TrainLabels == 4,:);
set = [set1; set2];

indx1 = TrainLabels(TrainLabels == 1);
indx2 = TrainLabels(TrainLabels == 4);
indx = [indx1; indx2];

% SVM
SVMModel3 = fitcsvm(set,indx,...
    'BoxConstraint',1,...
    'KernelScale','auto');
SVMModel3 = fitSVMPosterior(SVMModel3);
[~,score11] = predict(SVMModel3,TestSet);
score11=[score11(:,1), zeros(length(score11),1),zeros(length(score11),1), score11(:,2)];

[~,score11] = max(score11,[],2);

% KNN
mdl3 = fitcknn(set,indx,'NSMethod','exhaustive',...
    'Distance','seuclidean','BreakTies','nearest','IncludeTies',true);
mdl3.NumNeighbors = 5;
score12 = predict(mdl3,TestSet);



SCORE = [SCORE, score11, score12];


%% Two vs Three
display('Two vs Three');
set1 = TrainSet(TrainLabels == 2,:);
set2 = TrainSet(TrainLabels == 3,:);
set = [set1; set2];

indx1 = TrainLabels(TrainLabels == 2);
indx2 = TrainLabels(TrainLabels == 3);
indx = [indx1; indx2];

% SVM
SVMModel4 = fitcsvm(set,indx,...
    'BoxConstraint',0.7,...
    'KernelScale','auto');
SVMModel4 = fitSVMPosterior(SVMModel4);
[~,score11] = predict(SVMModel4,TestSet);
score11=[zeros(length(score11),1),score11(:,1), score11(:,2)];

[~,score11] = max(score11,[],2);

% KNN
mdl4 = fitcknn(set,indx,'NSMethod','exhaustive',...
    'Distance','seuclidean','BreakTies','nearest','IncludeTies',true);
mdl4.NumNeighbors = 2;
score12 = predict(mdl4,TestSet);

SCORE = [SCORE, score11, score12];

%% Two vs Four
display('Two vs Four')
set1 = TrainSet(TrainLabels == 2,:);
set2 = TrainSet(TrainLabels == 4,:);
set = [set1; set2];

indx1 = TrainLabels(TrainLabels == 2);
indx2 = TrainLabels(TrainLabels == 4);
indx = [indx1; indx2];

% SVM
SVMModel5 = fitcsvm(set,indx,...
    'BoxConstraint',1,...
    'KernelScale','auto');
SVMModel5 = fitSVMPosterior(SVMModel5);
[~,score11] = predict(SVMModel5,TestSet);
score11=[zeros(length(score11),1),score11(:,1),zeros(length(score11),1), score11(:,2)];
[~,score11] = max(score11,[],2);

% KNN
mdl5 = fitcknn(set,indx,'NSMethod','exhaustive',...
    'Distance','seuclidean','BreakTies','nearest','IncludeTies',true);
mdl5.NumNeighbors = 3;
score12 = predict(mdl5,TestSet);

SCORE = [SCORE, score11, score12];

%% Three vs Four
display('Three vs Four');
set1 = TrainSet(TrainLabels == 3,:);
set2 = TrainSet(TrainLabels == 4,:);
set = [set1; set2];

indx1 = TrainLabels(TrainLabels == 3);
indx2 = TrainLabels(TrainLabels == 4);
indx = [indx1; indx2];

% SVM
SVMModel6 = fitcsvm(set,indx,...
    'BoxConstraint',0.7,...
    'KernelScale','auto');
SVMModel6 = fitSVMPosterior(SVMModel6);
[~,score11] = predict(SVMModel6,TestSet);
score11=[zeros(length(score11),1),zeros(length(score11),1),score11(:,1), score11(:,2)];
[~,score11] = max(score11,[],2);

% KNN
mdl6 = fitcknn(set,indx,'NSMethod','exhaustive',...
    'Distance','seuclidean','BreakTies','nearest','IncludeTies',true);
mdl6.NumNeighbors = 3;
score12 = predict(mdl6,TestSet);

SCORE = [SCORE, score11, score12];


%% predict

predictions = mode(SCORE,2);

ConfMat = confusionmat(TestLabels, predictions)

[F1score, Accuracy] = Scores(ConfMat);


fprintf('Total Accuracy: %f\n', Accuracy *100);
fprintf('Total F1 score: %f\n', F1score * 100);

% %% Cross-Validation
% display('Cross-Validation')
% 
% Indices = crossvalind('Kfold',size(Set,1),5);
% 
% for i=1:5
% 
%     SCORE1 = [];
%     [~,results] = predict(SVMModel1,Set(Indices ~=i,:));
%     [~,results] = max(results,[],2);
%     
%     results2 = predict(mdl1,Set(Indices ~= i,:));
%     SCORE1 = [SCORE1, results, results2];
% 
%     
%     [~,results] = predict(SVMModel2,Set(Indices ~=i,:));
%     results=[results(:,1), zeros(length(results),1), results(:,2)];
%     [~,results] = max(results,[],2);
%     results2 = predict(mdl2,Set(Indices ~= i,:));
%     SCORE1 = [SCORE1, results, results2];
%     
%     [~,results] = predict(SVMModel3,Set(Indices ~=i,:));
%     results=[results(:,1), zeros(length(results),1),zeros(length(results),1), results(:,2)];
%     [~,results] = max(results,[],2);
%     results2 = predict(mdl3,Set(Indices ~= i,:));
%     SCORE1 = [SCORE1, results, results2];
%     
%     [~,results] = predict(SVMModel4,Set(Indices ~=i,:));
%     results=[zeros(length(results),1),results(:,1), results(:,2)];
%     [~,results] = max(results,[],2);
%     results2 = predict(mdl4,Set(Indices ~= i,:));
%     SCORE1 = [SCORE1, results, results2];
%     
%     [~,results] = predict(SVMModel5, Set(Indices ~=i,:));
%     results=[zeros(length(results),1),results(:,1), results(:,2)];
%     [~,results] = max(results,[],2);
%     results2 = predict(mdl5,Set(Indices ~= i,:));
%     SCORE1 = [SCORE1, results, results2];
%     
%     [~,results] = predict(SVMModel6,Set(Indices ~=i,:));
%     results=[zeros(length(results),1),zeros(length(results),1),results(:,1), results(:,2)];
%     [~,results] = max(results,[],2);
%     results2 = predict(mdl6,Set(Indices ~= i,:));
%     SCORE1 = [SCORE1, results, results2];
%     
%     predictions = mode(SCORE1,2);
%     
%     ConfMat(:,:,i) = confusionmat(Labels(Indices ~=i), predictions);
%     
% 
%     
% end

% 
% ConfMat = mean(ConfMat,3)
% 
% [F1score, Accuracy] = Scores(ConfMat);
% 
% 
% fprintf('Total Accuracy: %f\n', Accuracy *100);
% 
% fprintf('Total F1 score: %f\n', F1score * 100);