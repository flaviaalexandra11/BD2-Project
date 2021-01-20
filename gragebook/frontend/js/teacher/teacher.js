/**
 * Teacher Page Main Script. 
 */

$(document).ready(function() {

    // Teacher's userId.
    console.log(`signed in with id: ${localStorage.getItem('userId')}`);
    
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
            insertClasses(data["classes"]);
        })
        .fail(function (jqXHR, textStatus, errorThrown) { 
            alert("ERROR: get classes"); 
            console.log("ERROR: get classes"); console.log(errorThrown);
        });
    };
    getClasses(localStorage.getItem('userId'));

    // INSERT CLASSES IN PAGE (INSIDE THE CLASSES' TAB)
    var insertClasses = function(classes) {
        console.log("[insetClasses]");
        console.log(classes);
        var html = ``;
        classes.forEach(cls => {
            console.log(cls);
            var className = `Clasa a ${cls["year"]}-a ${cls["name"]}`;
            html += `<div class="col-md-3 col-sm-4 classroom-box existing-class-box" id="${cls["class_id"]}">`;
        
            html += `<div class="class-name">`;
            html += className;
            html += `</div>`;
        
            html += `</div>`;
        });
        $('div#classes-list').append(html);
    };

    // SHOW CLASSROOM DETAILS.
	$(document).on('click', '.classroom-box', function() {        
        // console.log(this.id);
        localStorage.setItem("classId", this.id);
        // console.log(localStorage.getItem("classId"));
        location.replace("detailed-class.html");
    });

    // Remove element from breadcrumb path.
    $(document).on('click', '.breadcrumb-item', function() {
        $(this).nextAll().remove();
        $('.students-table').remove();
    });
});

