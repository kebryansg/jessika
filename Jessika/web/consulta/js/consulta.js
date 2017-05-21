function limpiarConsulta(){
    
}
function saveConsulta() {
    $.ajax({
        url: "sConsulta",
        data: {
            op: "save",
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
function obtList(){
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