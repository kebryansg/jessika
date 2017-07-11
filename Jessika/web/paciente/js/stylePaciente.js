
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

    $("#savePaciente").click(function (e) {
        var id = $("#savePaciente").data("id");
        if (isNull(id)) {
            save();
        } else {
            editSave(id);
        }
    });
    $("#cancelPaciente").click(function (e) {
        limpiarPaciente();
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
    if ($(cbo).val() === "1" || $(cbo).val() === "0" || $(cbo).val() === "3") {
        $(tabObstetricia).addClass("disabledTab");
    } else if ($(cbo).val() === "2") {
        $(tabObstetricia).removeClass("disabledTab");
    }
}

