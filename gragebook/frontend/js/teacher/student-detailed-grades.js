
var getStudentDetailedGrades = function(studentId, subjectName, teacherUserId) {
    // console.log('[get student detailed grades]');
    var requestData = {
        "studentUserId" : studentId, 
        "subjectName" : subjectName.toLowerCase(),
        "teacherUserId" : teacherUserId
    };
    // console.log('requestData: '); console.log(requestData);
    $.ajax({
        url: `${prefix}/examination/student/get`,
        type: 'POST',
        headers: {
            'Content-Type': 'application/json'
            // 'Access-Control-Allow-Origin': '*' 
        },
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(requestData),
    })
    .done(function (data) { 
        console.log("SUCCESS: get student detailed grades."); console.log(data);
        insertStudentDetailedGrades(data, function() {
            // this call back function IS NOT WORKING
            console.log('HERE');
            $('td a.save-grade').hide();
        });
     })
    .fail(function (response) { 
        alert("ERROR: get student detailed grades."); 
        console.log("ERROR: get student detailed grades."); 
        console.log(response);
    });
};

var addStudNameToBreadCrumb = function(lastName, firstName) {
    console.log('[add student to breadcrumb]');
    // console.log(`${lastName} ${firstName}`);
    var classItem = `<li class="breadcrumb-item" id="stud-breadcrumb"><a href="#"> ${lastName} ${firstName} </a></li>`;
    $('ol.breadcrumb').append(classItem);
    console.log('[end of student breadcrumb]')
};

var insertStudentDetailedGrades = function(data, _callback) {
    console.log('[insert student detailed grades]');
    var details = data['student grades'];

    addStudNameToBreadCrumb(details.studentLastName, details.studentFirstName);

    var examinations = details.examinations;
    // console.log(details.studentUserId);
    localStorage.setItem("studentUserId", details.studentUserId);

    var html = detailedGradeSnippet1 + details['studentUserId'] + detailedGradeSnippet2;
    for (examIdx in examinations) {
        var examination = examinations[examIdx];
        // console.log(examination);
        html += `<tr id="${examination.examinationId}">`;
        html += `<td class="short-data" id="examination-type-cell">${examination.examinationType}</td>`;
        html += `<td class="short-data">${examination.date}</td>`;
        html += `<td class="short-data">${examination.grade}</td>`;
        html += `<td class="feedback">${examination.studentFeedback}</td>`;
        html += `<td class="feedback">${examination.parentFeedback}</td>`;
        html += `<td class="short-data">${detailedGradeActions}</td>`;
        html += `</tr>`;
    }
    html += detailedGradeSnippet3;

    $('#student-detailed-grades').html(html);
    $('td a.save-grade').hide();
    console.log('[end of insert detailed grades]')
};