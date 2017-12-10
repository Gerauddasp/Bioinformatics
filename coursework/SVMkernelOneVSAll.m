clear all, close all;
%addpath('/Users/gerauddaspremont/MathWorks/libsvm-3.17/matlab') % add path to LibSVM

load('features.mat') % import features Set and Labels
%model3 = Trainmodel3();
%[model1, model2, model3, model4] = playground();
%Shuffle set
Permutations = randperm(size(Set,1));
Set = Set(Permutations,:);
Labels = Labels(Permutations);


MSet = mean(Set);
STDSet = std(Set);
Set = bsxfun(@minus, Set, MSet);
Set = bsxfun(@rdivide, Set, STDSet);


c = repmat(2,1,21);
c = c .^(-5:1:15);
g = repmat(2,1,19);
g = g .^(-15:1:3);

Indices = crossvalind('Kfold', size(Set,1),5);
testparam = '-b 1 -q';
% count = 0;
% for i=1:length(c)
%     for j=1:length(g)
        tic
%         count= count + 1;
%         fprintf('\niteration %i / %i\n', count, length(c)*length(g));
%         fprintf('C is equal to %f | G is equal to %f\n', c(i), g(j));
%         param = ['-s 0 -c ',num2str(c(i)), ' -t 2 -g ', num2str(g(j)), ' -b 1 -q'];
param1 = ['-s 0 -c ',num2str(c(7)), ' -t 2 -g ', num2str(g(9)), ' -b 1 -q'];
param2 = ['-s 0 -c ',num2str(c(11)), ' -t 2 -g ', num2str(g(7)), ' -b 1 -q'];
param3 = ['-s 0 -c ',num2str(c(1)), ' -t 2 -g ', num2str(g(1)), ' -b 1 -q'];
param4 = ['-s 0 -c ',num2str(c(12)), ' -t 2 -g ', num2str(g(6)), ' -b 1 -q'];
        for k=1:5
            % for model 1
            L1 = double( Labels == 1);
            %model1 = svmtrain( L1(Indices ~= k), Set(Indices ~= k,:), param1);
            [~,~,p1] = svmpredict( L1(Indices == k) , Set(Indices == k,:),model1, testparam);
            if model1.Label(1) == 1
                p1 = p1(:,[2, 1]);
            end
            [~, prediction1] = max(p1 , [], 2);
            prediction1 = prediction1 - 1;
            confm1 = confusionmat(L1(Indices == k), prediction1,'order',[1,0]);
            
            F11(k) = (2*confm1(1,1)) / (2*confm1(1,1) + confm1(2,1) + confm1(1,2));
            Acc1(k) = sum(diag(confm1))/ sum(sum(confm1));
            
            % for model 2
            L2 = double( Labels == 2);
            %model2 = svmtrain( L2(Indices ~= k), Set(Indices ~= k,:), param2);
            [~,~,p2] = svmpredict( L2(Indices == k) , Set(Indices == k,:),model2, testparam);
            if model2.Label(1) == 1
                p2 = p2(:,[2, 1]);
            end
            [~, prediction2] = max(p2 , [], 2);
            prediction2 = prediction2 - 1;
            confm2 = confusionmat(L2(Indices == k), prediction2,'order',[1,0]);
            
            F12(k) = (2*confm2(1,1)) / (2*confm2(1,1) + confm2(2,1) + confm2(1,2));
            Acc2(k) = sum(diag(confm2))/ sum(sum(confm2));
            
            % for model 3
            L3 = double( Labels == 3);
            %model3 = svmtrain( L3(Indices ~= k), Set(Indices ~= k,:), param3);
            [~,~,p3] = svmpredict( L3(Indices == k) , Set(Indices == k,:),model3, testparam);
            if model3.Label(1) == 1
                p3 = p3(:,[2, 1]);
            end
            [~, prediction3] = max(p3 , [], 2);
            prediction3 = prediction3 - 1;
            confm3 = confusionmat(L3(Indices == k), prediction3,'order',[1,0]);
            
            F13(k) = (2*confm3(1,1)) / (2*confm3(1,1) + confm3(2,1) + confm3(1,2));
            Acc3(k) = sum(diag(confm3))/ sum(sum(confm3));
            
            % for model 4
            L4 = double( Labels == 4);
            %model4 = svmtrain( L4(Indices ~= k), Set(Indices ~= k,:), param4);
            [~,~,p4] = svmpredict( L4(Indices == k) , Set(Indices == k,:),model4, testparam);
            if model4.Label(1) == 1
                p4 = p4(:,[2, 1]);
            end
            [~, prediction4] = max(p4 , [], 2);
            prediction4 = prediction4 - 1;
            confm4 = confusionmat(L4(Indices == k), prediction4,'order',[1,0]);
            
            F14(k) = (2*confm4(1,1)) / (2*confm4(1,1) + confm4(2,1) + confm4(1,2));
            Acc4(k) = sum(diag(confm4))/ sum(sum(confm4));
            
            
            % test for overall prediction:
            Allpred = [p1(:,2), p2(:,2), p3(:,2), p4(:,2)];
            [~, res] = max(Allpred,[],2);
            
            confmAll(:,:,k) = confusionmat(Labels(Indices == k), res,'order',[1,2,3,4]);
            
            F1All(k) = (2*sum(diag(confmAll(:,:,k)))) / ( (2*sum(diag(confmAll(:,:,k)))) + sum(sum(triu(confmAll(:,:,k)))) + sum(sum(tril(confmAll(:,:,k)))) );
            AccAll(k) = sum(diag(confmAll(:,:,k))) / sum(sum(confmAll(:,:,k)));
            
            
        end
        confmAll = mean(confmAll,3);



[F1score, Accuracy] = Scores(confmAll);


fprintf('Total Accuracy: %f\n', Accuracy *100);
fprintf('Total F1 score: %f\n', F1score * 100);
        

        toc
%     end
% end

