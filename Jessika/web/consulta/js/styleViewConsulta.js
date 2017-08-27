$(function () {
    //editConsulta(1025);
    $("#btnCancelarViewConsulta").click(function () {
        hc = $("#PacienteId").attr("data-hc");
        $("#contenido").load("consulta/ListHistorialC.jsp", function () {
            load_Paciente(hc);
        });
    });
});

function editConsulta(id) {
    $.ajax({
        type: 'POST',
        data: {
            op: 'edit',
            id: id
        },
        async: false,
        url: 'sConsulta',
        dataType: 'json',
        success: function (data) {
            asignarConsuta(data.consulta);
            asginarSV(data.sv, data.sexoP);

            listEstudiosLabs(data.estl);
            listEstudiosImgs(data.esti);

            $("#PacienteId").val(data.paciente);
            $("#PacienteId").attr("data-hc", data.consulta.idCaso.idHistorialClinico.id);
            $("#con_tipoConsulta").val(data.tipoConsulta);
            $("#con_CausaMetodo").val(data.metodo_causa);
        }
    });
}
function listEstudiosLabs(estLab) {
    result = "";
    $.each(estLab, function (i, el) {
        result += "<li class='list-group-item'>" + el.idDetalleEstudiosLabs.idEstudiosLab.descripcion + " - <strong> " + el.idDetalleEstudiosLabs.descripcion + "</strong></li>";
    });
    if (result !== "") {
        $("#listEstudiosLab").append(result);
    } else {
        $("#listEstudiosLab").hide();
    }
}
function listEstudiosImgs(estImgs) {
    result = "";
    $.each(estImgs, function (i, ei) {
        result += "<li class='list-group-item'>" + ei.idDetalleEstudiosImagen.idEstudiosImg.idTipoEstudioImg.descripcion + " - " + ei.idDetalleEstudiosImagen.idEstudiosImg.descripcion + " - <strong>" + ei.idDetalleEstudiosImagen.descripcion + "</strong></li>";
    });
    if (result !== "") {
        $("#listEstudiosImg").append(result);
    } else {
        $("#listEstudiosImg").hide();
    }

}
function asignarConsuta(consulta) {
    $("#con_Especialidad").val(consulta.idMedicoEspecialidad.idEspecialidad.descripcion);
    $("#con_Fecha").val(consulta.fecha);
    $("#con_Motivo").val(consulta.motivo);
    $("#con_Sintomas").val(consulta.sintoma);
    $("#con_Diagnostico").val(consulta.diagnostico);
    $("#con_Prescripcion").val(consulta.prescripcion);
}
function asginarSV(sv, sexo) {
    $("#sv_Peso").val(sv.peso);
    $("#sv_Talla").val(sv.talla);
    $("#sv_Temperatura").val(sv.temperatura);
    $("#sv_Frecuencia").val(sv.frecuenciaC);
    $("#sv_Presion").val(sv.presion);
    if (sexo === "H") {
        $("#div_femenino").hide();
    } else {
        $("#sv_FUM").val(sv.fum);
        $("#sv_FUC").val(sv.fuc);
        $("#sv_Periodo").val(sv.periodo);
        $("#sv_Periodo").selectpicker("refresh");
    }
}

