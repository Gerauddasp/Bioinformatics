function [model1, model2, model3, model4] = playground()
%addpath('/Users/gerauddaspremont/MathWorks/libsvm-3.17/matlab') % add path to LibSVM

load('features.mat') % import features Set and Labels

newLabels = zeros(length(Labels),4);
for i = 1 : length(Labels)
    newLabels(i,Labels(i)) = 1;
end
save('LabelsNN.mat','newLabels');

% Shuffle set
% Permutations = randperm(size(Set,1));
% Set = Set(Permutations,:);
% Labels = Labels(Permutations);

Set1 = Set(Labels == 1,:);
Labels1 = Labels(Labels == 1);

Set2 = Set(Labels == 2,:);
Labels2 = Labels(Labels == 2);

Set3 = Set(Labels == 3,:);
Labels3 = Labels(Labels == 3);

Set4 = Set(Labels == 4,:);
Labels4 = Labels(Labels==4);


size1 = 63;
size2 = 63;
size4 = 63;

Set = [Set1(1:size1,:) ; Set2(1:size2,:); Set3; Set4(1:size4,:)];
Labels = [Labels1(1:size1) ; Labels2(1:size2); Labels3; Labels4(1:size4)];

NewLabels = zeros(length(Labels),4);
for i =1:length(Labels)
    NewLabels(i, Labels(i)) = 1;
end

% Shuffle set
Permutations = randperm(size(Set,1));
Set = Set(Permutations,:);
Labels = Labels(Permutations);

c = repmat(2,1,21);
c = c .^(-5:1:15);
g = repmat(2,1,19);
g = g .^(-15:1:3);
param1 = ['-s 0 -c ',num2str(c(7)), ' -t 2 -g ', num2str(g(9)), ' -b 1 -q'];
param2 = ['-s 0 -c ',num2str(c(11)), ' -t 2 -g ', num2str(g(7)), ' -b 1 -q'];
param3 = ['-s 0 -c ',num2str(c(1)), ' -t 2 -g ', num2str(g(1)), ' -b 1 -q'];
param4 = ['-s 0 -c ',num2str(c(12)), ' -t 2 -g ', num2str(g(6)), ' -b 1 -q'];


model1 = svmtrain( double(Labels == 1), Set, param1);
model2 = svmtrain( double(Labels == 2), Set, param1);
model3 = svmtrain( double(Labels == 3), Set, param1);
model4 = svmtrain( double(Labels == 4), Set, param1);
end