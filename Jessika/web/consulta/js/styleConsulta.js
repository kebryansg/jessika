


$(document).ready(function () {

    $("#estLab .modal-body").load("consulta/estudiosLab.jsp");

    $('#estLab').on('shown.bs.modal', function () {
        $('#estLab table').bootstrapTable('resetView');
    });

    /*$("#contenido").on("click","#btnCancelarConsulta",function(){
     alert();
     });*/

    $("#btnCancelarConsulta").click(function () {
        $("#contenido").load("consulta/ListHistorialC.jsp");
        //alert();
    });


});

