function [label] = predicts(net,videoFrame)
    [cropped_frame,~,~] = cropface(videoFrame);
    cropped_frame = imresize(cropped_frame,[227 227]);
    prediction = classify(net, cropped_frame);
    label = prediction;
end

