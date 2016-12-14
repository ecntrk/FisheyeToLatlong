
inPath = '/Users/ecntrk/Documents/ILFlightprobes/superCleanProbes/';
[s a b] = mkdir(inPath, 'latlong');
if s == 0;
    disp(a);
    %return;
end;
opPath = strcat(inPath, 'latlong/');

parfor i = 1:2500

    filename = sprintf('%05d.pfm',i);  
    op = grilledFish(strcat(inPath, filename));
    %op = imresize(op, 0.1);
    filename = sprintf('%05d.hdr',i);
    hdrwrite(op, strcat(opPath, filename));
end


