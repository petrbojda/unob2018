function varargout = scatterplot(x, n, offset, plotstring, h)
%SCATTERPLOT Generate a scatter plot.
%
%   SCATTERPLOT(X) generates a scatter plot of X.  X can be a real or complex
%   vector, or a two-column matrix with real signal in the first column and
%   imaginary signal in the second column.
%
%   SCATTERPLOT(X, N) generates a scatter plot of X with decimation factor N.
%   Every Nth point in X is plotted, starting with the first value.  The default
%   for N is 1.
%
%   SCATTERPLOT(X, N, OFFSET) generates a scatter plot of X with an offset.
%   OFFSET is the number of samples skipped at the beginning of X before
%   plotting.  The default value for OFFSET is zero.
%
%   SCATTERPLOT(X, N, OFFSET, PLOTSTRING) generates a scatter plot of X in the
%   line types, plot symbols and colors described by PLOTSTRING.  PLOTSTRING
%   can be any of the strings used in the PLOT function.  The default value for
%   PLOTSTRING is 'b.'.
%
%   H = SCATTERPLOT(...) generates a scatter plot and returns handle to the   
%   figure used to generate the scatter plot.
%
%   H = SCATTERPLOT(X, N, OFFSET, PLOTSTRING, H) and
%   SCATTERPLOT(X, N, OFFSET, PLOTSTRING, H) generate scatter plots using the
%   figure indicated by the handle, H.  H must be a valid handle to a figure
%   that was previously generated by SCATTERPLOT.  Default for H is [], which
%   causes SCATTERPLOT to create a new figure.
%
%   See also EYEDIAGRAM, PLOT, SCATTEREYEDEMO, SCATTER.

%   Copyright 1996-2008 The MathWorks, Inc.
%   $Revision: 1.7.4.7 $ $Date: 2009/01/05 17:45:12 $

error(nargchk(1,5,nargin,'struct'));
error(nargoutchk(0,1,nargout,'struct'));
if nargin<2 || isempty(n)
    n = 1;
end;
if nargin<3 || isempty(offset)
    offset = 0;
end;

if nargin<4 || isempty(plotstring)
    plotstring = 'b.';
end;

if nargin < 5
    h = [];
end;

[r, c] = size(x);
if r * c == 0
    error('comm:scatterplot:InvalidX','Input variable X is empty.')
end;
if r == 1
    x = x(:);
end;

% don't allow N to be noninteger or less than or equal zero
if ((fix(n) ~= n) || (n <= 0))
    error('comm:scatterplot:InvalidN','N must be a positive integer.')
end

% don't allow offset to be noninteger or less than or equal zero
if ((fix(offset) ~= offset) || (offset < 0))
    error('comm:scatterplot:InvalidOffset','OFFSET must be a nonnegative integer.')
end

% increment offset to create index into x
offset = offset + 1;

isRealX = isreal(x);
if ~isRealX
    x = [real(x), imag(x)];
end;

yy = x(offset : n : size(x, 1), :);
maxAll = max(max(abs(yy)));

% Create new figure or reuse figure handle from a previously created scatter plot
strName = 'Scatter Plot';
if(~isempty(h))
    % is this a valid figure handle
    if(~ishghandle(h,'figure'))
        warning('comm:scatterplot:invalidHandle', ...
                'Ignoring invalid handle, H. Creating a new scatter plot.')
        h = figure('visible','off');
        axis([-eps eps -eps eps]);
    else
        % check if tag was created by scatter plot
        if(~strcmp(get(h,'Tag'),strName))
            error('comm:scatterplot:NonExistingScatterPlot',...
                  ['Figure is not an existing scatter plot.\n', ...
                  'Use an existing scatter plot or do not use a figure ', ...
                  'handle as an input']);
        end
        h = figure(h);
        if(~ishold)
            axis([-eps eps -eps eps]);
        end
    end
else
    h = figure('visible','off');
    axis([-eps eps -eps eps]);
end

% figure and axes creation setup constants
pos = get(h,'position');
sz = min(pos(3), pos(4));
set(h,'Position',[pos(1) pos(2) sz sz], ...
      'Name',strName, ...
      'Tag',strName, ...
      'DoubleBuffer','on', ...
      'visible','on');
axo = axis;

% plot the scatter plot
[len_yy, wid_yy]=size(yy);
if wid_yy == 1
    % real data only
    plot(yy, zeros(1,len_yy), plotstring);
elseif wid_yy == 2
    %complex data only
    plot(yy(:,1), yy(:,2), plotstring);
elseif isRealX
    error('comm:scatterplot:InvalidRealInput','A real input must be a vector or a two-column matrix.');
else
    error('comm:scatterplot:InvalidComplexInput','A complex input must be a vector.');
end
if(~ishold)
    set(h,'nextplot','replacechildren');
end

% Adjust the limits
limFact = 1.07;
limits = max(max(abs(axo)),maxAll*limFact);
axis equal;
axis([-limits limits -limits limits]);

% Label the plot
ylabel('Quadrature')
xlabel('In-Phase')
title('Scatter plot')

if(nargout == 1)
    varargout(1) = {h};
end
