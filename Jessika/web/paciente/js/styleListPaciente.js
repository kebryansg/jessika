var $table = $('#table');

$("#tablPaciente").bootstrapTable({
    contextMenu: '#tablPaciente-context-menu',
    beforeContextMenuRow: function (e) {
        return $("#tablPaciente").closest(".modal").length === 0;
    },
    onContextMenuItem: function (row, $el) {
        switch ($el.data("item")) {
            case "edit":
                editPaciente(row.id);
                break;
            case "delete":
                deletePaciente(row.id);
                break;
        }
    }
});
function loadPaginacion(total) {
    $.each($("#pagPacientes li"), function (i, li) {
        if ($(li).find("a[aria-label]").length === 0) {
            $(li).remove();
        }
    });
    li = '';
    for (var c = 0; c < total; c++) {
        li += ('<li ' + ((c === 0) ? 'class="active"' : '') + ' ><a href="#">' + (c + 1) + '</a></li>');
    }
    $("#pagPacientes li").first().after(li);
}

function loadList(bandera, pag) {
    var txt_filter = $("#txt_filterPaciente").val();
    var cantList = $("#cantList").val();
    $.ajax({
        url: 'sPaciente',
        type: 'POST',
        data: {
            filter: txt_filter,
            top: cantList,
            pag: ((pag - 1) * cantList),
            op: 'list_filter'
        },
        success: function (response) {

            var obj = $.parseJSON(response);
            var tablePaciente = $("#tablePaciente tbody");
            $totalPages = obj.count / cantList;
            $totalPages = Math.ceil($totalPages);
            if (bandera) {
                loadPaginacion($totalPages);
            }
            $("#tablPaciente").bootstrapTable('load', obj.list);
            $('#tablPaciente').bootstrapTable('resetView');
        }
    });
}

function editPaciente(idPaciente) {
    $("#contenido").load("paciente/paciente.jsp", function () {
        edit(idPaciente);
    });
}

function deletePaciente(idPaciente) {
    deletPaciente(idPaciente);
    loadList(true, 1);
}

$(function () {

    loadList(true, 1);
    $("#tablPaciente").bootstrapTable('hideColumn', 'sexo');
    $("#tablPaciente").bootstrapTable('hideColumn', 'id');
    $("#contenido").on("click", "#pagPacientes li a[aria-label]", function (e) {
        li_old = $("#pagPacientes li[class='active']");
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
            loadList(false, $(li).find("a").html());
        }
    });
    $("#contenido").on("click", "#pagPacientes li:not([class='active']) a:not([aria-label])", function (e) {
        li = $(this).closest("li");
        $("#pagPacientes li[class='active']").toggleClass("active");
        $(li).toggleClass("active");
        loadList(false, $(this).html());
    });
    $("#contenido").on("change", "#cantList", function () {
        loadList(true, 1);
    });
    $("#contenido").on("keyup", "#txt_filterPaciente", function (e) {
        if (e.keyCode === 8 && $(this).val() === "") {
            loadList(true, 1);
        } else if (e.keyCode === 13) {
            loadList(true, 1);
        }
    });
});


