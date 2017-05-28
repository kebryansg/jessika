$(document).ready(function () {

    $("#estLab .modal-body").load("consulta/estudiosLab.jsp");
    $("#estImg .modal-body").load("consulta/estudiosImg.jsp");

    $("#estImg").on('hide.bs.modal', function (e) {
        trs = $("#tableEstudiosImgSelec tbody tr[data-index]");
        $.each(trs, function (index, i) {
            if ($(i).find("input[name='ext_estI']").length > 0) {
                if($(i).find("input[name='ext_estI']:checked").length === 0){
                    alert("Informacion incompleta...!");
                    e.preventDefault();
                }
            }
        });
        cant_tr = $("#tableEstudiosImgSelec tbody tr[data-index]").length;
        if (cant_tr === 0) {
            $("#showImgs span").html("Ningun estudio de imagenes.");
            $("#showImgs").removeClass("has-success");
            $("#showImgs").addClass("has-error");
            $("#showImgs button").addClass("btn-danger");
            $("#showImgs button").removeClass("btn-success");

        } else {
            $("#showImgs span").html("Cant. de estudios: " + cant_tr);
            $("#showImgs").removeClass("has-error");
            $("#showImgs").addClass("has-success");
            $("#showImgs button").removeClass("btn-danger");
            $("#showImgs button").addClass("btn-success");
        }
    });


    $('#estLab').on('shown.bs.modal', function () {
        $('#estLab table').bootstrapTable('resetView');
    });
    $('#estImg').on('shown.bs.modal', function () {
        $('#estImg table').bootstrapTable('resetView');
    });


    $('#estLab').on('hidden.bs.modal', function () {
        cant_tr = $("#tableEstudiosLabSelec tbody tr[data-index]").length;
        div_lab = $("#showLabs");
        if (cant_tr === 0) {
            $("#showLabs span").html("Ningun estudio de laboratorio.");
            $("#showLabs").removeClass("has-success");
            $("#showLabs").addClass("has-error");
            $("#showLabs button").addClass("btn-danger");
            $("#showLabs button").removeClass("btn-success");

        } else {
            $("#showLabs span").html("Cant. de estudios: " + cant_tr);
            $("#showLabs").removeClass("has-error");
            $("#showLabs").addClass("has-success");
            $("#showLabs button").removeClass("btn-danger");
            $("#showLabs button").addClass("btn-success");
        }
    });
    
    
    



    $("#btnCancelarConsulta").click(function () {
        $("#contenido").load("consulta/ListHistorialC.jsp");
    });

    $("#btnGuardarConsulta").click(function () {
        $.getScript("consulta/js/consulta.js", function () {
            //console.log(obtenerEstudiosImg());
            saveConsulta();
        });
    });


});

