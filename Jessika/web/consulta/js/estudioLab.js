var xhrRequest_estudioLab = [];

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
    //totalPages: $totalPages,
    visiblePages: 10,
    first: "Primero",
    next: "Siguiente",
    last: "Ultimo",
    prev: "Anterior"
            /*onPageClick: function (event, pag) {
             indexPagEstudioLab(pag, cantList, txt_filter, categoria);
             }*/
};
function list_filter_estLab() {
    var tablePaciente = $("#tableEstudiosLab tbody");
    $(tablePaciente).html("");
    var $pagination = $('#pagEstudiosLab');
    var categoria = $('#cboCategoria').val();
    var txt_filter = $("#txt_filterEstudiosLab").val();
    var cantList = $("#cantListEstudiosLab").val();
    if (txt_filter === "" && categoria === "0") {
        indexPagEstudioLab(1, cantList, txt_filter, categoria);
        $pagination.twbsPagination('destroy');
    } else {
        var $totalPages = 0;
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
        $pagination.twbsPagination('destroy');
        $pagination.twbsPagination($.extend({}, defaultOpt, {
            onPageClick: function (event, pag) {
                indexPagEstudioLab(pag, cantList, txt_filter, categoria);
            },
            totalPages: $totalPages
        }));
    }

}
function indexPagEstudioLab(pag, totalList, txt_filter, categoria) {
    $.each(xhrRequest_estudioLab, function (idx, jqXHR)
    {
        jqXHR.abort();
    });
    var xhr_estudioLab = null;
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
    //xhr_estudioLab.push(xhr_estudioLab);

}