function [ ] = moviemaker( u,plotting_points)
%Takes u, with rows t and columns x according to plotting_points, and plays
%the movie


%works for sg and int
dims = size(u);
F(dims(1)) = struct('cdata',[],'colormap',[]);

for j = 1:dims(1)
   try
       gasketgraph(plotting_points,u(j,:)');
       zlim([-10 10])
       %view([-100 5])
   catch
       plot(plotting_points,u(j,:)');
       ylim([-5 5])
   end

   F(j) = getframe;
   %frame = getframe(gcf);
   %writeVideo(v,frame);
end
movie(F,10,60)
%close(v);

end

