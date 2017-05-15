function cboCategoria_load(cbo) {
    $.ajax({
        url: 'sEstudioLab',
        type: 'POST',
        async: false,
        data: {
            op: 'list_cbo'
        },
        success: function (response) {
            $(cbo).html(response);
            $(cbo).selectpicker('refresh');
        }
    });
}
var defaultOpt = {
    visiblePages: 10,
    first: "Primero",
    next: "Siguiente",
    last: "Ultimo",
    prev: "Anterior"
};
function list_filter_estLab() {
    var tablePaciente = $("#tableEstudiosLab tbody");
    $(tablePaciente).html("");
    var $pagination = $('#pagEstudiosLab');
    var categoria = $('#cboCategoria').val();
    var txt_filter = $("#txt_filterEstudiosLab").val();
    var cantList = $("#cantListEstudiosLab").val();
    var $totalPages = 0;
    if (txt_filter === "" && categoria === "0") {
        $totalPages = 2;
    } else {
        $.ajax({
            url: 'sEstudioLab',
            type: 'POST',
            async: false,
            data: {
                op: 'list_size',
                filter: txt_filter,
                categoria: categoria
            },
            success: function (response) {
                $totalPages = response / cantList;
                $totalPages = Math.ceil($totalPages);
            }
        });
    }
    $pagination.twbsPagination('destroy');
    $pagination.twbsPagination($.extend({}, defaultOpt, {
        onPageClick: function (event, pag) {
            indexPagEstudioLab(pag, cantList, txt_filter, categoria);
        },
        totalPages: $totalPages
    }));

}
function indexPagEstudioLab(pag, totalList, txt_filter, categoria) {
    var cantList = totalList;
    $.ajax({
        url: 'sEstudioLab',
        type: 'POST',
        async: false,
        data: {
            filter: txt_filter,
            top: cantList,
            categoria: categoria,
            pag: ((pag - 1) * cantList),
            op: 'detalle'
        },
        success: function (response) {
            if (categoria !== "0") {
                $("#tableEstudiosLab").bootstrapTable('hideColumn', 'categoria');
            } else {
                $("#tableEstudiosLab").bootstrapTable('showColumn', 'categoria');
            }
            $("#tableEstudiosLab  tbody").html(response);
            $('table').bootstrapTable('resetView');
        }
    });
}