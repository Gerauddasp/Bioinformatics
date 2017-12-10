clear all; close all;
tic
%display('loading data...');

%% extracting features from test set
TestSetstr = fastaread('testSet.fasta.txt');
TestSet = str2mat(TestSetstr.Sequence);

%% Which features
Features1 = true; % molweight
Features2 = true; % isoelectric
Features3 = false; % aacount
Features4 = true; % length protein
Features5 = true; % AAassociation
Features6 = true; % hydrophobicity
% first part of the protein
Features7 = false; % molweight
Features8 = true; % isolectric
Features9 = true; % aacount
Features10 = false; % AAassociation
Features11 = true; % hydrophobicity
% end part of the protein
Features12 = false; % molweight
Features13 = true; % isolectric
Features14 = true; % aacount
Features15 = false; % AAassociation
Features16 = true; % hydrophobicity

%% Extracting features
for i=1:size(TestSet,1)
    if any(TestSet(i,:) == 'B')
            I = strfind(TestSet(i,:),'B');
            TestSet(i,I) = 'D';
    end
    if any(TestSet(i,:) == 'Z')
            I = strfind(TestSet(i,:),'Z');
            TestSet(i,I) = 'E'; 
    end
        % analysing the entire sequence
        sequence = strcat(TestSet(i,:));
        if Features1
            FeaturesC1(i,1) = molweight(sequence);
        end
        if Features2
            FeaturesC2(i,1) = isoelectric(sequence);
        end
        if Features3
            AAstruct = aacount(sequence);
            AAcell = struct2cell(AAstruct);
            FeaturesC3(i,:) = (cell2mat(AAcell))'/ length(sequence);
        end
        if Features4
            FeaturesC4(i,:) = length(sequence);
        end
        if Features5
            res = AAassociation(sequence);
            FeaturesC5(i,:) = res(:);
        end
        if Features6
            h = proteinpropplot(sequence);
            FeaturesC6(i,:) = mean(h.Data);
        end
        % the first part of the sequence
        if Features7
            FeaturesC7(i,1) = molweight(sequence(1:50));
        end
        if Features8
            FeaturesC8(i,1) = isoelectric(sequence(1:50));
        end
        if Features9
            AAstruct = aacount(sequence(1:50));
            AAcell = struct2cell(AAstruct);
            FeaturesC9(i,:) = (cell2mat(AAcell))'/ length(sequence(1:50));
        end
        if Features10
            res = AAassociation(sequence(1:50));
            FeaturesC10(i,:) = res(:);
        end
        if Features11
            h = proteinpropplot(sequence(1:50));
            FeaturesC11(i,:) = mean(h.Data);
        end
        % The en of the protein:
        ENDsequence = sequence(length(sequence)-50:end);
        if Features12
            FeaturesC12(i,1) = molweight(ENDsequence);
        end
        if Features13
            FeaturesC13(i,1) = isoelectric(ENDsequence);
        end
        if Features14
            AAstruct = aacount(ENDsequence);
            AAcell = struct2cell(AAstruct);
            FeaturesC14(i,:) = (cell2mat(AAcell))'/ length(ENDsequence);
        end
        if Features15
            res = AAassociation(ENDsequence);
            FeaturesC15(i,:) = res(:);
        end
        if Features16
            h = proteinpropplot(ENDsequence);
            FeaturesC16(i,:) = mean(h.Data);
        end
        
end

FeaturesC = [];
if Features1
    FeaturesC = [FeaturesC, FeaturesC1];
end
if Features2
    FeaturesC = [FeaturesC, FeaturesC2];
end
if Features3
    FeaturesC = [FeaturesC, FeaturesC3];
end
if Features4
    FeaturesC = [FeaturesC, FeaturesC4];
end
if Features5
    FeaturesC = [FeaturesC, FeaturesC5];
end
if Features6
    FeaturesC = [FeaturesC, FeaturesC6];
end
if Features7
    FeaturesC = [FeaturesC, FeaturesC7];
end
if Features8
    FeaturesC = [FeaturesC, FeaturesC8];
end
if Features9
    FeaturesC = [FeaturesC, FeaturesC9];
end
if Features10
    FeaturesC = [FeaturesC, FeaturesC10];
end
if Features11
    FeaturesC = [FeaturesC, FeaturesC11];
end
if Features12
    FeaturesC = [FeaturesC, FeaturesC12];
end
if Features13
    FeaturesC = [FeaturesC, FeaturesC13];
end
if Features14
    FeaturesC = [FeaturesC, FeaturesC14];
end
if Features15
    FeaturesC = [FeaturesC, FeaturesC15];
end
if Features16
    FeaturesC = [FeaturesC, FeaturesC16];
end
TestSet = FeaturesC;
% MTestSet = mean(TestSet);
% STDTestSet = std(TestSet);

clear FeaturesC1 FeaturesC2 FeaturesC3 FeaturesC4 FeaturesC5 FeaturesC6 FeaturesC7 ...
    FeaturesC8 FeaturesC9 FeaturesC10 FeaturesC11 FeaturesC12 FeaturesC14 ...
    FeaturesC15 FeaturesC16 Features1 Features2 Features3 Features4 Features5 ... 
    FeaturesC13 Features6 Features7 ...
    Features8 Features9 Features10 Features11 Features12 Features14 ...
    Features15 Features16 sequence ENDsequence Features13 FeaturesC i h res 
%%
load('Features');
MSet = mean(Set);
STDSet = std(Set);
Set = bsxfun(@minus, Set, MSet);
Set = bsxfun(@rdivide, Set, STDSet);

TestSet = bsxfun(@minus, TestSet, MSet);
TestSet = bsxfun(@rdivide, TestSet, STDSet);

% NUM = nnz(Labels == 2);
% 
% NewSet1 = Set(Labels==1,:);
% NewLabels1 = Labels(Labels == 1);
% NewSet2 = Set(Labels==2,:);
% NewLabels2 = Labels(Labels==2);
% NewSet3 = Set(Labels==3,:);
% NewLabels3 = Labels(Labels == 3);
% NewSet4 = Set(Labels==4,:);
% NewLabels4 = Labels(Labels==4);
% 
% Set = [NewSet1(1:NUM,:); NewSet2(1:NUM,:); NewSet3(1:NUM,:); NewSet4(1:NUM,:)];
% Labels = [NewLabels1(1:NUM); NewLabels2(1:NUM); NewLabels3(1:NUM); NewLabels4(1:NUM)];
clear MSet STDSet

%% training KNN

% One vs Two 
set1 = Set(Labels == 1,:);
set2 = Set(Labels == 2,:);
set = [set1; set2];

indx1 = Labels(Labels == 1);
indx2 = Labels(Labels == 2);
indx = [indx1; indx2];

mdl1 = fitcknn(set,indx,'NSMethod','exhaustive',...
    'Distance','seuclidean','BreakTies','nearest','IncludeTies',true);
mdl1.NumNeighbors = 3;


% One vs Three
set1 = Set(Labels == 1,:);
set2 = Set(Labels == 3,:);
set = [set1; set2];

indx1 = Labels(Labels == 1);
indx2 = Labels(Labels == 3);
indx = [indx1; indx2];

mdl2 = fitcknn(set,indx,'NSMethod','exhaustive',...
    'Distance','seuclidean','BreakTies','nearest','IncludeTies',true);
mdl2.NumNeighbors = 4;

% One vs Four
set1 = Set(Labels == 1,:);
set2 = Set(Labels == 4,:);
set = [set1; set2];

indx1 = Labels(Labels == 1);
indx2 = Labels(Labels == 4);
indx = [indx1; indx2];

mdl3 = fitcknn(set,indx,'NSMethod','exhaustive',...
    'Distance','seuclidean','BreakTies','nearest','IncludeTies',true);
mdl3.NumNeighbors = 5;

% Two vs Three
set1 = Set(Labels == 2,:);
set2 = Set(Labels == 3,:);
set = [set1; set2];

indx1 = Labels(Labels == 2);
indx2 = Labels(Labels == 3);
indx = [indx1; indx2];

mdl4 = fitcknn(set,indx,'NSMethod','exhaustive',...
    'Distance','seuclidean','BreakTies','nearest','IncludeTies',true);
mdl4.NumNeighbors = 3;

% Two vs Four
set1 = Set(Labels == 2,:);
set2 = Set(Labels == 4,:);
set = [set1; set2];

indx1 = Labels(Labels == 2);
indx2 = Labels(Labels == 4);
indx = [indx1; indx2];

mdl5 = fitcknn(set,indx,'NSMethod','exhaustive',...
    'Distance','seuclidean','BreakTies','nearest','IncludeTies',true);
mdl5.NumNeighbors = 3;

% Three vs Four
set1 = Set(Labels == 3,:);
set2 = Set(Labels == 4,:);
set = [set1; set2];

indx1 = Labels(Labels == 3);
indx2 = Labels(Labels == 4);
indx = [indx1; indx2];

mdl6 = fitcknn(set,indx,'NSMethod','exhaustive',...
    'Distance','seuclidean','BreakTies','nearest','IncludeTies',true);
mdl6.NumNeighbors = 3;

%% Training SVM


% One vs Two
set1 = Set(Labels == 1,:);
set2 = Set(Labels == 2,:);
set = [set1; set2];

indx1 = Labels(Labels == 1);
indx2 = Labels(Labels == 2);
indx = [indx1; indx2];
SVMModel1 = fitcsvm(set,indx,...
    'BoxConstraint',1,...
    'KernelScale','auto');
SVMModel1 = fitSVMPosterior(SVMModel1);

% One vs Three
set1 = Set(Labels == 1,:);
set2 = Set(Labels == 3,:);
set = [set1; set2];

indx1 = Labels(Labels == 1);
indx2 = Labels(Labels == 3);
indx = [indx1; indx2];
SVMModel2 = fitcsvm(set,indx,...
    'BoxConstraint',0.5,...
    'KernelScale','auto');
SVMModel2 = fitSVMPosterior(SVMModel2);

% One vs Four
set1 = Set(Labels == 1,:);
set2 = Set(Labels == 4,:);
set = [set1; set2];

indx1 = Labels(Labels == 1);
indx2 = Labels(Labels == 4);
indx = [indx1; indx2];
SVMModel3 = fitcsvm(set,indx,...
    'BoxConstraint',1,...
    'KernelScale','auto');
SVMModel3 = fitSVMPosterior(SVMModel3);

% Two vs three
set1 = Set(Labels == 2,:);
set2 = Set(Labels == 3,:);
set = [set1; set2];

indx1 = Labels(Labels == 2);
indx2 = Labels(Labels == 3);
indx = [indx1; indx2];

SVMModel4 = fitcsvm(set,indx,...
    'BoxConstraint',0.7,...
    'KernelScale','auto');
SVMModel4 = fitSVMPosterior(SVMModel4);

% Two vs Four
set1 = Set(Labels == 2,:);
set2 = Set(Labels == 4,:);
set = [set1; set2];

indx1 = Labels(Labels == 2);
indx2 = Labels(Labels == 4);
indx = [indx1; indx2];
SVMModel5 = fitcsvm(set,indx,...
    'BoxConstraint',1,...
    'KernelScale','auto');
SVMModel5 = fitSVMPosterior(SVMModel5);

% Three vs Four
set1 = Set(Labels == 3,:);
set2 = Set(Labels == 4,:);
set = [set1; set2];

indx1 = Labels(Labels == 3);
indx2 = Labels(Labels == 4);
indx = [indx1; indx2];
SVMModel6 = fitcsvm(set,indx,...
    'BoxConstraint',0.7,...
    'KernelScale','auto');
SVMModel6 = fitSVMPosterior(SVMModel6);

%% Testing

% KNN
[predKNN(:,1),score12] = predict(mdl1, TestSet);
%probKNN(:,1) = max(score12,[],2);
[predKNN(:,2), score13] = predict(mdl2, TestSet);
%probKNN(:,2) = max(score13,[],2);
[predKNN(:,3), score14] = predict(mdl3, TestSet);
%probKNN(:,3) = max(score14,[],2);
[predKNN(:,4), score23] = predict(mdl4, TestSet);
%probKNN(:,4) = max(score23,[],2);
[predKNN(:,5), score24] = predict(mdl5, TestSet);
%probKNN(:,5) = max(score24, [],2);
[predKNN(:,6), score34] = predict(mdl6, TestSet);
%probKNN(:,6) = max(score34, [], 2);

probKNN= [score12, score13, score14, score23, score24, score34];

% SVM
predSVM = [];
[predSVM(:,1), score12] = predict(SVMModel1,TestSet);
%probSVM(:,1) = max(score12, [],2);
[predSVM(:,2),score13] = predict(SVMModel2,TestSet);
%probSVM(:,2) = max(score13,[],2);
[predSVM(:,3),score14] = predict(SVMModel3,TestSet);
%probSVM(:,3) = max(score14,[],2);
[predSVM(:,4),score23] = predict(SVMModel4,TestSet);
%probSVM(:,4) = max(score23,[],2);
[predSVM(:,5),score24] = predict(SVMModel5,TestSet);
%probSVM(:,5) = max(score24,[],2);
[predSVM(:,6),score34] = predict(SVMModel6,TestSet);
%probSVM(:,6) = max(score34,[],2);

probSVM = [score12, score13, score14, score23, score24, score34];
%% printing results
probclass = [1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0;...
    0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0;...
    0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0;...
    0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1];

names = {'Cyto Conf', 'Extra Conf', 'Mito Conf','Nucl Conf'};


for i=1:size(probKNN,1)
    probKNN1 = mean(probKNN(i,logical(probclass(1,:))));
    probKNN2 = mean(probKNN(i,logical(probclass(2,:))));
    probKNN3 = mean(probKNN(i,logical(probclass(3,:))));
    probKNN4 = mean(probKNN(i,logical(probclass(4,:))));
    [MprobKNN(i), resKNN(i,1)] = max([probKNN1, probKNN2, probKNN3, probKNN4],[],2);
    
    probSVM1 = mean(probSVM(i,logical(probclass(1,:))));
    probSVM2 = mean(probSVM(i,logical(probclass(2,:))));
    probSVM3 = mean(probSVM(i,logical(probclass(3,:))));
    probSVM4 = mean(probSVM(i,logical(probclass(4,:))));
    [MprobSVM(i), resSVM(i,1)] = max([probSVM1, probSVM2, probSVM3, probSVM4],[],2);
    
    [probEnsemble(i), WHICH] = max([MprobKNN(i), MprobSVM(i)]);
    CHOICE = [resKNN(i), resSVM(i)];
    resEnsemble(i,1) = CHOICE(WHICH);
end

results = struct('KNN',[],'SVM',[],'Ensemble',[]);
for i=1:size(predSVM,1)
%     confKNN = mean(probKNN(i,logical(probclass(resKNN(i),:))));
%     confSVM = mean(probSVM(i,logical(probclass(resSVM(i),:))));
%     [confEnsemble, Select] = max([confKNN, confSVM]);
%     CHOICE = [resKNN(i), resSVM(i)];
%     resEnsemble(i) = CHOICE(Select);
    %confEnsemble = mean([confKNN, confSVM]);
    results(i).KNN = [TestSetstr(i).Header,' ' ,names{resKNN(i)}, ' ' ,num2str(MprobKNN(i)*100), '%'];
%     display('KNN')
%     disp(resultsKNN) ;
    
    results(i).SVM = [TestSetstr(i).Header,' ' ,names{resSVM(i)},' ' ,num2str(MprobSVM(i)*100),'%'];
%     display('SVM');
%     disp(resultsSVM);
    
    results(i).Ensemble = [TestSetstr(i).Header,' ' ,names{resEnsemble(i)},' ' ,num2str(probEnsemble(i)*100),'%'];
%     display('Ensemble');
%     disp(resultsEnsemble);
    
end

KNNtable = str2mat(results.KNN);
SVMtable = str2mat(results.SVM);
ENsembletable = str2mat(results.Ensemble);

