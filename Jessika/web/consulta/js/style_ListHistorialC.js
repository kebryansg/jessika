$.ajaxSetup({
    cache: true
});

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
            $("#tbHC tbody").html(data);
            $('#tbHC').bootstrapTable('resetView');
        }
    });
}

$(function () {
    $("#tbHC").on("click", "button[name='addHistorialCaso']", function () {
        nomPaciente = $("#con_nombrePaciente").val();
        idCaso = $(this).attr("data-id");
        hc = $("#con_historiaPaciente").val();
        sexo = $("#con_sexoPaciente").val();

        $("#contenido").load("consulta/newConsulta.jsp", function () {
            $("#PacienteId").val(nomPaciente);
            $("#casoId").val(idCaso);
            $("#PacienteId").attr("data-hc", hc);
            if (sexo === "1") {
                $("#div_femenino").hide();
            }

        });
    });

    $("#btnNewConsulta").click(function () {
        nomPaciente = $("#con_nombrePaciente").val();
        hc = $("#con_historiaPaciente").val();
        sexo = $("#con_sexoPaciente").val();
        if (hc !== "") {
            $("#contenido").load("consulta/newConsulta.jsp", function () {
                $("#PacienteId").val(nomPaciente);
                $("#PacienteId").attr("data-hc", hc);
                if (sexo === "1") {
                    $("#div_femenino").hide();
                    $(".sMasculino").closest("li").attr("class","disabled");
                }
                else{
                    $(".sFemenino").closest("li").attr("class","disabled");
                }
            });
        } else {
            alertify.success("Paciente no seleccionado...!");
        }
    });


    modalListPaciente();
    $('#ListPaciente').on('shown.bs.modal', function () {
        $("#ListPaciente table").bootstrapTable('resetView');
    });


    $("#contenido").on("click", "#tablPaciente button[name='SeleccionarPaciente']", function () {
        var tr = $(this).closest("tr");
        var tds = $(tr).find("td");
        $("#con_historiaPaciente").val($(tds).eq(0).html());
        $("#con_cedulaPaciente").val($(tds).eq(1).html());
        $("#con_nombrePaciente").val($(tds).eq(2).html());
        $("#con_sexoPaciente").val($("#tablPaciente").bootstrapTable('getRowByUniqueId', $(tds).eq(0).html()).sexo);

        //alert($("#tablPaciente").bootstrapTable('getRowByUniqueId', $(tds).eq(0).html()).sexo);
        obtList();
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
                        $("#con_sexoPaciente").val((ob.paciente.sexo) ? "1" : "0");
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
        $("#tablPaciente").bootstrapTable('hideColumn', 'accion');
        $("#tablPaciente").bootstrapTable('showColumn', 'seleccionar');
    });
}
function limpiarDivPaciente() {
    $("#con_historiaPaciente").val("");
    $("#con_cedulaPaciente").val("");
    $("#con_nombrePaciente").val("");
    $("#con_ciudadPaciente").val("");
}
