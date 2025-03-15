%x,y are the variables to be plotted.
%titlename,xaxisname,yaxisname,legendname are the labels in their respective areas
%size is in pixels 
%holdstate = 'on' is equivalent to "hold on"
%xlimits and ylimits are xlim and ylim
%bodestate plots the complex valued array in a bode plot with its phase and magnitute
%style is the specifiying string for color linestyle etc. like 'k--' 
function plot_n = fineloglog(x,y,bodeState,titlename,xaxisname,yaxisname,xlimits,ylimits,holdstate,size,legendname,style)
    arguments
        x
        y
        bodeState = 'off'
        titlename string = ''
        xaxisname string = ''
        yaxisname string = ''
        xlimits (1,2) double = [min(x) max(x)]
        ylimits (1,2) double = [min(y) max(y)]
        holdstate string = 'off'
        size (1,2) double = [400 400];
        legendname string = ''
        style = 'k'
    end
    xlimits = 10.^xlimits;
    ylimits = 10.^ylimits;
    
    %even if the limits are reverse this section corrects the order
    if ylimits(1) > ylimits(2)
        ylimits = [ylimits(2) ylimits(1)];
    end
    if xlimits(1) > xlimits(2)
        xlimits = [xlimits(2) xlimits(1)];
    end

    if strcmp(bodeState,'on') || strcmp(bodeState,'On')
         loglog(x,abs(y^20),'DisplayName',strcat(legendname,'Magnitute'))
         hold on
         loglog(x,angle(y),'--','DisplayName','Phase')
    else
        loglog(x,y,style,'DisplayName','legendname')
    end
    title(titlename)
    xlabel(xaxisname)
    ylabel(yaxisname)
    xlim(xlimits)
    ylim(ylimits)

    %annotation(gcf,'arrow',[0.13 0.941666666666667],[0.11 0.111666666666667]);
    %annotation(gcf,'arrow',[0.130729166666667 0.130208333333333],[0.112347052280311 0.946607341490545]);
    
    xticks('auto')
    yticks('auto')  
    


    dx = 10^((log10(xlimits(2)) - log10(xlimits(1))) * 0.1 );
    dy = 10^((log10(ylimits(2)) - log10(ylimits(1))) * 0.1 );
    
    label_h1 = xlabel(xaxisname);
    label_h1.Position(1) = xlimits(2)*(dx); % change horizontal position of xlabel.
    label_h1.Position(2) = ylimits(1)*(dy); % change vertical position of xlabel.c5
    label_h2 = ylabel(yaxisname,rotation=0);
    label_h2.Position(1) = xlimits(1)*(dx); % change horizontal position of ylabel.
    label_h2.Position(2) = ylimits(2); % change vertical position of ylabel.

    

    set(get(gca,'XLabel'),'Visible','on')
    set(gca,'XAxisLocation','origin', 'box','off')
    set(gca,'YAxisLocation','origin')
    set(get(gca, 'XAxis'), 'FontWeight', 'bold')
    set(get(gca, 'YAxis'), 'FontWeight', 'bold');
    set(get(gca,'YLabel'),'Visible','on')
    set(gca,'Layer','top')
    set(gcf,'position',[(xlimits(2)-xlimits(1))/2 , (ylimits(2)-ylimits(1))/2 , size(1) , size(2)])

    
    set(get(gca,'title'),'Position', [sqrt(prod(xlimits)) ylimits(2)*(dy)]) %prevents the title from colliding with ylabel
    
    hold on
    plot_n = plot([1,10^20],[1 10^20]);

    dx = dx^(1/4);
    dy = dy^(1/4);
    plot([xlimits(2)/dx xlimits(2)],[ylimits(1)*dy ylimits(1)],'k')
    plot([xlimits(1)/dx xlimits(1) xlimits(1)*dx],[ylimits(2)/dy ylimits(2) ylimits(2)/dy],'k')

    if strcmp(holdstate,'off')
        hold off
    else 
        hold on
    end
end
