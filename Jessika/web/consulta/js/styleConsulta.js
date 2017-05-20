$(document).ready(function () {

    $("#estLab .modal-body").load("consulta/estudiosLab.jsp");

    $('#estLab').on('shown.bs.modal', function () {
        $('#estLab table').bootstrapTable('resetView');
    });
    
    $('#estLab').on('hidden.bs.modal', function () {
        cant_tr = $("#tableEstudiosLabSelec tbody tr[data-index]").length;
        div_lab = $("#showLabs");
        if(cant_tr === 0){
            $("#showLabs span").html("Ningun estudio de laboratorio.");
            $("#showLabs").removeClass("has-success");
            $("#showLabs").addClass("has-error");
            $("#showLabs button").addClass("btn-danger");
            $("#showLabs button").removeClass("btn-success");
            
        }
        else{
            $("#showLabs span").html("Cant. de estudios: " + cant_tr);
            $("#showLabs").removeClass("has-error");
            $("#showLabs").addClass("has-success");
            $("#showLabs button").removeClass("btn-danger");
            $("#showLabs button").addClass("btn-success");
        }
    });

    

    $("#btnCancelarConsulta").click(function () {
        $("#contenido").load("consulta/ListHistorialC.jsp");
        //alert();
    });


});

