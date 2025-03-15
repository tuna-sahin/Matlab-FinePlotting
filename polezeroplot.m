%poles and zeros should hold the respective numbers in complex form
%titlename is the title of the plot 
%variableName is the variable whose poles and zeros we are plotting
%size is in pixels 
%holdstate = 'on' is equivalent to "hold on"
function polezeroplot(poles,zeros,titlename,variableName,holdstate,size)
    maxx = max(max(real(zeros),max(real(poles))));
    minx = min(min(real(zeros),min(real(poles))));
    maxy = max(max(imag(zeros),max(imag(poles))));
    miny = min(min(imag(zeros),min(imag(poles))));

    Dx = maxx-minx;
    Dy = maxy-miny;
    dx = Dx/105;
    dy = Dy/85;
    dx = max(dx,dy);
    dy = max(dx,dy);
    hold on

    for i = poles
        plot(real(poles),imag(poles),'bx','DisplayName','poles');
    end

    for i = zeros
        plot(real(zeros),imag(zeros),'ro','DisplayName','zeros');
    end

    xlimits = [min((miny-10*dy),(minx-3*dx)) max((maxx+3*dx),(maxy+10*dy))];
    ylimits = [min((miny-10*dy),(minx-3*dx)) max((maxx+3*dx),(maxy+10*dy))];
    fineplot((0),(0),titlename,strcat('Re(',variableName,')'),strcat('Im(',variableName,')'),xlimits,ylimits,holdstate,size,'');
end
