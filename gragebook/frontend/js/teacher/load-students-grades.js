
var getStudentsGrades = function(classId, subjectName, teacherUserId) {
    // console.log('[get-student-grades]');
	var neededData = {
        "classId" : classId,
        "subjectName" : subjectName,
        "teacherUserId": teacherUserId
    }
    // console.log("neededData: ");
    // console.log(neededData);

    $.ajax({
        url: `${prefix}/examination/students/all`,
        type: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(neededData),
    })
    .done(function (data) { 
        console.log("SUCCESS: get students grades");
        // console.log(data);
        var classId = localStorage.getItem('classId');
        // console.log(classId);
        insertStudentsGrades(data, classId, function() {
            console.log('[callback function]');
        });
        showStudentsTab();
        $('.save').hide();
    })
    .fail(function (response) { 
        alert("ERROR: get students grades"); console.log("ERROR: get students grades"); 
        console.log(response);
    });
};

var showStudentsTab = function() {
    console.log('[show student grades tab]');
    $('#nav-grades-tab').show();
    $('#nav-attendence-tab').show();
    $('#nav-appeal-tab').show();

    $('#nav-grades-tab').attr('aria-selected', true)
    $('#nav-classrooms-tab').attr('aria-selected', false)

    document.getElementById('nav-grades-tab').classList.add('active');
    document.getElementById('nav-grades-tab').classList.add('show');
    document.getElementById('nav-grades').classList.add('active');
    document.getElementById('nav-grades').classList.add('show');

    document.getElementById('nav-classrooms-tab').classList.remove('active');
    // document.getElementById('nav-classrooms-tab').classList.remove('show');
    document.getElementById('nav-classrooms').classList.remove('active');
    document.getElementById('nav-classrooms').classList.remove('show');
};

var addClassToBreadcrumb = function() {
    console.log('[add class to breadcrumb]');
    var classItem = `<li class="breadcrumb-item" id="class-breadcrumb"><a href="#"> ${localStorage.getItem('className')} </a></li>`;
    $('ol.breadcrumb').html(classItem);
};

var insertStudentsGrades = function(data, classId, _callback) {
    console.log('[insert students grades]');
    console.log("classId: "); console.log(classId);
    console.log(data);

    var className = data["className"];
    addClassToBreadcrumb(className);

    var studentsData = data['students grades'];
    var className = localStorage.getItem('className');
    var html = gradeTableSnippet1 + classId + gradeTableSnippet2;
    for (studIdx in studentsData) {
        var studentData = studentsData[studIdx];
        console.log(studentData);
        html += `<tr id=${studentData.studentUserId}>`;
        html+= `<td class="name-cell"> ${studentData.studentLastName} ${studentData.studentFirstName} </td>`;
        var grades = studentData.examinations;

        for (var gradeIdx = 0; gradeIdx < grades.length; gradeIdx++) {
            html += `<td class="grade-cell"> ${grades[gradeIdx].grade} </td>`;
        }
        html += `<td class="grade-cell" id="editable" contenteditable="true"></td>`;
        for (var cellIdx = 0; cellIdx < 9 - grades.length - 2; cellIdx++) {
            html += `<td class="grade-cell"></td>`;
        }
        html += `<td class="grade-cell">${gradeTableActions}</td>`;
        html += '</tr>';
    }
    html += gradeTableSnippet3;
    $(`div#students-grades`).html(html);
    // $('#nav-grades-tab').tab('show');    
    // $('#nav-grades-tab').trigger('click');
    console.log('[END OF INSERT STUDENTS]')
};