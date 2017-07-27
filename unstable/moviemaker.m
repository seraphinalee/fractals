function [ ] = moviemaker( u,plotting_points)
%UNTITLED13 Summary of this function goes here
%   rows are ts
%   columns are x's corresponding to points
dims = size(u);
F(dims(1)) = struct('cdata',[],'colormap',[]);

for j = 1:dims(1)
   try
       gasketgraph(plotting_points,u(j,:)');
       zlim([-1 10])
   catch
       plot(plotting_points,u(j,:)');
       ylim([-1 5])
   end

   F(j) = getframe;
   %frame = getframe(gcf);
   %writeVideo(v,frame);
end
movie(F,10,60)
%close(v);

end

