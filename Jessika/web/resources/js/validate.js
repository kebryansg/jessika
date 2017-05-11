function validarText(value) {
    var bandera = true;
    var valor = "#" + $(value).attr("id") + 'help';
    $(valor).remove();
    if ($(value).val() === null || $(value).val() === "") {

        $(value).closest("div").addClass("has-error");
        $(value).after('<span id="' + $(value).attr("id") + 'help" class="help-block">Campo Vacio</span');
        bandera = false;
    } else
    {
        $(value).closest("div").removeClass("has-error");
    }
    return bandera;
}

function validarSelect(value) {
    var bandera = true;
    var valor = "#" + $(value).attr("id") + 'help';
    $(valor).remove();
    if ($(value).val() === "0") {
        $(value).closest("div").addClass("has-error");
        $(value).after('<span id="' + $(value).attr("id") + 'help" class="help-block">Sin seleccionar</span');
        bandera = false;
    } else
    {
        $(value).closest("div").removeClass("has-error");
    }
    return bandera;
}
function validarDate(value) {
    var bandera = true;
    var valor = "#" + $(value).attr("id") + 'help';
    $(valor).remove();
    if ($(value).val() === null || $(value).val() === "") {
        $(value).closest("div").addClass("has-error");
        $(value).parent("div").after('<span id="' + $(value).attr("id") + 'help" style="color:#a94442;" class="help-block">Sin Fecha</span');
        bandera = false;
    } else
    {
        $(value).closest("div").removeClass("has-error");
    }
    return bandera;
}
function validarEmail(value) {
    var bandera = true;
    var validacion_email = /^[a-zA-Z0-9_\.\-]+@[a-zA-Z0-9\-]+\.[a-zA-Z0-9\-\.]+$/;
    //var email = $("#tabPacientes input[validate='email']");
    if ($(value).val() !== "") {
        if (!validacion_email.test($(value).val())) {
            $(value).closest("div").addClass("has-error");
            $(value).after('<span id="' + $(value).attr("id") + 'help" class="help-block">Email no valido.</span');
            bandera = false;
        } else {
            $(value).closest("div").removeClass("has-error");
        }
    }
    return bandera;
}

function validarCedula(value) {
    var bandera = true;
    var valor = "#" + $(value).attr("id") + 'help';
    $(valor).remove();
    if ($(value).val() === null || $(value).val() === "" || $(value).val().length < 10) {

        $(value).closest("div").addClass("has-error");
        $(value).after('<span id="' + $(value).attr("id") + 'help" class="help-block">Campo Vacio</span');
        bandera = false;
    } else
    {
        $(value).closest("div").removeClass("has-error");
    }
    return bandera;
}