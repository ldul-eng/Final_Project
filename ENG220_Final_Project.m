%% Part 1 
T= readtable("Global Economy Indicators.csv", "VariableNamingRule","preserve");% imported table

for i= 1:width(T) % gives the parameters for the loop 
    if isnumeric(T{:,i}) % checks the columns for numeric values
        T{:,i}= fillmissing(T{:,i},'constant',0); % replaces all NaNs with zero in numeric columns
        end
end
writetable(T,'Global Economy Indicators(filled).csv'); % cleaned file

% statistics per numeric column
numeric_columns= T(:,varfun(@isnumeric,T,"OutputFormat","uniform")); % find all numeric columns
convert= table2array(numeric_columns); % chnage to cell array for calculations
columns= numeric_columns.Properties.VariableNames; % getting the column names for the table

count= sum(convert ~= 0); % counts all non-zeros in each column
meanValues= mean(convert); % the mean for each numeric column 
stdDev= std(convert); % the standard deviation for each numeric column 
minValues= min(convert); % the min for numeric columns 
medianValues= median(convert); % the median for numeric columns 
maxValues= max(convert); % the max for numeric columns
sumValues= sum(convert); % the sum for numeric columns

Table= table(columns', count', meanValues', stdDev', minValues', medianValues', maxValues', sumValues', ...
    'VariableNames', {'Name','Count', 'Mean', 'StdDev', 'Min', 'Median', 'Max', 'Sum'}); % creating the table
fprintf('<strong>The Statistics per column: </strong>\n') % title
disp(Table); % displaying it 

% statistics per country 
[G, countryNames]= findgroups(T.Country); % group all like countries together

Count= splitapply(@numel, convert, G); % The count for each country 
Mean= splitapply(@mean, convert, G); % mean for each country 
StdDev= splitapply(@std, convert, G); % the std dev for each country
Min= splitapply(@min, convert, G); % min for each country
Median= splitapply(@median, convert, G); % median for each country 
Max= splitapply(@max, convert, G); % max for each country 
Sum= splitapply(@sum, convert, G); % sum for each country 

   Table_countries= table(countryNames,Count, Mean, StdDev, Min, Median, Max, Sum); 
   fprintf('<strong>\nThe Statistics Per Country: </strong>\n\n') % title
   disp(Table_countries); % displaying it 
