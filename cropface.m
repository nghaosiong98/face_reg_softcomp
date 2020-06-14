function [J,face,bbox] = cropface(img)
    [bbox, ~, ~] = mtcnn.detectFaces(img, 'UseGPU', true);
    if ~isempty(bbox)
        for i=1:size(bbox,1)
        J=imcrop(img,bbox(i,:));
        end
        face = 1;
    else
        J = img;
        face = 0;
    end
end