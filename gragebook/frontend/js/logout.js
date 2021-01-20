$(document).ready(function() {

    $("#logout").click(function() {
        userId = localStorage.getItem("userId");
        $.ajax({
            url: `${prefix}/logout/${userId}`,
            type: 'GET',
            dataType: "json",
            contentType: "application/json; charset=utf-8",
        })
        .done(function (data) { 
            console.log("SUCCESS: logout");
            location.replace("index.html");
        })
        .fail(function (jqXHR, textStatus, errorThrown) { 
            alert("ERROR: logout"); 
            console.log("ERROR: logout"); console.log(errorThrown);
        });
    });
});

