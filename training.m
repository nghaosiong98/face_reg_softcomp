%% Start training
subjects = dir(fullfile('croppedfaces', '*'));
subjects = {subjects.name};
subjects(ismember(subjects, {'.', '..'})) = []; % remove . and ..
n = size(subjects);
n = n(1,2);

im = imageDatastore('croppedfaces','IncludeSubfolders',true,'LabelSource','foldernames');
% Resize the images to the input size of the net
im.ReadFcn = @(loc)imresize(imread(loc),[227,227]);
[Train ,Test] = splitEachLabel(im,0.8,'randomized');

fc = fullyConnectedLayer(n);
net = alexnet;
ly = net.Layers;
ly(23) = fc;
cl = classificationLayer;
ly(25) = cl; 

% options for training the net if your newnet performance is low decrease
% the learning_rate
learning_rate = 0.00001;
opts = trainingOptions("rmsprop","InitialLearnRate",learning_rate,'MaxEpochs',10,'MiniBatchSize',64,'Plots','training-progress','ExecutionEnvironment','gpu');
[newnet,info] = trainNetwork(Train, ly, opts);
[predict,scores] = classify(newnet,Test);
names = Test.Labels;
pred = (predict==names);
s = size(pred);
acc = sum(pred)/s(1);
fprintf('The accuracy of the test set is %f %% \n',acc*100);
 



