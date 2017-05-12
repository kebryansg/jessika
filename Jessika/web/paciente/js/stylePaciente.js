$(function () { 
    
    $("#contenido").on("changed.bs.select", "#cboProvincia", function (e) {
        change_cboProvincia(this);
    });

    $("#contenido").on("changed.bs.select", "#cboCanton", function (e) {
        change_cboCanton(this);
    });



    $("#contenido").on("change", "#pac_Genero", function (e) {
        change_Genero(this);
    });



    $("#contenido").on("click", "#btnAddPhoto", function () {
        $("#file_imagen").click();
    });
    $("#contenido").on("click", "#btnRemovePhoto", function () {
        $("#pac_imagen").attr("src", "resources/img/user.png");
    });
    $("#contenido").on("change", "#file_imagen", function (evt) {
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
                    $("#pac_imagen").attr("src", e.target.result);
                };
            })(f);
            // Read in the image file as a data URL.
            reader.readAsDataURL(f);
        }
    });

    $("#contenido").on("click", "#savePaciente", function () {
        var id = $(this).attr("data-id");
        $.getScript("paciente/js/paciente.js", function () {
            if (id === "0") {
                save();
            } else {
                editSave(id);
            }
        });
    });
    $("#contenido").on("click", "#cancelPaciente", function () {
        var id = pestañaActive();

        if (id === "0") {
            limpiarPaciente();
        } else {
            $(getCurrentTab()).find(".closeTab").click();
        }

    });
});

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
            var cboCanton = $("#cboCanton");
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
            var cboParroquia = $("#cboParroquia");
            $(cboParroquia).html(response);
            $(cboParroquia).selectpicker('refresh');
        }

    });
}

function change_Genero(cbo) {
    var tabObstetricia = $("#tabObstetricia");
    if ($(cbo).val() === "1" || $(cbo).val() === "0") {
        $(tabObstetricia).addClass("disabledTab");
    } else if ($(cbo).val() === "2") {
        $(tabObstetricia).removeClass("disabledTab");
    }
}

