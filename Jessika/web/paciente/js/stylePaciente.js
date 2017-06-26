
$(function () { 
    $('.form_date').datetimepicker('update', new Date());
    $('.form_date').datetimepicker('setEndDate', new Date());
    
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

    $("#contenido").on("click", "#savePaciente", function () {
        var id = $(this).attr("data-id");
        if (id === "0") {
                save();
            } else {
                editSave(id);
            }
    });
    
    $("#contenido").on("click", "#cancelPaciente", function () {
        var id = $("#savePaciente").attr("data-id");

        if (id === "0") {
            limpiarPaciente();
        } else {
            
            $("#contenido").load("paciente/listPacientes.jsp");
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

