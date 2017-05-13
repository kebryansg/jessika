$(function () {
    $.getScript("paciente/js/paciente.js", function () {

        indexPag(1, 5, "");
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
    
    $("#editPaciente").on("hidden.bs.modal", function () {
        alert();
        $("#editPaciente .modal-body").html("");
    });



});


$("#contenido").on("click", "#tablePaciente button[name='editPaciente']", function () {
    var id = $(this).attr("data-id");
    $('#editPaciente .modal-body').load("paciente/paciente.jsp", function () {
        $.getScript("paciente/js/paciente.js", function () {
            edit(id);
        });
    });
    openModal("editPaciente");
});