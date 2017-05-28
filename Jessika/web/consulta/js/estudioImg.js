var defaultOpt = {
    visiblePages: 10,
    first: "Primero",
    next: "Siguiente",
    last: "Ultimo",
    prev: "Anterior"
};
function TipoEstudiosImg_load(cbo) {
    $.ajax({
        url: 'sEstudioImg',
        type: 'POST',
        async: false,
        data: {
            op: 'list_tipoEstudioImg'
        },
        success: function (response) {
            $(cbo).html(response);
            $(cbo).selectpicker('refresh');
        }
    });
}

function EstudiosImg_load(cbo) {
    $.ajax({
        url: 'sEstudioImg',
        type: 'POST',
        async: false,
        data: {
            op: 'list_EstudioImg',
            idTipo: $("#cboTipoEstudiosImg").val()
        },
        success: function (response) {
            $(cbo).html(response);
            $(cbo).selectpicker('refresh');
        }
    });
}

function EstudiosImg_load(cbo) {
    $.ajax({
        url: 'sEstudioImg',
        type: 'POST',
        async: false,
        data: {
            op: 'list_EstudioImg',
            idTipo: $("#cboTipoEstudiosImg").val()
        },
        success: function (response) {
            $(cbo).html(response);
            $(cbo).selectpicker('refresh');
        }
    });
}

function list_filter_estImg() {
    var tableEstudiosImg = $("#tableEstudiosImg tbody");
    $(tableEstudiosImg).html("");
    var $pagination = $('#pagEstudiosImg');
    var txt_filter = $("#txt_filterEstudiosImg").val();
    var cantList = $("#cantListEstudiosImg").val();
    idTipo = $("#cboTipoEstudiosImg").val();
    idEstudio = $("#cboEstudiosImg").val();
    var $totalPages = 0;
    if (txt_filter === "" && idEstudio === 0 && idTipo === 0) {
        $totalPages = 2;
    } else {
        $.ajax({
            url: 'sEstudioImg',
            type: 'POST',
            async: false,
            data: {
                op: 'list_size',
                filter: txt_filter,
                idTipo: idTipo,
                idEstudio: idEstudio
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
            indexPagEstudioImg(pag, cantList, txt_filter, idTipo, idEstudio);
        },
        totalPages: $totalPages
    }));

}

function indexPagEstudioImg(pag, totalList, txt_filter, idTipo, idEstudio) {
    var cantList = totalList;
    $.ajax({
        url: 'sEstudioImg',
        type: 'POST',
        async: false,
        data: {
            filter: txt_filter,
            top: cantList,
            idTipo: idTipo,
            idEstudio: idEstudio,
            pag: ((pag - 1) * cantList),
            op: 'list_DetEstudioImg'
        },
        success: function (response) {
            $("#tableEstudiosImg  tbody").html(response);
            $('#tableEstudiosImg').bootstrapTable('resetView');
        }
    });
}



function prueba() {

    $.ajax({
        url: 'sEstudioImg',
        type: 'POST',
        async: false,
        data: {
            op: 'list_DetEstudioImg',
            idEstudio: $("#cboEstudiosImg").val()
        },
        success: function (response) {
            alert(response);
            $("#tableEstudiosImg tbody").html(response);
            $('#tableEstudiosImg').bootstrapTable('resetView');
            //$(cbo).selectpicker('refresh');
        }
    });
}