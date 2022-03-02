var options =
    '[{"key": "Excellent", "value": "Excellent"},{"key": "Good","value":"Good"},{"key":"Bad", "value":"Bad"},  {"key":"Poor", "value":"Poor"}]';
var yes_no = '[{"key": "Yes","value":"Yes"},{"key": "No","value":"No"}]';
var present_no = '''[
  '{"key": "Present","value":"Present"},'
  '{"key": "Absent","value":"Absent"}'
]''';

var dataFields = '['
    '{"label":"Pharmacist Present","type":"radio","value":"", "key":"pharmacist_present","required":true,'
    '"options":$yes_no},'
    '{"label":"Layout","type":"radio","value":"", "key":"layout","required":true,'
    '"options":$options},'
    '{"label":"Storage","type":"radio","value":"", "key":"storage","required":true,'
    '"options":$options},'
    '{"label":"Hygiene","type":"radio","value":"", "key":"hygiene","required":true,'
    '"options":$options},'
    '{"label":"State of Repair","type":"radio","value":"", "key":"state_of_repair","required":true,'
    '"options":$options},'
    '{"label":"Ventilation","type":"radio","value":"", "key":"ventilation","required":true,'
    '"options":$options},'
    '{"label":"Arrangement","type":"radio","value":"", "key":"arrangement","required":true,'
    '"options":$options},'
    '{"label":"Floors","type":"radio","value":"", "key":"floors","required":true,'
    '"options":$options},'
    '{"label":"Drug Security","type":"radio","value":"", "key":"drug_security","required":true,'
    '"options":$options},'
    '{"label":"Dangerous Drugs Records Book","type":"radio","value":"", "key":"ddr","required":true,'
    '"options":$options},'
    '{"label":"Medicine Intervention Book","type":"radio","value":"", "key":"intervention_book","required":true,'
    '"options":$options},'
    '{"label":"Software","type":"radio","value":"", "key":"software","required":true,'
    '"options":$options},'
    '{"label":"Remarks","type":"multiline","value":"", "key":"remarks","required":true,'
    '"options":$options}'
    ']';
