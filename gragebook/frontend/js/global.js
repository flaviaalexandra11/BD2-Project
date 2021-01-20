var prefix = `http://localhost:8080`
var userId = 0;
var classesLetters = 'ABCD';
// var classes;
var classId;
var classYear;
var teachers;

var isFormValid = function() {
    var isValid = true;
    $('input').each(function() {
        var inputClass = $(this).attr('class');
        var inputValue = $(this)[0].value;
        // console.log('[' + inputValue + ']');

        if(inputValue == undefined || inputValue == null ||  inputValue == '') {
            inputClass += ' invalid';
            $(this).attr('class', inputClass);
            isValid = false;
        } else if (inputClass.includes('invalid')) {
            inputClass = inputClass.replace('invalid', '');
            console.log(inputClass);
            $(this).attr('class', inputClass);
        }
    });

    $('textarea').each(function() {
        var texatreaClass = $(this).attr('class');
        var textareaValue = $(this)[0].value;

        if(textareaValue == undefined || textareaValue == null ||  textareaValue == '') {
            texatreaClass += ' invalid';
            $(this).attr('class', texatreaClass);
            isValid = false;
        } else if (texatreaClass.includes(' invalid')) {
            texatreaClass.replace(' invalid', '');
        }
    });
    return isValid;
}

var isTableFormValid = function() {
    var isValid = true;
    $('input').each(function() {
        var inputClass = $(this).attr('class');
        var inputValue = $(this)[0].value;
        // console.log('[' + inputValue + ']');

        if(inputValue == undefined || inputValue == null ||  inputValue == '') {
            inputClass += ' invalid';
            $(this).attr('class', inputClass);
            isValid = false;
        } else if (inputClass.includes('invalid')) {
            inputClass = inputClass.replace('invalid', '');
            console.log(inputClass);
            $(this).attr('class', inputClass);
        }
    });
    return isValid;
}