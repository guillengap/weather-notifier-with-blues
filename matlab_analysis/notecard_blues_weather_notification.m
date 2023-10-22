% Enter your MATLAB Code below

channelID = 2295928;
%alert_body = 'Successful email with ThingSpeak';
alert_subject = 'What is the weather like today?';
alert_api_key = 'TAKasSlj8EwIBptu8PQ'; % insert your Alert API Key here 
alert_url = "https://api.thingspeak.com/alerts/send";

% Read the recent data.
temperatureData = thingSpeakRead(channelID,'NumDays',1,'Fields',1);
humidityData = thingSpeakRead(channelID,'NumDays',1,'Fields',2);

% Check to make sure the data was read correctly from the channel.
if (temperatureData > 27) & (humidityData < 70);
    alertBody = "It's gonna be a sunny day!";    
elseif (temperatureData < 27 & (humidityData > 70));
    alertBody = "It's gonna be a rainy day!";  
else 
    alertBody = "It's gonna be a unstable weather day!";      
end

jsonmessage = sprintf(['{"subject": "%s", "body": "%s"}'], alert_subject, alertBody);
options = weboptions("HeaderFields", {'Thingspeak-Alerts-API-Key', alert_api_key; 'Content-Type','application/json'});
result = webwrite(alert_url, jsonmessage, options); 