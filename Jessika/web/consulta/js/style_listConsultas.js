paginacion_Consultas = ("#pag_tbConsultas");
function loadPaginacionConsultas(total) {
    $(paginacion_Consultas + " li a").not("[aria-label]").closest("li").remove();
    /*$.each($(paginacion_Consultas + " li"), function (i, li) {
     if ($(li).find("a[aria-label]").length === 0) {
     $(li).remove();
     }
     });*/
    li = '';
    for (var c = 0; c < total; c++) {
        li += ('<li ' + ((c === 0) ? 'class="active"' : '') + ' ><a href="#">' + (c + 1) + '</a></li>');
    }
    $(paginacion_Consultas + " li").first().after(li);
}

var optionDate = {
    //format: "yyyy-mm",
    language: 'es',
    weekStart: 1,
    todayBtn: 1,
    autoclose: 1,
    todayHighlight: 1,
    //startView: "year",
    pickerPosition: "bottom-left",
    //minView: 3,
    forceParse: 0
            //initialDate: new Date()
};
$(function () {
    
    $("#tbConsultas").bootstrapTable();
    $(".selectpicker").selectpicker('refresh');


    modalListPaciente();
    $('#ListPaciente').on('shown.bs.modal', function () {
        $("#ListPaciente table").bootstrapTable('resetView');
    });

    $(".fecha").datetimepicker($.extend(optionDate, {
        format: "yyyy-mm-dd",
        minView: 2,
        startView: 2
    }));

    $('.fecha').datetimepicker('setEndDate', new Date());

    $(".mes").datetimepicker($.extend(optionDate, {
        format: "yyyy-mm",
        minView: 3,
        startView: "year"
    }));
    $(".año").datetimepicker($.extend(optionDate, {
        format: "yyyy",
        minView: 4,
        startView: "decade"
    }));
    $('.form_date').datetimepicker('update', new Date());


    $(".hidden-event").hide();

    $("#run_consulta").on("click", function (e) {
        adminGet(true, 1);
    });

    $("#opListConsultas").on("changed.bs.select", function () {
        opTiempo = $(this).val();
        $(".hidden-event").hide();
        limpiarListConsultas();
        switch (opTiempo) {
            case "1":
                $("#fechas").show();
                break;
            case "2":
                $("#con_Mes").closest(".form-group").show();
                break;
            case "3":
                $("#meses").show();
                break;
            case "4":
                $("#con_Año").closest(".form-group").show();
                break;
        }
    });



    $("#contenido").on("click", paginacion_Consultas + " li a[aria-label]", function (e) {
        li_old = $(paginacion_Consultas + " li[class='active']");
        li = undefined;
        switch ($(this).attr("aria-label")) {
            case "Anterior":
                li = $(li_old).prev();
                break;
            case "Siguiente":
                li = $(li_old).next();
                break;
        }
        if ($(li).find("a[aria-label]").length === 0) {
            $(li).toggleClass("active");
            $(li_old).toggleClass("active");
            adminGet(false, $(li).find("a").html());
        }
    });
    $("#contenido").on("click", paginacion_Consultas + " li:not([class='active']) a:not([aria-label])", function (e) {
        li = $(this).closest("li");
        $(paginacion_Consultas + " li[class='active']").toggleClass("active");
        $(li).toggleClass("active");
        adminGet(false, $(this).html());
    });

    $("#cantListConsultas").on("changed.bs.select", function () {

        adminGet(true, 1);
    });

    $("#pac_Delete").on("click", function (e) {
        limpiarInfoPaciente();
    });

});

function limpiarListConsultas() {
    $(paginacion_Consultas + " li a").not("[aria-label]").closest("li").remove();
    $("#tbConsultas").bootstrapTable("removeAll");
    $('.form_date').datetimepicker('update', new Date());
}

function limpiarInfoPaciente() {
    $("#pac_HC").val("");
    $("#pac_Nombres").val("");
}

function adminGet(bandera, pag) {
    idHC = $("#pac_HC").val() !== "" ? $("#pac_HC").val() : 0;
    tiempo = $("#opListConsultas").val();
    switch (tiempo) {
        case "0":
            alertify.success("Incovenientes en terminos de busqueda");
            break;
        case "1":
        case "3":
            //Validando entre fechas y entre mes
            //Asignando valores dependiendo el case
            fechaI = (tiempo === "1") ? $("#con_FechaI").val() : $("#con_MesI").val();
            fechaF = (tiempo === "1") ? $("#con_FechaF").val() : $("#con_MesF").val();
            getConsultas_Fechas(bandera, pag, fechaI, fechaF, tiempo, idHC, "");
            break;
        case "2":
        case "4":
            // Mes - Año
            getConsultasTiempo(bandera, pag, (tiempo === "2") ? $("#con_Mes").val() : $("#con_Año").val(), tiempo, idHC, "");
            break;
    }
}

function getConsultasTiempo(bandera, pag, fecha, opTiempo, idHC, filter) {
    cantList = $("#cantListConsultas").val();
    $.ajax({
        url: "sConsulta",
        type: 'POST',
        dataType: 'json',
        async: false,
        data: {
            op: 'adminConsultas',
            fecha: fecha,
            opTiempo: opTiempo,
            idHC: idHC,
            filter: filter,
            pag: ((pag - 1) * cantList),
            top: cantList
        },
        success: function (data) {
            if (bandera)
                loadPaginacionConsultas(data.count);
            $("#tbConsultas").bootstrapTable("load", data.list);
        }
    });
}

function getConsultas_Fechas(bandera, pag, fechaI, fechaF, opTiempo, idHC, filter) {
    cantList = $("#cantListConsultas").val();
    $.ajax({
        url: "sConsulta",
        type: 'POST',
        dataType: 'json',
        async: false,
        data: {
            op: 'adminConsultas',
            fechaI: fechaI,
            fechaF: fechaF,
            opTiempo: opTiempo,
            idHC: idHC,
            filter: filter,
            pag: ((pag - 1) * cantList),
            top: cantList
        },
        success: function (data) {
            if (bandera)
                loadPaginacionConsultas(data.count);
            $("#tbConsultas").bootstrapTable("load", data.list);
        }
    });
}

function modalListPaciente() {
    $("#ListPaciente .modal-body").load("paciente/listPacientes.jsp", function () {
        $("#tablPaciente").bootstrapTable('hideColumn', 'accion');
        $("#tablPaciente").bootstrapTable('showColumn', 'seleccionar');

        $("#tablPaciente").on('dbl-click-row.bs.table', function (e, row, $element) {
            $("#pac_HC").val(row.hc);
            //$("#con_cedulaPaciente").val(row.cedula);
            $("#pac_Nombres").val(row.nombres);
            //$("#con_sexoPaciente").val(row.sexo);
            $("#ListPaciente").modal("toggle");
        });


    });
}