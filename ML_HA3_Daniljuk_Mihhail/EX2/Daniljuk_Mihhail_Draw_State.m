function Daniljuk_Mihhail_Draw_State(neuronGridFlat,size_of_grid,DS,vv, t)    

    neuronGridX = reshape(neuronGridFlat(:,1),[size_of_grid,size_of_grid]);
    neuronGridY = reshape(neuronGridFlat(:,2),[size_of_grid,size_of_grid]);
    neuronGridZ = reshape(neuronGridFlat(:,3),[size_of_grid,size_of_grid]);


    figure(1)
    plot3(DS(:,1), DS(:,2), DS(:,3),'.b')
    hold on
    plot3(neuronGridX, neuronGridY, neuronGridZ,'or')
    surf(neuronGridX, neuronGridY, neuronGridZ,'FaceColor','interp',...
        'EdgeColor','k',...
        'FaceLighting','phong','linewidth',2)
    axis square
    view(vv,35)
    vv=vv+1;
    camlight left
    hold off
    grid on
    title(['t=' num2str(t)])
    drawnow
end