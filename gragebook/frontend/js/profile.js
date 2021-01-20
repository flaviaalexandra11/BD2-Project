$(document).ready(function() {

    var getProfile = function(userId) {
        $.ajax({
            url: `${prefix}/profile/teacher/${userId}`,
            type: 'GET',
            dataType: "json",
            contentType: "application/json; charset=utf-8",
        })
        .done(function (data) { 
            console.log("SUCCESS: get profile"); 
            console.log(data);
            insertProfile(data);
            
        })
        .fail(function (jqXHR, textStatus, errorThrown) { 
            alert("ERROR: get profile"); 
            console.log("ERROR: get profile"); console.log(errorThrown);
        });
    };
    getProfile(localStorage.getItem('userId'));

    var insertProfile = function(data) {
        console.log("[insertProfile]");
        $("input#firstName").val(data["first_name"]);
        $("input#lastName").val(data["last_name"]);
        $("input#email").val(data["email"]);
        $("input#phoneNumber").val(data["phone_number"]);
    };

    var postUpdatedData = function(data, _callback) {
        console.log("[postUpdatedData]");
        console.log(data);
        var userId = localStorage.getItem('userId');

        $.ajax({
			url: `${prefix}/profile/teacher/${userId}/update`,
			type: 'POST',
            headers: { 'Content-Type': 'application/json'
            ,  'Access-Control-Allow-Origin': '*'  
            , "Access-Control-Allow-Methods": "POST, GET, OPTIONS, DELETE"
            },
			dataType: "json",
			contentType: "application/json; charset=utf-8",
			data: JSON.stringify(data),
		})
		.done(function (data) { 
            alert("SUCCESS"); 
            console.log("SUCCESS: update profile"); 
            setTimeout(2000);
			// location.reload();
	 	})
		.fail(function (response) { 
            alert("ERROR: update profile"); 
            console.log("ERROR: update profile"); 
			console.log(response);
		});
    };
    
    $("button#update-btn").click(function () {
        console.log("[clicked actualizeaza]");
        var userId = localStorage.getItem('userId');
        data = {
            "first_name" : $("input#firstName").val(),
            "last_name" : $("input#lastName").val(),
            "user_id" : userId,
            "email" : $("input#email").val(),
            "phone_number" : $("input#phoneNumber").val()
        };
        setTimeout(() => console.log("sleep"), 1000);

        postUpdatedData(data, function() {
			location.reload();
        });
    });
});

