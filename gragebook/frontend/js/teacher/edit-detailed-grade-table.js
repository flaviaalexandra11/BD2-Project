$(document).ready(function() {

	//  DELETING GRADE
	$(document).on("click", 'td a.delete-grade', function() {
		console.log("[delete clicked]");
		var examinationId = $(this).parents("tr").attr('id');
        console.log(examinationId);
        
		$(this).parents("tr").remove();
		$.ajax({
			url: `${prefix}/examinations/delete/${examinationId}`,
			type: 'DELETE',
			success: function(data) {
				console.log(data);
			}
		});
		// location.reload();
	});
	
	// EDIT GRADE
	$(document).on("click", 'td a.edit-grade', function() {
		$(this).parents(".table-responsive").children('.table-title').children('.add-new-stud') .attr('disabled', 'disabled');

		var inputIds = ["examinationType", "examinationDate", "examinationGrade", "studentFeedback", "parentFeedback", ""];
        var idx = 0;

        $(this).parents("tr").find("td:not(:last-child)").each(function() {
            // if (inputIds[idx] == "examinationDate") {
            //     $(this).html('<input type="date" class="form-control" id="' + inputIds[idx] + '" value="' + $(this).text() + '">');
            // } else 
            if (inputIds[idx] != "examinationType") {
				$(this).html('<input type="text" class="form-control" id="' + inputIds[idx] + '" value="' + $(this).text() + '">');
			} else {
                $.ajax({
                    url: `${prefix}/examination-types/all`,
                    type: 'GET',
                    dataType: "json",
                    contentType: "application/json; charset=utf-8"
                })
                .done(function (data) { 
                    console.log("SUCCESS: get examination types");
                    console.log(data.examinationTypes);
          
                    var html = '<select class="form-control" id="examinationType">';
                    for (examTypeIdx in data.examinationTypes) {
                        html += `<option>${data.examinationTypes[examTypeIdx]}</option>`;
                    }
                    html += '</select>';
                    $(`input`).parents(`tr`).children(`td#examination-type-cell`).html(html);
                })
                .fail(function (jqXHR, textStatus, errorThrown) { 
                    alert("ERROR: get examination types"); console.log("ERROR: get examination types");
                });
			}
			idx += 1;
		});

		$(this).parents("tr").find('td a.save-grade').show();
		$(this).parents("tr").find('td a.edit-grade').hide();
	});

	// SAVE CHANGES 
	$(document).on('click', 'td a.save-grade', function() {
		console.log('[save-grade]');

		if(!isTableFormValid()) return;

        var teacherUserId = localStorage.getItem("userId");
        var studentUserId = localStorage.getItem("studentUserId");
        var subjectName = localStorage.getItem("subjectName");

        var examinationId = $(this).parents('tr').attr('id');
		var examinationType = document.querySelector('#examinationType').value;
		var examinationDate = document.querySelector('#examinationDate').value;
		var examinationGrade = document.querySelector('#examinationGrade').value;
		var studentFeedback = document.querySelector('#studentFeedback').value;
		var parentFeedback = document.querySelector('#parentFeedback').value;

        console.log(`examinationId: ${examinationId}`);
        console.log(`examinationDate: ${examinationDate }`);

		$(this).parent('td').children('a.edit-grade').hide();		
		
		var grade = {
            "examinationId" : examinationId, 
            "studentUserId" : studentUserId,
            "subjectName" : subjectName,
            "teacherUserId" : teacherUserId, 
            "examinationTypeName" : examinationType,
            "score" : examinationGrade,
            "date" : examinationDate, 
            "studentFeedback" : studentFeedback, 
            "parentFeedback" : parentFeedback
		};

		console.log("grade: ");
		console.log(grade);

		$.ajax({
			url: `${prefix}/examination/student/add`,
			type: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			dataType: "json",
			contentType: "application/json; charset=utf-8",
			data: JSON.stringify(grade),
		})
		.done(function (data) { 
			console.log("SUCCESS: add / edit grade from detailed table"); console.log(data);
			location.reload();
	 	})
		.fail(function (response) { 
			alert("ERROR"); console.log("ERROR: add / edit grade from detailed table"); 
			console.log(response);
		});

        localStorage.setItem("studentUserId", "");
		$(this).hide();
		$(this).parent('td').children('a.edit-grade').show();		
		$('button.add-new-grade').removeAttr("disabled");
	});
	
	// ADD NEW STUDENT
	$(document).on("click", 'button.add-new-grade', function() {
		console.log("[add new grade]");
        $(this).attr("disabled", "disabled");

        $.ajax({
            url: `${prefix}/examination-types/all`,
            type: 'GET',
            dataType: "json",
            contentType: "application/json; charset=utf-8"
        })
        .done(function (data) { 
            console.log("SUCCESS: get examination types");
            console.log(data.examinationTypes);
  
            var row = '<tr id="-1">'; 
            row += '<td><select class="form-control" id="examinationType">';
            for (examTypeIdx in data.examinationTypes) {
                row += `<option>${data.examinationTypes[examTypeIdx]}</option>`;
            }
            row += '</select></td>';
            row += '<td><input type="text" class="form-control" name="examinationDate" id="examinationDate" placeholder="aaaa-ll-zz"></td>';
            row += '<td><input type="text" class="form-control" name="examinationGrade" id="examinationGrade" placeholder="nota"></td>';
            row += '<td><input type="text" class="form-control" name="studentFeedback" id="studentFeedback" placeholder="feedback pentru elev"></td>';
            row += '<td><input type="text" class="form-control" name="parentFeedback" id="parentFeedback" placeholder="feedback pentru parinte"></td>';
            row += '<td>' + detailedGradeActions + '</td>';
            row += '</tr>';
            $(".table-responsive table tbody tr:last-child").after(row);
		    $('tr:last-child td a.edit-grade').hide();
        })
        .fail(function (jqXHR, textStatus, errorThrown) { 
            alert("ERROR: get examination types"); console.log("ERROR: get examination types");
        });
	});

});
