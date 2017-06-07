$(document).ready(function () {

    $("#cboTipoConsulta").on("changed.bs.select", function (e) {
        idTipoConsulta = $("#cboTipoConsulta").val();
        if (idTipoConsulta === "1") {
            $("#groupCausa").show();
            $("#groupMetodos").hide();
        } else {
            $("#groupMetodos").show();
            $("#groupCausa").hide();
        }
    });

    $("#groupMetodos").hide();
    $("#estLab .modal-body").load("consulta/estudiosLab.jsp");
    $("#estImg .modal-body").load("consulta/estudiosImg.jsp");
    loadTipoConsulta();
    loadMetodos();


    $("#estImg").on('hide.bs.modal', function (e) {
        trs = $("#tableEstudiosImgSelec tbody tr[data-index]");
        $.each(trs, function (index, i) {
            if ($(i).find("input[name='ext_estI']").length > 0) {
                if ($(i).find("input[name='ext_estI']:checked").length === 0) {
                    alert("Informacion incompleta...!");
                    e.preventDefault();
                }
            }
        });
        cant_tr = $("#tableEstudiosImgSelec tbody tr[data-index]").length;
        if (cant_tr === 0) {
            $("#showImgs span").html("Ningun estudio de imagenes.");
            $("#showImgs").removeClass("has-success");
            $("#showImgs").addClass("has-error");
            $("#showImgs button").addClass("btn-danger");
            $("#showImgs button").removeClass("btn-success");

        } else {
            $("#showImgs span").html("Cant. de estudios: " + cant_tr);
            $("#showImgs").removeClass("has-error");
            $("#showImgs").addClass("has-success");
            $("#showImgs button").removeClass("btn-danger");
            $("#showImgs button").addClass("btn-success");
        }
    });


    $('#estLab').on('shown.bs.modal', function () {
        $('#estLab table').bootstrapTable('resetView');
    });
    $('#estImg').on('shown.bs.modal', function () {
        $('#estImg table').bootstrapTable('resetView');
    });


    $('#estLab').on('hidden.bs.modal', function () {
        cant_tr = $("#tableEstudiosLabSelec tbody tr[data-index]").length;
        div_lab = $("#showLabs");
        if (cant_tr === 0) {
            $("#showLabs span").html("Ningun estudio de laboratorio.");
            $("#showLabs").removeClass("has-success");
            $("#showLabs").addClass("has-error");
            $("#showLabs button").addClass("btn-danger");
            $("#showLabs button").removeClass("btn-success");

        } else {
            $("#showLabs span").html("Cant. de estudios: " + cant_tr);
            $("#showLabs").removeClass("has-error");
            $("#showLabs").addClass("has-success");
            $("#showLabs button").removeClass("btn-danger");
            $("#showLabs button").addClass("btn-success");
        }
    });


    $("#btnCancelarConsulta").click(function () {
        $("#contenido").load("consulta/ListHistorialC.jsp");
    });

    $("#btnGuardarConsulta").click(function () {
        //saveConsulta();
        if(validarConsulta()){
            saveConsulta();
        }
        else{
            alertify.success("Incovenientes en la informaciòn");
        }
    });

});

function loadTipoConsulta() {
    $.ajax({
        url: "sTipoConsulta",
        data: {
            op: "list"
        },
        type: 'POST',
        async: false,
        success: function (data) {
            $("#cboTipoConsulta").html(data);
            $("#cboTipoConsulta").selectpicker("refresh");
        }
    });
}

function loadMetodos() {
    $.ajax({
        url: "sTipoConsulta",
        data: {
            op: "list_metodos",
            idTipoConsulta: 2
        },
        type: 'POST',
        async: false,
        success: function (data) {
            $("#cboMetodos").html(data);
            $("#cboMetodos").selectpicker("refresh");
        }
    });
}

function saveConsulta() {
    $.ajax({
        url: "sConsulta",
        data: {
            op: "save",
            estudLab: obtenerEstudiosLab(),
            estuImg: obtenerEstudiosImg(),
            idCaso: $("#casoId").val(),
            idHc: $("#PacienteId").attr("data-hc"),
            sv: obtenerSignosVitales(),
            dc: obtenerDescripcion(),
            idEspecialidad: $("#cboEspecialidadMedico").val(),
            fecha: $("#con_Fecha").val()
        },
        type: 'POST',
        async: false,
        success: function (data) {
            alertify.success("Registrado correctamente...!");
        }
    });
}
function validarConsulta() {
    $("#consulta_div .help-block").remove();
    
    $("#consulta_div select[validate='select']").closest(".form-group").removeClass("has-error");
    $("#consulta_div select[validate='select']").closest(".form-group").removeClass("error_input");
    cbos = [];
    cbos.push($("#cboEspecialidadMedico"));
    switch ($("#cboTipoConsulta").val()) {
        case "1":
            cbos.push($("#cboCausa"));
            break;
        case "2":
            cbos.push($("#cboMetodos"));
            break;
    }
    $.each(cbos, function (i, cbo) {
        if (!validarSelect(cbo)) {
            $(cbo).on("change", function () {
                validarSelect(cbo);
            });
        }
    });
    
    $.each($("#consulta_div input[validate='date']"), function (index, value) {
        if (!validarDate(value)) {
            $(value).change(function () {
                validarDate(value);
            });
        }
    });
    $.each($("#sv_id input[validate='text']"), function (index, value) {
        if (!validarText(value)) {
            $(value).change(function () {
                validarText(value);
            });
        }
    });


    return $("#consulta_div .help-block").length === 0;
}
function obtenerSignosVitales() {
    sv = {
        id: $("#sv_id").attr("data-id"),
        peso: $("#sv_Peso").val(),
        talla: $("#sv_Talla").val(),
        temperatura: $("#sv_Temperatura").val(),
        presion: $("#sv_Presion").val(),
        frecuenciaC: $("#sv_Frecuencia").val(),
        fum: $("#sv_FUM").val(),
        fuc: $("#sv_FUC").val(),
        periodo: $("#sv_Periodo").val()
    };
    return sv;
}
function obtenerDescripcion() {
    dc = {
        motivo: $("#con_Motivo").val(),
        prescripcion: $("#con_Prescripcion").val(),
        diagnostico: $("#con_Diagnostico").val(),
        sintomas: $("#con_Sintomas").val(),
        idTipoConsulta: $("#cboTipoConsulta").val(),
        idMetodo: {
            id: ($("#groupCausa").is(":visible")) ? $("#cboCausa").val() : $("#cboMetodos").val(),
            descripcion: ($("#groupCausa").is(":visible")) ? $("#cboCausa").text() : ""
        }
    };
    return dc;
}
function obtenerEstudiosLab() {
    est = $.parseJSON(JSON.stringify($("#tableEstudiosLabSelec").bootstrapTable('getData')));
    estArreglo = [];
    $.each(est, function (i, item) {
        estArreglo.push(est[i].id);
        //alert(est[i].id);
    });
    return estArreglo;
}
function obtenerEstudiosImg() {
    imgArreglo = [];
    trs = $("#tableEstudiosImgSelec tbody tr[data-index]");
    $.each(trs, function (index, i) {
        detExtre = 0;//0 nada 1 izq 2 der 3 ambas
        if ($(i).find("input[name='ext_estI']").length > 0) {
            switch ($(i).find("input[name='ext_estI']:checked").length) {
                case 1:
                    dir = $(i).find("input[name='ext_estI']:checked").attr("data-dir");
                    detExtre = (dir === "der") ? 2 : 1;
                    break;
                case 2:
                    detExtre = 3;
                    break;
            }
        }
        imgArreglo.push({
            id: $(i).find("td").eq(1).html(),
            detExtre: detExtre
        });
    });
    return JSON.stringify(imgArreglo);
}


var optionsCboCausa = {
    ajax: {
        url: 'sConsulta',
        type: 'POST',
        dataType: 'json',
        data: {
            q: '{{{q}}}',
            op: "select"
        }
    },
    locale: {
        emptyTitle: ''
    },
    // log: 3,
    preprocessData: function (data) {
        var i, l = data.length, array = [];
        if (l) {
            for (i = 0; i < l; i++) {
                array.push($.extend(true, data[i], {
                    text: data[i].descripcion,
                    value: data[i].id,
                    data: {
                        subtext: ""
                    }
                }));
            }
        }
        return array;
    },
    preserveSelected: false
};
//$('.selectpicker').selectpicker().filter('.with-ajax').ajaxSelectPicker(optionsCboCausa);
$('#cboCausa').ajaxSelectPicker(optionsCboCausa);
$('select').trigger('change');