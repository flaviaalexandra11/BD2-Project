$(document).ready(function() {

    $(document).on('click', '#editable', function() {
        console.log('[clicked editable cell]');
        var classId = $(this).parents('.table-responsive').attr('id');
        console.log(`classId: ${classId}`);
        var studentUserId = $(this).parents('tr').attr('id');
        console.log(`studentUserId: ${studentUserId}`);
        $(`tr#${studentUserId} td a.more`).hide();
        $(`tr#${studentUserId} td a.save`).show();
    })

	// SAVE CHANGES 
	$(document).on('click', 'td a.save', function() {
		console.log('[save grade]');
		
        // $(this).parent('td').children('a.edit').hide();
        
        var studentUserId = $(this).parents('tr').attr('id');
        var subjectName = $('h3').text();
        var teacherUserId = localStorage.getItem('userId');
        var score = $(this).parents('tr').children('#editable').text();
        // console.log(score);
		
		var newGrade = {
			"examinationId" : "-1",
            "studentUserId" : studentUserId,
            "subjectName" : subjectName.toLowerCase(),
            "teacherUserId": teacherUserId,
            "score" : score, 
            "date" : "2020-01-01",
            "examinationTypeName" : "nespecificat", 
            "studentFeedback" : "", 
            "parentFeedback" : ""
        };

		console.log("newGrade: ");
		console.log(newGrade);

		$.ajax({
			url: `${prefix}/examination/student/add`,
			type: 'POST',
			headers: {
				'Content-Type': 'application/json'
				// 'Access-Control-Allow-Origin': '*' 
			},
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

		$(this).hide();
		$(this).parent('td').children('a.more').show();
	});
});
