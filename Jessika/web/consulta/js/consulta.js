function limpiarConsulta() {

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
function obtenerSignosVitales() {
    sv = {
        id: $("#sv_id").attr("data-id"),
        peso: $("#sv_Peso").val(),
        talla: $("#sv_Talla").val(),
        temperatura: $("#sv_Temperatura").val(),
        presion: $("#sv_Presion").val(),
        frecuenciaC: $("#sv_Frecuencia").val(),
        fum: $("#sv_FUM").val(),
        fuc: $("#sv_FUC").val()
    };
    return sv;
}


function obtenerDescripcion() {
    dc = {
        motivo: $("#con_Motivo").val(),
        prescripcion: $("#con_Prescripcion").val(),
        diagnostico: $("#con_Diagnostico").val(),
        sintomas: $("#con_Sintomas").val()
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
function obtList() {
    $.ajax({
        url: "sConsulta",
        data: {
            op: "list",
            idHc: $("#con_historiaPaciente").val(),
            filter: ""
                    //fecha: $("#con_Fecha").val()
        },
        type: 'POST',
        async: false,
        success: function (data) {
            //alertify.success("Registrado correctamente...!");
            $("#tbHC tbody").html(data);
            $('#tbHC').bootstrapTable('resetView');
        }

    });
}