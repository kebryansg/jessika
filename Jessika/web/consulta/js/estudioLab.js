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
        }
    });
}

function list_filter_estLab() {
    $("#tableEstudiosLab tbody").html("");
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
        var defaultOpt = {
            totalPages: $totalPages,
            visiblePages: 10,
            first: "Primero",
            next: "Siguiente",
            last: "Ultimo",
            prev: "Anterior",
            onPageClick: function (event, pag) {
                //alert(pag);
                indexPagEstudioLab(pag, cantList, txt_filter, categoria);
                //indexPagEstudioLab(page, cantList, txt_filter, categoria);
            }
        };
        $pagination.twbsPagination('destroy');
        $pagination.twbsPagination(defaultOpt);
    }

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
            if(categoria !== "0"){
              $("#tableEstudiosLab  thead td:first").hide();  
            }else{
                $("#tableEstudiosLab  thead td:first").show();  
            }
            $("#tableEstudiosLab  tbody").html(response);
        }
    });
}