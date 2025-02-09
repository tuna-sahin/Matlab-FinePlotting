function polezeroplot(poles,zeros,titlename,variableName,holdstate,size)
    maxx = max(real([zeros poles]));
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
        plot([(real(i)-dx) (real(i)+dx)],[(imag(i)-dy) (imag(i)+dy)],'blue')
        plot([(real(i)+dx) (real(i)-dx)],[(imag(i)-dy) (imag(i)+dy)],'blue')
    end
    for i = zeros
        t = linspace(0,2*pi,20);
        zx = cos(t)*dx + real(i);
        zy = sin(t)*dy + imag(i);
        plot(zx,zy,'red')
    end
    xlimits = [min((miny-10*dy),(minx-3*dx)) max((maxx+3*dx),(maxy+10*dy))];
    ylimits = [min((miny-10*dy),(minx-3*dx)) max((maxx+3*dx),(maxy+10*dy))];
    fineplot((0),(0),titlename,strcat('Re(',variableName,')'),strcat('Im(',variableName,')'),xlimits,ylimits,holdstate,size)
end
