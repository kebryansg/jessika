$(function () {
    $('#editPaciente .modal-body').load("paciente/paciente.jsp");

    $.getScript("paciente/js/paciente.js", function () {
        list_filter();
    });

    $("#contenido").on("change", "#cantList", function () {
        $.getScript("paciente/js/paciente.js", function () {
            list_filter();
        });
    });
    $("#contenido").on("keyup", "#txt_filterPaciente", function () {
        $.getScript("paciente/js/paciente.js", function () {
            list_filter();
        });
    });
    $("#contenido").on("click", "#tablePaciente button[name='deletPaciente']", function () {

        var id = $(this).attr("data-id");
        $.getScript("paciente/js/paciente.js", function () {
            deletPaciente(id);
            list_filter();
        });
    });

});


$("#contenido").on("click", "#tablePaciente button[name='editPaciente']", function () {
    var id = $(this).attr("data-id");
    $.getScript("paciente/js/paciente.js", function () {
        edit(id);
    });
    openModal("editPaciente");
});