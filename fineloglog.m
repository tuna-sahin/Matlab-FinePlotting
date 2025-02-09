function fineloglog(omega,H,titlename,xaxisname,yaxisname,xlimits,ylimits,holdstate,size) 
    H = 20*log10(abs(H));
    omega = log10(omega);
    %even if the limits are reverse this section corrects the order
    if ylimits(1) > ylimits(2)
        ylimits = [ylimits(2) ylimits(1)];
    end
    if xlimits(1) > xlimits(2)
        xlimits = [xlimits(2) xlimits(1)];
    end

    %these measures are necessary for positioning arrows, labels etc. 
    dx = ((xlimits(2)-xlimits(1))/65);
    dy = ((ylimits(2)-ylimits(1))/85);

    %this section is to not plot values that overlap with the arrows
    lowindex = 1;
    highindex = length(omega);
    for i = omega   
        if (i > xlimits(1) + dx) && (lowindex == 1)
            lowindex = find(omega==i);
        end
        if (i > xlimits(2) - dx) && (highindex == 1)
            highindex = find(omega==i)-1;
        end
    end
    if omega(lowindex) > 0 %we allow points to be drawn at the origin
        lowindex = lowindex - 1;
    end
    
    if omega(highindex) < 0 %we allow points to be drawn at the origin
        highindex = highindex + 1;
    end
    
    omega = omega(lowindex:highindex);
    H = H(lowindex:highindex);

    %this section is responsible for axis configuration
    plot(omega,H)
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
    
    %logarithmic ticks for y axis
    interval = ylimits;
    basis = (logspace(0,log10(11),11)-1)/10;
    basis = basis(2:end);
    temp = [floor(interval(1)) floor(interval(2))];
    temp3 = [];
    for i = temp(1):temp(2)
        if i < 0 
            temp4 = flip((2*u(i)-1)*basis + (i+1-u(i)));
        else
            temp4 = (2*u(i)-1)*basis + (i+1-u(i));
        end
        temp3 = [temp3 temp4];
    end
    yticks_arr = [];
    for i = temp3
        if (i >= interval(1)) && (i <= interval(2))
            yticks_arr = [yticks_arr i];
        end
    end
    
    yticks_arr=single(yticks_arr);
    yticks_nam = {};
    for i = yticks_arr
        if floor(i) == i
            yticks_nam = [yticks_nam, strcat('10^{',int2str(i),'}')];
        else
            yticks_nam = [yticks_nam, ' '];
        end
    end    
    
    if length(yticks_nam) > 100
        yticks_nam2 = {};
        yticks_arr2 = [];
        j = 1;
        for i = yticks_nam
            if num2str(cell2mat((i))) == ' '
                
            else
                yticks_nam2 = [yticks_nam2,i];
                yticks_arr2 = [yticks_arr2 yticks_arr(j)];
            end
            j = j + 1;
        end
        yticks_arr = yticks_arr2;
        yticks_nam = yticks_nam2;
    end
    
    %adds the logarithmic ticks deletes the ticks that overlap with arrows
    set(gca,'YTick',yticks_arr,'YTickLabel',yticks_nam)
    yt = yticks;
    yticks(yt(2:length(yt)-1));

    %logarithmic ticks for x axis
    interval = ylimits;
    basis = (logspace(0,log10(11),11)-1)/10;
    basis = basis(2:end);
    temp = [floor(interval(1)) floor(interval(2))];
    temp3 = [];
    for i = temp(1):temp(2)
        if i < 0 
            temp4 = flip((2*u(i)-1)*basis + (i+1-u(i)));
        else
            temp4 = (2*u(i)-1)*basis + (i+1-u(i));
        end
        temp3 = [temp3 temp4];
    end
    xticks_arr = [];
    for i = temp3
        if (i >= interval(1)) && (i <= interval(2))
            xticks_arr = [xticks_arr i];
        end
    end
    
    xticks_arr=single(xticks_arr);
    xticks_nam = {};
    for i = xticks_arr
        if floor(i) == i
            xticks_nam = [xticks_nam, strcat('10^{',int2str(i),'}')];
        else
            xticks_nam = [xticks_nam, ' '];
        end
    end
    
    if length(xticks_nam) > 100
        xticks_nam2 = {};
        xticks_arr2 = [];
        j = 1;
        for i = xticks_nam
            if num2str(cell2mat((i))) == ' '
                
            else
                xticks_nam2 = [xticks_nam2,i];
                xticks_arr2 = [xticks_arr2 xticks_arr(j)];
            end
            j = j + 1;
        end
        xticks_arr = xticks_arr2;
        xticks_nam = xticks_nam2;
    end  
    
    %adds the logarithmic ticks deletes the ticks that overlap with arrows
    set(gca,'XTick',xticks_arr,'XTickLabel',xticks_nam)
    xt = xticks;
    xticks(xt(2:length(xt)-1));    
    xtickangle(0)
    
    % determining the ylevel to draw the arrows on the x axis
    if ((ylimits(1) * ylimits(2)) < 0) 
        xal = 0;
    elseif ylimits(1) < 0
        xal = ylimits(2);
    else
        xal = ylimits(1);
    end
    
    % determining the xlevel to draw the arrows on the y axis
    if ((xlimits(1) * xlimits(2)) < 0) 
        yal = 0;
    elseif max(xlimits) < 0
        yal = xlimits(2);
    else
        yal = xlimits(1);
    end

    %plotting the arrows
    hold on
    if xlimits(2) > 0
        plot([(xlimits(2)-dx) xlimits(2) (xlimits(2)-dx)],[xal+dy xal xal-dy],'k') %xaxis right arrow 
    end
    if xlimits(1) < 0
        plot([xlimits(1)+dx xlimits(1) xlimits(1)+dx],[xal+dy xal xal-dy],'k') %xaxis left arrow 
    end 
    plot([0 0],[ylimits(2) ylimits(1)],'k')% y axis
    if ylimits(2) > 0 
        plot([yal-dx/2 yal yal+dx/2],[ylimits(2)-dy ylimits(2) ylimits(2)-dy],'k') %yaxis top arrow 
    end
    if ylimits(1) < 0
        plot([yal-dx/2 yal  yal+dx/2],[ylimits(1)+dy ylimits(1) ylimits(1)+dy],'k') %yaxis bottom arrow 
    end
    
    %repositioning title & label locations
    label_h1 = xlabel(xaxisname);
    label_h1.Position(1) = xlimits(2)+dx; % change horizontal position of xlabel.
    label_h1.Position(2) = dy; % change vertical position of xlabel.c5
    label_h2 = ylabel(yaxisname,rotation=0);
    label_h2.Position(1) = dx; % change horizontal position of ylabel.
    label_h2.Position(2) = ylimits(2)+dy; % change vertical position of ylabel.
    title(titlename);
    if ((xlimits(1) * xlimits(2)) < 0) && (xlimits(1)+xlimits(2) < ((xlimits(2)-xlimits(1))/3))
        set(get(gca,'title'),'Position', [20*dx ylimits(2)-dy]) %prevents the title from colliding with ylabel
    end

    %holds or doesnt hold
    if strcmp(holdstate,'off')
        hold off
    else 
        hold on
    end
end