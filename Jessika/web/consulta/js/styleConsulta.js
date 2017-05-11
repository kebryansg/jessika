function limpiarDivPaciente() {
    $("#con_historiaPaciente").val("");
    $("#con_cedulaPaciente").val("");
    $("#con_nombrePaciente").val("");
    $("#con_ciudadPaciente").val("");
}
$(document).ready(function () {
    $("#pac_Buscar").click(function () {
        $("#ListPaciente .modal-body").load("paciente/listPacientes.jsp", function () {
            ini();
            var tablePaciente = $(pestañaGlobal()).find("#tablePaciente");
            $(tablePaciente).attr("modal", "1");
            $.getScript("paciente/js/paciente.js", function () {
                td_tr_seleccionar(tablePaciente);
            });

        });
        //$(pestañaGlobal()).find("#tablePaciente").attr("data-modal","1");
        openModal("ListPaciente");

    });
    $("#pac_Cargar").click(function () {
        limpiarDivPaciente();
        var cod = $("#txt_cargarPaciente").val();
        var bandera = validarText($("#txt_cargarPaciente"));
        if (bandera) {
            $.ajax({
                url: 'sConsulta',
                type: 'POST',
                data: {
                    op: 'paciente',
                    cod: cod
                },
                success: function (response) {
                    if (response !== "null") {
                        var ob = $.parseJSON(response);
                        $("#con_historiaPaciente").val(ob.hc_id);
                        $("#con_cedulaPaciente").val(ob.paciente.cedula);
                        $("#con_nombrePaciente").val((ob.paciente.apellido1 + " " + ob.paciente.apellido2 + " " + ob.paciente.nombre1 + " " + ob.paciente.nombre2).toUpperCase());
                        $("#con_ciudadPaciente").val(ob.paciente.ciudad.toUpperCase());
                    } else {
                        alertify.success("Paciente no encontrado");
                    }


                }

            });
        }
    });

});

