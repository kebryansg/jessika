$("#ContentAdm").on("change", "#cantList", function () {
    $.getScript("paciente/js/paciente.js", function () {
        list_filter();
    });
});
$("#ContentAdm").on("keyup", "#txt_filterPaciente", function () {
    $.getScript("paciente/js/paciente.js", function () {
        list_filter();
    });
});
$("#ContentAdm").on("click", "#tablePaciente button[name='deletPaciente']", function () {

    var id = $(this).attr("data-id");
    $.getScript("paciente/js/paciente.js", function () {
        deletPaciente(id);
        list_filter();
    });
});
$("#ContentAdm").on("click", "#tablePaciente button[name='SeleccionarPaciente']", function () {
    var tr = $(this).closest("tr");
    var tds = $(tr).find("td");
    $("#con_historiaPaciente").val($(tds).eq(0).html());
    $("#con_cedulaPaciente").val($(tds).eq(1).html());
    $("#con_nombrePaciente").val($(tds).eq(2).html());
    $("#con_ciudadPaciente").val($(tds).eq(3).html());
    closeModal("ListPaciente");
});

$("#ContentAdm").on("click", "#tablePaciente button[name='editPaciente']", function () {
    var title = "Modificar Paciente";
    var id = $(this).attr("data-id");
    if ($('#editP' + id).length === 0) {

        var tabId = "compose" + composeCount;
        composeCount = composeCount + 1;

        $('#TabAdm').append('<li><a name="' + title + '" href="#' + tabId + '"><button class="close closeTab" type="button" ><i class="fa fa-close"></i></button>' + title + '</a></li>');
        $('#ContentAdm').append('<div class="tab-pane fade" id="' + tabId + '"><div id="editP' + id + '"></div></div>');
        $('#editP' + id).load("paciente/paciente.jsp", function () {
            ini();
            $.getScript("paciente/js/paciente.js", function () {


                $.each($("#editP" + id + " #tabPacientes_a a"), function (index, value) {
                    var idHref = $(value).attr("href");
                    $(value).attr("href", idHref + id);
                });
                $.each($("#editP" + id + " #tabPacientes .tab-pane"), function (index, value) {
                    var ids = $(value).attr("id");
                    $(value).attr("id", ids + id);
                });


                edit(id);


                /*$("#editP" + id + " #savePaciente").click(function () {
                 editSave(id);
                 });*/
            });
        });
        $currentTab = $('#TabAdm a[href="#' + tabId + '"]');

        $(this).tab('show');
        showTab(tabId);
        registerCloseEvent();
    }
});