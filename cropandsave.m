function  cropandsave(ds,str)
dest = string(strcat('croppedfaces\',str));
mkdir(dest);
j = 1;
T = countEachLabel(ds);
n = T(1,2).Variables;
for i = 1:n
    i1 = readimage(ds,i);
    [img,face] = cropface(i1);
    if face==1
        imwrite(img,string('croppedfaces\'+ str+'\'+int2str(j)+'.jpg'));
        j = j+1;
    end
end
