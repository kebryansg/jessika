$(function () {



    $("#tbHC").on("click", "button[name='addHistorialCaso']", function () {
        nomPaciente = $("#con_nombrePaciente").val();
        idCaso = $(this).attr("data-id");
        hc = $("#con_historiaPaciente").val();
        $("#contenido").load("consulta/newConsulta.jsp", function () {
            $("#PacienteId").val(nomPaciente);
            $("#casoId").val(idCaso);
            $("#PacienteId").attr("data-hc", hc);
        });
    });

    $("#btnNewConsulta").click(function () {
        nomPaciente = $("#con_nombrePaciente").val();
        hc = $("#con_historiaPaciente").val();
        $("#contenido").load("consulta/newConsulta.jsp", function () {
            $("#PacienteId").val(nomPaciente);
            $("#PacienteId").attr("data-hc", hc);
        });
    });


    modalListPaciente();
    $('#ListPaciente').on('shown.bs.modal', function () {
        $("#ListPaciente table").bootstrapTable('resetView');
    });


    $("#contenido").on("click", "#tablePaciente button[name='SeleccionarPaciente']", function () {
        var tr = $(this).closest("tr");
        var tds = $(tr).find("td");
        $("#con_historiaPaciente").val($(tds).eq(0).html());
        $("#con_cedulaPaciente").val($(tds).eq(1).html());
        $("#con_nombrePaciente").val($(tds).eq(2).html());
        $("#con_ciudadPaciente").val($(tds).eq(3).html());
        closeModal("ListPaciente");
        $.getScript("consulta/js/consulta.js", function () {
            obtList();
        });
    });


    $("#contenido").on("click", "#pac_Buscar", function (e) {
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

function modalListPaciente() {
    $("#ListPaciente .modal-body").load("paciente/listPacientes.jsp", function () {
        var tablePaciente = $("#tablePaciente");
        $(tablePaciente).attr("modal", "1");

        $.getScript("paciente/js/paciente.js", function () {
            td_tr_seleccionar(tablePaciente);
        });

    });
}
function limpiarDivPaciente() {
    $("#con_historiaPaciente").val("");
    $("#con_cedulaPaciente").val("");
    $("#con_nombrePaciente").val("");
    $("#con_ciudadPaciente").val("");
}
