%x,y are the variables to be plotted.
%titlename,xaxisname,yaxisname,legendname are the labels in their respective areas
%size is in pixels 
%holdstate = 'on' is equivalent to "hold on"
%xlimits and ylimits are xlim and ylim
%bodestate plots the complex valued array in a bode plot with its phase and magnitute
%style is the specifiying string for color linestyle etc. like 'k--' 
function plot_n = finesemilogx(x,y,bodestate,titlename,xaxisname,yaxisname,xlimits,ylimits,holdstate,size,legendname,style)
    arguments
        x
        y
        bodestate string = ''
        titlename string = ''
        xaxisname string = ''
        yaxisname string = ''
        xlimits (1,2) double = [min(y) max(y)]
        ylimits (1,2) double = [min(y) max(y)]
        holdstate string = 'off'
        size (1,2) double = [400 400];
        legendname string = ''
        style = 'k--'
    end

    if (bodestate == 'on') | (bodestate == 'On')
         semilogx(x,abs(y^20),'DisplayName',strcat(legendname,'Magnitute'))
         hold on
         semilogx(x,angle(y),'--','DisplayName','Phase')
    else
        semilogx(x,y,style,'DisplayName','legendname')
    end

    %even if the limits are reverse this section corrects the order
    if ylimits(1) > ylimits(2)
        ylimits = [ylimits(2) ylimits(1)];
    end
    if xlimits(1) > xlimits(2)
        xlimits = [xlimits(2) xlimits(1)];
    end
    xlimits = [10^xlimits(1) 10^xlimits(2)];
    
    %these measures are necessary for positioning arrows, labels etc. 
    dx = 10^((log10(xlimits(2)) - log10(xlimits(1))) * 0.1 );
    dy = ((ylimits(2)-ylimits(1))/85);

    %this section is to not plot values that overlap with the arrows
    lowindex = 1;
    highindex = length(x);
    for i = x   
        if (i > (xlimits(1) + dx)) & (lowindex == 1)
            lowindex = find(x==i);
        end
        if (i > xlimits(2) - dx) & (highindex == 1)
            highindex = find(x==i)-1;
        end
    end
    if x(lowindex) > 0 %we allow points to be drawn at the origin
        lowindex = lowindex - 1;
    end
    
    if x(highindex) < 0 %we allow points to be drawn at the origin
        highindex = highindex + 1;
    end

    
    x = x(lowindex:highindex);
    y = y(lowindex:highindex);

    %this section is responsible for axis configuration
    plot_n = plot(x,y);
    xlim(xlimits)
    ylim(ylimits)
    set(get(gca,'XLabel'),'Visible','on')
    set(gca,'XAxisLocation','origin', 'box','off')
    set(gca,'YAxisLocation','origin')
    set(get(gca, 'XAxis'), 'FontWeight', 'bold')
    set(get(gca, 'YAxis'), 'FontWeight', 'bold');
    set(get(gca,'YLabel'),'Visible','on')
    set(gca,'Layer','top')
    set(gcf,'position',[(xlimits(2)-xlimits(1))/2 , (ylimits(2)-ylimits(1))/2 , size(1) , size(2)])
    
    %deletes the ticks that overlap with arrows
    xticks('auto');
    xt = xticks;
    xticks(xt(2:length(xt)-1));
    yticks('auto');
    yt = yticks;
    yticks(yt(2:length(yt)-1));
    
    % determining the ylevel to draw the arrows on the x axis
    if ((ylimits(1) * ylimits(2)) < 0) 
        xal = 0;
    elseif ylimits(1) < 0
        xal = ylimits(2);
    else
        xal = ylimits(1);
    end

    %plotting the arrows
    hold on
    if xlimits(2) > 0
        plot([(xlimits(2)*1.4/dx) xlimits(2) (xlimits(2)*1.4/dx)],[xal+dy xal xal-dy],'k') %xaxis right arrow 
    end
    
    plot([0 0],[ylimits(2) ylimits(1)],'k')% y axis
    if ylimits(2) > 0 
        xlimits(1)*4/dx
        ylimits(2)
        dy
        [xlimits(1)*2/dx xlimits(1) xlimits(1)/dx]
        [ylimits(2)-dy ylimits(2) ylimits(2)-dy]
        plot([xlimits(1)*2.15/dx xlimits(1) xlimits(1)/dx],[ylimits(2)-dy ylimits(2) ylimits(2)-dy],'k') %yaxis top arrow 
    end
    if ylimits(1) < 0
        plot([xlimits(1)*2.15/dx xlimits(1) xlimits(1)/dx],[ylimits(1)+dy ylimits(1) ylimits(1)+dy],'k') %yaxis bottom arrow 
    end
    
    %repositioning title & label locations
    label_h1 = xlabel(xaxisname);
    label_h1.Position(1) = xlimits(2)*dx; % change horizontal position of xlabel.
    label_h1.Position(2) = log10(dy); % change vertical position of xlabel.c5
    label_h2 = ylabel(yaxisname,rotation=0);
    label_h2.Position(1) = log10(dx)/3; % change horizontal position of ylabel.
    label_h2.Position(2) = ylimits(2)+dy; % change vertical position of ylabel.
    title(titlename);
    if ((xlimits(1) * xlimits(2)) < 0) & (xlimits(1)+xlimits(2) < ((xlimits(2)-xlimits(1))/3))
        set(get(gca,'title'),'Position', [20*dx ylimits(2)-dy]) %prevents the title from colliding with ylabel
    end

    %holds or doesnt hold
    if strcmp(holdstate,'off')
        hold off
    else 
        hold on
    end
end