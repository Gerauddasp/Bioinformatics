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

for ii=1:k
    predKNN =[];
    predSVM = [];
    probKNN = [];
    probSVM = [];
    predictions = [];
    SCORE = [];
  TrainSet = GlobalTrainSet(Indices ~=ii,:);
  TrainLabels = GlobalTrainLabels(Indices ~= ii );
  TestSet = GlobalTrainSet(Indices ==ii,:);
  TestLabels = GlobalTrainLabels(Indices == ii);

%% One vs Two
%display('One vs Two')
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
[predSVM(:,1),probSVM(:,1:2)] = predict(SVMModel1,TestSet);


% KNN
mdl1 = fitcknn(set,indx,'NSMethod','exhaustive',...
    'Distance','seuclidean','BreakTies','nearest','IncludeTies',true);
mdl1.NumNeighbors = 3;
[predKNN(:,1),probKNN(:,1:2)] = predict(mdl1,TestSet);




%% One vs Three
%display('One vs Three')
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
[predSVM(:,2), probSVM(:,3:4)] = predict(SVMModel2,TestSet);


% KNN
mdl2 = fitcknn(set,indx,'NSMethod','exhaustive',...
    'Distance','seuclidean','BreakTies','nearest','IncludeTies',true);
mdl2.NumNeighbors = 4;
[predKNN(:,2), probKNN(:,3:4)] = predict(mdl2,TestSet);


%% One vs Four
%display('One vs Four')
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
[predSVM(:,3),probSVM(:,5:6)] = predict(SVMModel3,TestSet);


% KNN
mdl3 = fitcknn(set,indx,'NSMethod','exhaustive',...
    'Distance','seuclidean','BreakTies','nearest','IncludeTies',true);
mdl3.NumNeighbors = 5;
[predKNN(:,3), probKNN(:,5:6)] = predict(mdl3,TestSet);




%% Two vs Three
%display('Two vs Three');
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
[predSVM(:,4),probSVM(:,7:8)] = predict(SVMModel4,TestSet);


% KNN
mdl4 = fitcknn(set,indx,'NSMethod','exhaustive',...
    'Distance','seuclidean','BreakTies','nearest','IncludeTies',true);
mdl4.NumNeighbors = 2;
[predKNN(:,4), probKNN(:,7:8)] = predict(mdl4,TestSet);


%% Two vs Four
%display('Two vs Four')
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
[predSVM(:,5), probSVM(:,9:10)] = predict(SVMModel5,TestSet);


% KNN
mdl5 = fitcknn(set,indx,'NSMethod','exhaustive',...
    'Distance','seuclidean','BreakTies','nearest','IncludeTies',true);
mdl5.NumNeighbors = 3;
[predKNN(:,5), probKNN(:,9:10)] = predict(mdl5,TestSet);


%% Three vs Four
%display('Three vs Four');
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
[predSVM(:,6),probSVM(:,11:12)] = predict(SVMModel6,TestSet);


% KNN
mdl6 = fitcknn(set,indx,'NSMethod','exhaustive',...
    'Distance','seuclidean','BreakTies','nearest','IncludeTies',true);
mdl6.NumNeighbors = 3;
[predKNN(:,6), probKNN(:,11:12)] = predict(mdl6,TestSet);



%% predict
probclass = [1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0;...
    0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0;...
    0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0;...
    0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1];

for i=1:size(predKNN,1)
    probKNN1 = mean(probKNN(i,logical(probclass(1,:))));
    probKNN2 = mean(probKNN(i,logical(probclass(2,:))));
    probKNN3 = mean(probKNN(i,logical(probclass(3,:))));
    probKNN4 = mean(probKNN(i,logical(probclass(4,:))));
    [MprobKNN, MselKNN] = max([probKNN1, probKNN2, probKNN3, probKNN4],[],2);
    
    probSVM1 = mean(probSVM(i,logical(probclass(1,:))));
    probSVM2 = mean(probSVM(i,logical(probclass(2,:))));
    probSVM3 = mean(probSVM(i,logical(probclass(3,:))));
    probSVM4 = mean(probSVM(i,logical(probclass(4,:))));
    [MprobSVM, MselSVM] = max([probSVM1, probSVM2, probSVM3, probSVM4],[],2);
    % last test
    
    
    
    % test
    [~, WHICH] = max([MprobKNN, MprobSVM]);
    CHOICE = [MselKNN, MselSVM];
    predictions(i,1) = CHOICE(WHICH);
end

ConfMatVal(:,:,ii) = confusionmat(TestLabels, predictions);

end
%% final test
predKNN =[];
predSVM = [];
probKNN = [];
probSVM = [];
predictions = [];

[predSVM(:,1),probSVM(:,1:2)] = predict(SVMModel1,GlobalTestSet);
[predKNN(:,1),probKNN(:,1:2)] = predict(mdl1,GlobalTestSet);
[predSVM(:,2), probSVM(:,3:4)] = predict(SVMModel2,GlobalTestSet);
[predKNN(:,2), probKNN(:,3:4)] = predict(mdl2,GlobalTestSet);
[predSVM(:,3),probSVM(:,5:6)] = predict(SVMModel3,GlobalTestSet);
[predKNN(:,3), probKNN(:,5:6)] = predict(mdl3,GlobalTestSet);
[predSVM(:,4),probSVM(:,7:8)] = predict(SVMModel4,GlobalTestSet);
[predKNN(:,4), probKNN(:,7:8)] = predict(mdl4,GlobalTestSet);
[predSVM(:,5), probSVM(:,9:10)] = predict(SVMModel5,GlobalTestSet);
[predKNN(:,5), probKNN(:,9:10)] = predict(mdl5,GlobalTestSet);
[predSVM(:,6),probSVM(:,11:12)] = predict(SVMModel6,GlobalTestSet);
[predKNN(:,6), probKNN(:,11:12)] = predict(mdl6,GlobalTestSet);

probclass = [1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0;...
    0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0;...
    0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0;...
    0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1];

for i=1:size(predKNN,1)
    probKNN1 = mean(probKNN(i,logical(probclass(1,:))));
    probKNN2 = mean(probKNN(i,logical(probclass(2,:))));
    probKNN3 = mean(probKNN(i,logical(probclass(3,:))));
    probKNN4 = mean(probKNN(i,logical(probclass(4,:))));
    [MprobKNN, MselKNN] = max([probKNN1, probKNN2, probKNN3, probKNN4],[],2);
    
    probSVM1 = mean(probSVM(i,logical(probclass(1,:))));
    probSVM2 = mean(probSVM(i,logical(probclass(2,:))));
    probSVM3 = mean(probSVM(i,logical(probclass(3,:))));
    probSVM4 = mean(probSVM(i,logical(probclass(4,:))));
    [MprobSVM, MselSVM] = max([probSVM1, probSVM2, probSVM3, probSVM4],[],2);
    % last test
    
    
    
    % test
    [~, WHICH] = max([MprobKNN, MprobSVM]);
    CHOICE = [MselKNN, MselSVM];
    predictions(i,1) = CHOICE(WHICH);
end

ConfMat = confusionmat(GlobalTestLabels, predictions);

[F1score, Accuracy] = Scores(ConfMat);


% fprintf('Total Accuracy: %f\n', Accuracy *100);
% fprintf('Total F1 score: %f\n', F1score * 100);