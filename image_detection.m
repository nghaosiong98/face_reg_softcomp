test_ds = imageDatastore('test_img\');
test_ds.ReadFcn = @(loc)imresize(imread(loc),[227 227]);
faceDetector = mtcnn.Detector('UseGPU',true);
test_paths = test_ds.Files;

for idx=1:length(test_ds.Files)
    img = imread(test_paths{idx});
    [copped_img,~,bbox] = cropface(img);
    bboxPoints = bbox2points(bbox(1, :));
    bboxPolygon = reshape(bboxPoints', 1, []);
    img = insertShape(img, 'Polygon', bboxPolygon, 'LineWidth', 3);
    % Predicts frame
    label = predicts(newnet, copped_img);
    % Display name here.
    img = insertText(img,bboxPoints(1,:),string(label));
    imshow(img, 'InitialMagnification', 150);
end