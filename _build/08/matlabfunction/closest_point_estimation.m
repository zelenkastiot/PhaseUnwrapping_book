function fieldmap1ext = closest_point_estimation(fieldmap0,mask0)

%% preparation

hdr.N_hor = size(mask0,1);
hdr.N_ver = size(mask0,2);

fieldmap0 = fieldmap0.*mask0;
% figure(1); clf; hold off; imagesc(fieldmap0);aeo; colormap(gray); 
% disp('choose ROI for fitting the field map');
% [a] = roipoly;
% fieldmap1 = fieldmap0.*a;
% imagesc(fieldmap1);aeo; colormap(gray);
% mask1 = (mask0 & a);
mask1 = double(mask0);

%% find the closest point
mask1e = edge(mask1);
mask1e(1,:)=0;
mask1e(end,:)=0;
mask1e(:,1)=0;
mask1e(:,end)=0;
[mask1eindex_x,mask1eindex_y] = find(mask1e); 
mask1eL = length(mask1eindex_x);

fieldmap1ext = fieldmap0;
for cnty = 1: hdr.N_ver
 for cntx = 1: hdr.N_hor
   if (mask1(cntx,cnty) == 0)
     distance = (mask1eindex_x-cntx).^2 + (mask1eindex_y-cnty).^2;
     distance_minindex = find(distance == min(distance(:)));
     distance_minindex = distance_minindex(1);
     targetx = mask1eindex_x(distance_minindex);
     targety = mask1eindex_y(distance_minindex);
     targetxx = targetx + targetx - cntx;
     targetyy = targety + targety - cnty;
     if (((targetxx)<(hdr.N_hor+1)) & ((targetyy)<(hdr.N_ver+1)) & ((targetxx)>0) & ((targetyy)>0))
       fieldmap1ext(cntx,cnty) = fieldmap0(targetxx,targetyy);
     end
   end
 end
end
for cnt001 = 1:mask1eL
 if (fieldmap1ext(mask1eindex_x(cnt001),mask1eindex_y(cnt001)) == 0)
   fieldmap1ext(mask1eindex_x(cnt001),mask1eindex_y(cnt001)) =  (fieldmap1ext(mask1eindex_x(cnt001)+1,mask1eindex_y(cnt001)) +  fieldmap1ext(mask1eindex_x(cnt001)-1,mask1eindex_y(cnt001)) + fieldmap1ext(mask1eindex_x(cnt001),mask1eindex_y(cnt001)+1) + fieldmap1ext(mask1eindex_x(cnt001),mask1eindex_y(cnt001)-1))/4 ; 
 end
end



return
