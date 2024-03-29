
/**
 * Add special validation rules.
 */
function simmedAddCommonValidationRules(objectType, id)
{
    Validation.addAllThese([
        ['validate-nospace', Zikula.__('No spaces', 'module_SimpleMedia'), function(val, elem) {
            val = new String(val);
            return (val.indexOf(' ') == -1);
        }],
        ['validate-htmlcolour', Zikula.__('Please select a valid html colour code.', 'module_SimpleMedia'), function(val, elem) {
            val = new String(val);
            return Validation.get('IsEmpty').test(val) || (/^#[0-9a-f]{3}([0-9a-f]{3})?$/i.test(val));
        }],
        ['validate-datetime-past', Zikula.__('Please select a value in the past.', 'module_SimpleMedia'), function(val, elem) {
            val = new String(val);
            var cmpVal = simmedReadDate(val, true);
            return Validation.get('IsEmpty').test(val) || (cmpVal < simmedToday('datetime'));
        }],
        ['validate-datetime-future', Zikula.__('Please select a value in the future.', 'module_SimpleMedia'), function(val, elem) {
            val = new String(val);
            var cmpVal = simmedReadDate(val, true);
            return Validation.get('IsEmpty').test(val) || (cmpVal >= simmedToday('datetime'));
        }],
        ['validate-date-past', Zikula.__('Please select a value in the past.', 'module_SimpleMedia'), function(val, elem) {
            val = new String(val);
            var cmpVal = simmedReadDate(val, false);
            return Validation.get('IsEmpty').test(val) || (cmpVal < simmedToday('date'));
        }],
        ['validate-date-future', Zikula.__('Please select a value in the future.', 'module_SimpleMedia'), function(val, elem) {
            val = new String(val);
            var cmpVal = simmedReadDate(val, false);
            return Validation.get('IsEmpty').test(val) || (cmpVal >= simmedToday('date'));
        }],
        ['validate-time-past', Zikula.__('Please select a value in the past.', 'module_SimpleMedia'), function(val, elem) {
            var cmpVal = new String(val);
            return Validation.get('IsEmpty').test(val) || (cmpVal < simmedToday('time'));
        }],
        ['validate-time-future', Zikula.__('Please select a value in the future.', 'module_SimpleMedia'), function(val, elem) {
            var cmpVal = new String(val);
            return Validation.get('IsEmpty').test(val) || (cmpVal >= simmedToday('time'));
        }]
    ]);
}

function simmedToday(format)
{
    var timestamp = new Date();
    var todayDate = '';
    if (format != 'time') {
        var month = new String((parseInt(timestamp.getMonth())+1));
        if (month.length == 1) month = '0' + month;
        var day = new String(timestamp.getDate());
        if (day.length == 1) day = '0' + day;
        todayDate += timestamp.getFullYear() + '-' + month + '-' + day;
    }
    if (format == 'datetime') {
        todayDate += ' ';
    }
    if (format != 'date') {
        var hours = new String(timestamp.getHours());
        if (hours.length == 1) hours = '0' + hours;
        var minutes = new String(timestamp.getMinutes());
        if (minutes.length == 1) day = '0' + day;
        var seconds = new String(timestamp.getSeconds());
        if (seconds.length == 1) day = '0' + day;
        todayDate += hours + ':' + minutes;// + ':' + seconds;
    }
    return todayDate;
}

// returns YYYY-MM-DD even if date is in DD.MM.YYYY
function simmedReadDate(val, includeTime)
{
    // look if we have YYYY-MM-DD
    if (val.substr(4, 1) == '-' && val.substr(7, 1) == '-') {
        return val;
    }

    // look if we have DD.MM.YYYY
    if (val.substr(2, 1) == '.' && val.substr(4, 1) == '.') {
        var newVal = val.substr(6, 4) + '-' + val.substr(3, 2) + '-' + val.substr(0, 2)
        if (includeTime == true) {
            newVal += ' ' + val.substr(11, 5);
        }
        return newVal;
    }
}

