function pestañaActive() {
    var pestaña = $(getCurrentTab()).attr("href");
    var id = $(pestaña + " #optionPaciente").attr("data-id");
    return id;
}

function pestañaDiv() {
    var pestaña = $(getCurrentTab()).attr("href");
    var div = $(pestaña + " #optionPaciente");
    return div;
}
function change_cboProvincia(cbo) {
    $.ajax({
        type: 'Post',
        url: 'pruebaCombo',
        async: false,
        data: {
            id: $(cbo).val(),
            op: 'cantones'
        },
        success: function (response) {
            var cboCanton = $(pestañaDiv()).find("#cboCanton");
            $(cboCanton).html(response);
            $(cboCanton).selectpicker('refresh');
        }
    });
}

function change_cboCanton(cbo) {
    $.ajax({
        type: 'Post',
        url: 'pruebaCombo',
        async: false,
        data: {
            id: $(cbo).val(),
            op: 'parroquias'
        },
        success: function (response) {
            var cboParroquia = $(pestañaDiv()).find("#cboParroquia");
            $(cboParroquia).html(response);
            $(cboParroquia).selectpicker('refresh');
        }

    });
}

$("#ContentAdm").on("changed.bs.select", "#cboProvincia", function (e) {
    change_cboProvincia(this);
});

$("#ContentAdm").on("changed.bs.select", "#cboCanton", function (e) {
    change_cboCanton(this);
});

function change_Genero(cbo) {
    var tabObstetricia = $(pestañaDiv()).find("#tabObstetricia");
    if ($(cbo).val() === "1" || $(cbo).val() === "0") {
        $(tabObstetricia).addClass("disabledTab");
    } else if ($(cbo).val() === "2") {
        $(tabObstetricia).removeClass("disabledTab");
    }
}

$("#ContentAdm").on("change", "#pac_Genero", function (e) {
    change_Genero(this);
});



$("#ContentAdm").on("click", "#btnAddPhoto", function () {
    $(pestañaDiv()).find("#file_imagen").click();
});
$("#ContentAdm").on("click", "#btnRemovePhoto", function () {
    $(pestañaDiv()).find("#pac_imagen").attr("src", "resources/img/user.png");
});
$("#ContentAdm").on("change", "#file_imagen", function (evt) {
    var files = evt.target.files; // FileList object

    // Loop through the FileList and render image files as thumbnails.
    for (var i = 0, f; f = files[i]; i++) {
        // Only process image files.
        if (!f.type.match('image.*')) {
            continue;
        }

        var reader = new FileReader();
        // Closure to capture the file information.
        reader.onload = (function (theFile) {
            return function (e) {
                $(pestañaDiv()).find("#pac_imagen").attr("src", e.target.result);
            };
        })(f);
        // Read in the image file as a data URL.
        reader.readAsDataURL(f);
    }
});

$("#ContentAdm").on("click", "#savePaciente", function () {
    var id = $(this).attr("data-id");
    $.getScript("paciente/js/paciente.js", function () {
        if (id === "0") {
            save();
        } else {
            editSave(id);
        }
    });
});
$("#ContentAdm").on("click", "#cancelPaciente", function () {
    var id = pestañaActive();
    
    if(id === "0"){
        limpiarPaciente();
    }
    else{
      $(getCurrentTab()).find(".closeTab").click();  
    }
    
});