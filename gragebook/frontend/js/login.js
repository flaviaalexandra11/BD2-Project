$(document).ready(function(){
    // console.log("Hello from login.js!");

    var getLoginInfo = function() {
        console.log("[getLoginInfo]")
        var username = $("#usernameInput").val();
        var password = $("#passwordInput").val();

        if (usernameInput == null || passwordInput == null) { return null; }
        data = {
            "username" : username,
            "password" : password
        };
        return data;
    }

    $("#login-btn").on('click' , function(event) {
        event.preventDefault();
        myData = getLoginInfo();
        console.log(myData);
        if (myData === null) { return; }
        
        $.ajax({
            url: `${prefix}/login`,
            type: 'POST',
            headers: { 'Content-Type': 'application/json' },
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(myData),
        })
        .done(function (data) { 
            alert("SUCCESS: login"); console.log("SUCCESS: login"); 
            console.log(data); 
            localStorage.setItem("userId", data["result"]);
            location.replace("teacher.html");
        })
        .fail(function (jqXHR, textStatus, errorThrown) { 
            alert("ERROR: login"); 
            console.log("ERROR: login"); console.log(errorThrown);
        });
    }); 
});

