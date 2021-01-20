/**
 * Teacher Detailed class. 
 */

$(document).ready(function() {
    
    console.log(`clicked on class id: ${localStorage.getItem('classId')}`);

    var getClasses = function(userId) {
        $.ajax({
            url: `${prefix}/class/${userId}`,
            type: 'GET',
            dataType: "json",
            contentType: "application/json; charset=utf-8",
        })
        .done(function (data) { 
            console.log("SUCCESS: get classes"); 
            console.log(data["classes"]);
            insertDetailedClass(data["classes"]);
        })
        .fail(function (jqXHR, textStatus, errorThrown) { 
            alert("ERROR: get classes"); 
            console.log("ERROR: get classes"); console.log(errorThrown);
        });
    };

    getClasses(localStorage.getItem('userId'));


    // INSERT CLASSES IN PAGE (INSIDE THE CLASSES' TAB)
    var insertDetailedClass = function(classes) {
        console.log("[insertDetailedClass]");
        console.log(classes);
        
        var classId = localStorage.getItem("classId");
        
        classes.forEach(cls => {
            if (cls["class_id"] == classId) {
                var className = `Clasa a ${cls["year"]}-a ${cls["name"]}`;

                // Add breadcrumb.
                var html = `<li class="breadcrumb-item active"><a href="#">${className}</a></li>`;
                $(".breadcrumb").append(html);


                // Add class details.
                html = `<p> <b> Specializarea: </b> ${cls["specialization_name"]} </p>`;

                var classMasterName = `${cls["master"]["first_name"]} ${cls["master"]["last_name"]}`;
                html += `<p> <b> Diriginte: </b> ${classMasterName} </p>`;
                html += `<ul>`;
                html += `<li> email: ${cls["master"]["email"]} </li>`;
                html += `<li> telefon: ${cls["master"]["phone_number"]} </li>`;
                html += `</ul>`;
                
                $("#nav-details").append(html);
            }
        });
    };

    var getGrades = function(userId, classId) {
        console.log("[getGrades]")
        $.ajax({
            url: `${prefix}/students/grades/${userId}&${classId}`,
            type: 'GET',
            dataType: "json",
            contentType: "application/json; charset=utf-8",
        })
        .done(function (data) { 
            console.log("SUCCESS: get grades"); 
            console.log(data);
            insertGrades(data["students"]);
        })
        .fail(function (jqXHR, textStatus, errorThrown) { 
            alert("ERROR: get grades"); 
            console.log("ERROR: get grades"); console.log(errorThrown);
        });
    };

    getGrades(localStorage.getItem('userId'), localStorage.getItem('classId'));

    var insertGrades = function(students) {
        console.log("[insertGrades]");
        console.log(students);
        
        html = ``;

        students.forEach(student => {
            console.log(student);
            var fullName = `${student["last_name"]} ${student["first_name"]}`;

            html += `<tr id="${student["user_id"]}">`;
            html += `<td class="name-cell"> ${fullName} </td>`;
            html += `<td class="grade-cell"> <b> ${student["mean"]} <b> </td>`;
            console.log(student["mean"]);
            var grades = student["grades"];

            var count = 0;
            grades.forEach(grade => {
                console.log
                html +=  `<td class="grade-cell"> ${grade["grade"]} </td>`;
                count += 1;
            });
            
            for (var i = 0; i < 7 - count; i++) {
                if (i == 0) {
                    html += `<td class="grade-cell" id="editable" contenteditable="true"></td>`;
                    continue;
                }
                html += `<td class="grade-cell" contenteditable="true"></td>`;
            }

            html += `<td class="grade-cell" contenteditable="true"></td>`;
        
            html += `<td>
                        <a class="save" title="save" data-toggle="tooltip"><i class="material-icons">&check;</i></a>
                    </td>`;

            html += `</tr>`;
        });
        
        $("tbody").append(html);
    };

    $(document).on('click', 'td a.save', function() {
		console.log('[save grade]');
        var teacherUserId = localStorage.getItem("userId");
        var classId = localStorage.getItem("classId");

        var studentUserId = $(this).parents('tr').attr('id');
        var score = $(this).parents('tr').children('#editable').text();
        
		var newGrade = {
            "user_id" : studentUserId,
            "examination_type" : "evaluare orala",
            "score" : score, 
            "student_feedback" : "student feedback",
            "parent_feedback" : "parent feedback"
        };

		console.log("newGrade: ");
		console.log(newGrade);

		$.ajax({
			url: `${prefix}/students/grades/${teacherUserId}&${classId}/add`,
			type: 'POST',
			headers: { 'Content-Type': 'application/json' },
			dataType: "json",
			contentType: "application/json; charset=utf-8",
			data: JSON.stringify(newGrade),
		})
		.done(function (data) { 
			alert("SUCCESS"); console.log("SUCCESS"); console.log(data);
			location.reload();
	 	})
		.fail(function (response) { 
			alert("ERROR"); console.log("ERROR"); 
			console.log(response);
		});
	});


    // SHOW CLASSROOM DETAILS.
	$(document).on('click', '.classroom-box', function() {        
        location.replace("detailed-class.html");
    });

    // Remove element from breadcrumb path.
    $(document).on('click', '.breadcrumb-item', function(){
        $(this).nextAll().remove();
        $('.students-table').remove();
    });
});

