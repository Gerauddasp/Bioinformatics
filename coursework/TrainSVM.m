%% Import data and initialise variables

clear all;
load('Features');

% Normalize datas
MSet = mean(Set);
STDSet = std(Set);
Set = bsxfun(@minus, Set, MSet);
Set = bsxfun(@rdivide, Set, STDSet);

% train models:
One = false;
Two = false;
Three = false;
Four = false;


%Shuffle set
Permutations = randperm(size(Set,1));
Set = Set(Permutations,:);
Labels = Labels(Permutations);

% create a small set
lengthclass = nnz(Labels == 3);
SmallSet = [];
SmallLabels = [];

for i=1:4
    prevSet = Set(Labels==i,:);
    SmallSet = [SmallSet; prevSet(1:lengthclass,:)];
    prevLabels = Labels(Labels == i);
    SmallLabels = [SmallLabels; prevLabels(1:lengthclass)];
end

% shuffle Small Set
Permutations = randperm(size(SmallSet,1));
SmallSet = SmallSet(Permutations,:);
SmallLabels = SmallLabels(Permutations);

%% training models

display('start SVM')
SVMModels = cell(4,1);
classes = unique(Labels);
rng(1); % For reproducibility

% model 1
if One == true
    display('training model 1')
    opts = optimset('TolX', 5e-10, 'TolFun', 5e-10);
    
   
    
    c = cvpartition(length(Labels),'KFold',5);
    indx = Labels == classes(1); % Create binary classes for each classifier
    minfn = @(z)kfoldLoss(fitcsvm(Set,indx,'CVPartition',c,...
        'Cost',[0 10;1 0],...
        'KernelFunction','rbf','BoxConstraint',exp(z(2)),...
        'KernelScale',exp(z(1))));
    m = 20;
    fval1 = zeros(m,1);
    z1 = zeros(m,2);
    
    for j=1:m
        fprintf('search number: %i\n',j);
        [searchmin, fval1(j),exitflag] = fminsearch(minfn, randn(2,1), opts);
        z1(j,:) = exp(searchmin);
        fprintf('exitflag: %i\n',exitflag);
    end
    
    z1 = z1(fval1 == min(fval1),:);
else 
    display('model One previous results');
    z1 = [2.7540, 0.3098];
end


% model 2
if Two == true
    display('train model 2');
    opts = optimset('TolX', 5e-10, 'TolFun', 5e-10);

    c = cvpartition(length(SmallLabels),'KFold',5);
    indx = SmallLabels == classes(2); % Create binary classes for each classifier
    minfn = @(z)kfoldLoss(fitcsvm(SmallSet,indx,'CVPartition',c,...
        'KernelFunction','rbf','BoxConstraint',exp(z(2)),...
        'KernelScale',exp(z(1))));
    m = 5;
    fval2 = zeros(m,1);
    z2 = zeros(m,2);
    
    for j=1:m
        fprintf('search number: %i\n',j);
        [searchmin, fval2(j),exitflag] = fminsearch(minfn, randn(2,1), opts);
        z2(j,:) = exp(searchmin);
        fprintf('exitflag: %i\n',exitflag);
    end
    
    z2 = z2(fval2 == min(fval2),:);
else 
    display('model Two previous results');
    z2 = [0.4390, 1.3936];
end

    
% model 3
if Three == true
    display('train model 3');
    opts = optimset('TolX', 5e-10, 'TolFun', 5e-10);

    c = cvpartition(length(SmallLabels),'KFold',5);
    indx = SmallLabels == classes(3); % Create binary classes for each classifier
    minfn = @(z)kfoldLoss(fitcsvm(SmallSet,indx,'CVPartition',c,...
        'KernelFunction','rbf','BoxConstraint',exp(z(2)),...
        'KernelScale',exp(z(1))));
    m = 5;
    fval3 = zeros(m,1);
    z3 = zeros(m,2);
    
    for j=1:m
        fprintf('search number: %i\n',j);
        [searchmin, fval3(j),exitflag] = fminsearch(minfn, randn(2,1), opts);
        z3(j,:) = exp(searchmin);
        fprintf('exitflag: %i\n',exitflag);
    end
    
    z3 = z3(fval3 == min(fval3),:);
else 
    display('model Three previous results');
    z3 = [1.0369, 0.3334];
end    
    
% model 4
if Four == true
    display('train model 4');
    opts = optimset('TolX', 5e-10, 'TolFun', 5e-10);

    c = cvpartition(length(Labels),'KFold',5);
    indx = Labels == classes(4); % Create binary classes for each classifier
    minfn = @(z)kfoldLoss(fitcsvm(Set,indx,'CVPartition',c,...
        'KernelFunction','rbf','BoxConstraint',exp(z(2)),...
        'KernelScale',exp(z(1))));
    m = 5;
    fval4 = zeros(m,1);
    z4 = zeros(m,2);
    
    for j=1:m
        fprintf('search number: %i\n',j);
        [searchmin, fval4(j),exitflag] = fminsearch(minfn, randn(2,1), opts);
        z4(j,:) = exp(searchmin);
        fprintf('exitflag: %i\n',exitflag);
    end
    
    z4 = z4(fval3 == min(fval3),:);
else 
    display('model Three previous results');
    z4 = [0.3585, 0.5407];
end  

%% Getting results
Indices = crossvalind('Kfold',length(Labels),5);

Trainsize = round( 0.65 * length(Labels) );

TrainSet = Set(1:Trainsize,:);
TrainLabels = Labels(1:Trainsize);

TestSet = Set(Trainsize+1:end,:);
TestLabels = Labels(Trainsize+1:end);

indx = SmallLabels == classes(1);
SVMModel1 = fitcsvm(SmallSet,indx,...
    'KernelFunction','rbf','BoxConstraint',exp(z1(2)),...
    'KernelScale',exp(z1(1)));
SVMModel1 = fitSVMPosterior(SVMModel1);
[~,scores1] = predict(SVMModel1,TestSet);

indx = SmallLabels == classes(2);
SVMModel2 = fitcsvm(SmallSet,indx,...
    'KernelFunction','rbf','BoxConstraint',exp(z2(2)),...
    'KernelScale',exp(z2(1)));
SVMModel2 = fitSVMPosterior(SVMModel2);
[~,scores2] = predict(SVMModel2,TestSet);

indx = SmallLabels == classes(3);
SVMModel3 = fitcsvm(SmallSet,indx,...
    'KernelFunction','rbf','BoxConstraint',exp(z3(2)),... %     'Cost',[0 10;1 0],...
    'KernelScale',exp(z3(1))); %     'OutlierFraction',0.9461,...
SVMModel3 = fitSVMPosterior(SVMModel3);
[~,scores3] = predict(SVMModel3,TestSet);

indx = SmallLabels == classes(4);
SVMModel4 = fitcsvm(SmallSet,indx,...
    'KernelFunction','rbf','BoxConstraint',exp(z4(2)),...
    'KernelScale',exp(z4(1)));
SVMModel4 = fitSVMPosterior(SVMModel4);
[~,scores4] = predict(SVMModel4,TestSet);

[proba ,predictions] = max([scores1(:,2), scores2(:,2), scores3(:,2), scores4(:,2)],[],2);

ConfMat = confusionmat(TestLabels, predictions)


[F1score, Accuracy] = Scores(ConfMat);


fprintf('Total Accuracy: %f\n', Accuracy *100);
fprintf('Total F1 score: %f\n', F1score * 100);


