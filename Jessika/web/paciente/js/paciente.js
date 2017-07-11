function validarPaciente(id) {
    $(".help-block").remove();
    $.each($("#tabPacientes input[validate='text']"), function (index, value) {
        if (!validarText(value)) {
            $(value).blur(function () {
                validarText(value);
            });
        }
    });
    $.each($("#tabPacientes select[validate='select']"), function (index, value) {
        if (!validarSelect(value)) {
            $(value).on("change", function () {
                validarSelect(value);
            });
        }
    });
    $.each($("#tabPacientes input[validate='date']"), function (index, value) {
        if (!validarDate(value)) {
            $(value).change(function () {
                validarDate(value);
            });
        }
    });
    var email = $("#tabPacientes input[validate='email']");
    if (!validarEmail(email)) {
        $(email).blur(function () {
            validarEmail(email);
        });
    }
    var cedula = $("#tabPacientes input[validate='cedula']");
    if (!validarCedula(cedula)) {
        $(cedula).blur(function () {
            validarCedula(cedula);
        });
    }

    if ($("#pac_Genero").val() === "2") {
        var date = $("#pac_FPP");
        if (!validarDate(date)) {
            $(date).change(function () {
                validarDate(date);
            });
        }
    }
    return $(".help-block").length === 0;
}

function deletPaciente(id) {
    $.ajax({
        url: 'sPaciente',
        data: {
            op: 'delete',
            id: id
        },
        async: false,
        type: 'POST',
        success: function (data) {
            alertify.success("Registros Eliminado");
        }
    });
}

function list() {
    $.ajax({
        url: 'sPaciente',
        type: 'POST',
        async: false,
        data: {
            op: 'list'
        },
        success: function (response) {
            $("#tablePaciente").html(response);
        }
    });
}

function td_tr_seleccionar(tbody) {
    $.each($(tbody).find("tr"), function (index, tr) {
        var id = $(tr).attr("data-id");
        $(tr).find("td:last").html("");
        $(tr).find("td:last").html('<button name="SeleccionarPaciente" data-dismiss="modal" class="btn btn-info">Seleccionar</button>');
    });
}

function indexPag(pag, totalList, txt_filter) {
    var cantList = totalList;
    $.ajax({
        url: 'sPaciente',
        type: 'POST',
        //async: false,
        data: {
            filter: txt_filter,
            top: cantList,
            pag: ((pag - 1) * cantList),
            op: 'list_filter'
        },
        success: function (response) {
            var obj = $.parseJSON(response);
            var tablePaciente = $("#tablePaciente");
            $(tablePaciente).html(obj.list);
            if ($(tablePaciente).attr("modal") === "1") {

                td_tr_seleccionar(tablePaciente);
            }
            $('#tablPaciente').bootstrapTable('resetView');
        }
    });
}

var defaultOpts = {
//totalPages: 2,
    visiblePages: 10,
    first: "Primero",
    next: "Siguiente",
    last: "Ultimo",
    prev: "Anterior"
};

function list_filter() {
    var tablePaciente = $("#tablePaciente");
    $(tablePaciente).html("");
    var $pagination = $('#pagPacientes');
    var txt_filter = $("#txt_filterPaciente").val();
    var cantList = $("#cantList").val();
    var $totalPages = 2;
    if (txt_filter !== "") {

        $.ajax({
            url: 'sPaciente',
            type: 'POST',
            async: false,
            data: {
                op: 'list',
                filter: txt_filter
            },
            success: function (response) {
                $totalPages = response / cantList;
                $totalPages = Math.ceil($totalPages);
                //Paginacion

            }
        });
    }
    $pagination.twbsPagination('destroy');
    $pagination.twbsPagination($.extend({}, defaultOpts, {
        onPageClick: function (event, page) {
            indexPag(page, cantList, txt_filter);
        },
        totalPages: $totalPages
    }));
}

function edit(id) {
    $.ajax({
        url: 'sPaciente',
        type: 'POST',
        async: false,
        cache: false,
        data: {
            id: id,
            op: 'edit'
        },
        success: function (response) {
            var ob = $.parseJSON(response);
            //$("#optionPaciente").attr("data-id", ob.paciente.id);
            asignarPaciente(ob.paciente);
            addAntecedentes(ob.list, ob.paciente.id);
            if (!ob.paciente.sexo) {
                asignarObstetrico(ob.obs, ob.paciente.id);
            }
        }
    });
}

function editSave(id) {
    if (validarPaciente(id)) {
        var newA = newAntecedentes(id);
        var editA = editAntecedentes(id);
        var paciente = obtenerDatos(id);
        $.ajax({
            url: 'sPaciente',
            type: 'POST',
            async: false,
            data: {
                id: id,
                paciente: paciente,
                newAntecedentes: newA,
                editAntecedentes: editA,
                op: 'save'
            },
            success: function (response) {
                alertify.success("Paciente Modificado");
                limpiarPaciente();
            }
        });
    } else {
        alertify.success("Inconvenientes..!");
    }
}

function save() {
    if (validarPaciente(0)) {
        var newA = newAntecedentes(0);
        $.ajax({
            url: 'sPaciente',
            type: 'POST',
            async: false,
            cache: false,
            data: {
                id: 0,
                paciente: obtenerDatos(),
                newAntecedentes: newA,
                op: 'save'
            },
            success: function (response) {
                alertify.success("Paciente Registrado");
                limpiarPaciente();
            }
        });
    } else {
        alertify.success("Inconvenientes..!");
    }
}

function obtenerDatos() {
    var paciente = {
        cedula: $("#pac_Cedula").val(),
        primerNombre: $("#pac_primerNombre").val(),
        segundoNombre: $("#pac_segundoNombre").val(),
        primerApellido: $("#pac_primerApellido").val(),
        segundoApellido: $("#pac_segundoApellido").val(),
        fechaNac: $("#pac_FechaNac").val(),
        nacionalidad: $("#pac_nacionalidad").val(),
        telCasa: $("#pac_TelCasa").val(),
        email: $("#pac_Email").val(),
        etnia: $("#pac_Etnia").val(),
        domicilio: $("#pac_Domicilio").val(),
        discapacidad: $("#pac_Discapacidad").val(),
        ciudad: $("#pac_Ciudad").val(),
        estadoCivil: $("#pac_EstadoCivil").val(),
        telOficina: $("#pac_TelOficina").val(),
        genero: $("#pac_Genero").val(),
        paisNac: $("#pac_PaisNac").val(),
        lugarNac: $("#pac_LugarNac").val(),
        provincia: $("#cboProvincia").val(),
        parroquia: $("#cboParroquia").val(),
        canton: $("#cboCanton").val(),
        nombreContacto: $("#pac_nombreContacto").val(),
        movilContacto: $("#pac_movilContacto").val(),
        parentezco: $("#cboParentezco").val(),
        //Obstetricia
        idObs: $("#tabObstetricia").attr("data-id"),
        fpp: $("#pac_FPP").val(),
        gestacion: $("#pac_Gestacion").val(),
        abortos: $("#pac_Abortos").val(),
        partos: $("#pac_Partos").val(),
        cesareas: $("#pac_Cesareas").val(),
        nacidoVivo: $("#pac_NacidoVivo").val(),
        nacidoMuerto: $("#pac_NacidoMuerto").val(),
        hijosVivos: $("#pac_HijosVivos").val(),
        hijosMuertos: $("#pac_HijosMuertos").val()

    };
    return paciente;
}

function newAntecedentes(id) {
// Retorna los nuevos antecedentes
    var ids = [];
    $.each($("#optionPaciente[data-id='" + id + "'] input[antecedentes]:not([data-id!='0']):checked"), function (index, cbk) {
        ids.push($(cbk).attr("dEnfermedad") + ":" + $(cbk).attr("dParient"));
    });
    return ids;
}

function addAntecedentes(list, id) {
    $.each(list, function (index, item) {
        $("input[antecedentes][dEnfermedad='" + item.idEnfermedad.id + "'][dParient='" + item.idPariente.id + "']").attr("data-id", item.id);
        $("input[antecedentes][dEnfermedad='" + item.idEnfermedad.id + "'][dParient='" + item.idPariente.id + "']").prop("checked", true);
    });
}

function editAntecedentes(id) {
// Retorna los antecedentes que han sido editados
    var ids = [];
    $.each($("input[antecedentes][data-id!='0']"), function (index, cbk) {
        if (!$(cbk).prop("checked")) {
            ids.push($(cbk).attr("data-id"));
        }
    });
    return ids;
}

function asignarObstetrico(obs, id) {
    $("#tabObstetricia").attr("data-id", obs.id);
    $("#pac_FPP").val(obs.fpp);
    $("#pac_Gestacion").val(obs.gestas);
    $("#pac_Abortos").val(obs.abortos);
    $("#pac_Partos").val(obs.partos);
    $("#pac_Cesareas").val(obs.cesareas);
    $("#pac_NacidoVivo").val(obs.nacidosVivos);
    $("#pac_NacidoMuerto").val(obs.nacidosMuertos);
    $("#pac_HijosVivos").val(obs.hijosVivos);
    $("#pac_HijosMuertos").val(obs.muertos);
}

function asignarPaciente(paciente) {
    $("#savePaciente").data("id", paciente.id);
    $("#pac_Cedula").val(paciente.cedula);
    $("#pac_primerNombre").val(paciente.nombre1);
    $("#pac_segundoNombre").val(paciente.nombre2);
    $("#pac_primerApellido").val(paciente.apellido1);
    $("#pac_segundoApellido").val(paciente.apellido2);
    $("#pac_FechaNac").val(paciente.fechaNacimiento);
    $("#pac_imagen").attr("src", paciente.imagen);
    $("#pac_imagen").attr("edit", paciente.imagen);
    $("#pac_TelCasa").val(paciente.telefonoDomicilio);
    $("#pac_Email").val(paciente.email);
    $("#pac_TelOficina").val(paciente.telefonoOficina);
    $("#pac_PaisNac").val(paciente.paisNacimiento);
    $("#pac_LugarNac").val(paciente.lugarNacimiento);
    $("#pac_Domicilio").val(paciente.domicilio);
    $("#pac_Ciudad").val(paciente.ciudad);
    $("#pac_nombreContacto").val(paciente.nombreContacto);
    $("#pac_movilContacto").val(paciente.movilContacto);
    $("#cboParentezco").selectpicker("val", paciente.parentezco);
    $('#pac_Discapacidad').selectpicker("val", paciente.discapacidad);
    //Select
    $('#pac_nacionalidad').selectpicker("val", paciente.nacionalidad);
    $('#pac_Etnia').selectpicker("val", paciente.etnia);
    $('#pac_EstadoCivil').selectpicker("val", paciente.estadoCivil);
    $('#pac_Genero').selectpicker("val", paciente.sexo);
    change_Genero($('#pac_Genero'));
    /* Carga y asigna provincia,canton y parroquia */
    $.ajax({
        type: 'POST',
        url: 'sPaciente',
        async: false,
        data: {
            idParroquia: paciente.idParroquia.id,
            op: "det"
        },
        success: function (response) {
            var det = $.parseJSON(response);
            $('#cboProvincia').selectpicker('val', det.provincia);
            //$('#cboProvincia > option[value="' + det.provincia + '"]').attr('selected', true);
            change_cboProvincia($('#cboProvincia'));
            $('#cboCanton').selectpicker('val', det.canton);
            //$('#cboCanton > option[value="' + det.canton + '"]').attr('selected', true);
            change_cboCanton($('#cboCanton'));
            $('#cboParroquia').selectpicker('val', paciente.idParroquia.id);
            //$('#cboParroquia > option[value="' + paciente.idParroquia.id + '"]').attr('selected', true);
        }
    });
}

function limpiarPaciente() {
    var id = $("#savePaciente").data("id");
    if (isNull(id)) {
        moment();
    } else {
        $("#contenido").load("paciente/listPacientes.jsp");
    }
}

function moment() {
    $("#tabPacientes input[validate='text']").val("");
    $("#pac_Cedula").val("");
    $("#tabPacientes input[validate='cedula']").val("");
    $("#tabPacientes select[validate='select']").selectpicker("val", 0);
    $("#tabPacientes #pac_Discapacidad").selectpicker("val", 1);
    $("#pac_nombreContacto").val("");
    $("#cboParentezco").selectpicker("val", 0);
    $("#pac_movilContacto").val("");
}