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