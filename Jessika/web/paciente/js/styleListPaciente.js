$("table").bootstrapTable();

var xhrRequest = [];

function td_tr_seleccionar(tbody) {
    $.each($(tbody).find("tr"), function (index, tr) {
        var id = $(tr).attr("data-id");
        $(tr).find("td:last").html("");
        $(tr).find("td:last").html('<button name="SeleccionarPaciente" data-dismiss="modal" class="btn btn-info">Seleccionar</button>');
    });
}
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
$.xhrPool = [];
$.xhrPool.abortAll = function () {
    $(this).each(function (idx, jqXHR) {
        jqXHR.abort();
    });
    $.xhrPool.length = 0;
};

function loadList(bandera, pag) {
    /*$.each(xhrRequest, function (idx, jqXHR)
     {
     jqXHR.abort();
     });*/
    //var xhr = null;
    
    
    $.xhrPool.abortAll();
    
    var txt_filter = $("#txt_filterPaciente").val();
    var cantList = $("#cantList").val();
    /*xhr = */ $.ajax({
        url: 'sPaciente',
        type: 'POST',
        beforeSend: function (jqXHR) {
            $.xhrPool.push(jqXHR);
        },
        complete: function (jqXHR) {
            var index = $.xhrPool.indexOf(jqXHR);
            if (index > -1) {
                $.xhrPool.splice(index, 1);
            }
        },
        data: {
            filter: txt_filter,
            top: cantList,
            pag: ((pag - 1) * cantList),
            //pag: 0,
            op: 'list_filter'
        },
        success: function (response) {
            var obj = $.parseJSON(response);
            var tablePaciente = $("#tablePaciente");
            $totalPages = obj.count / cantList;
            $totalPages = Math.ceil($totalPages);
            if (bandera) {
                loadPaginacion($totalPages);
            }
            $(tablePaciente).html(obj.list);
            if ($(tablePaciente).attr("modal") === "1") {

                td_tr_seleccionar(tablePaciente);
            }
            $('#tablPaciente').bootstrapTable('resetView');
        }
    });
    //xhrRequest.push(xhr);
}

$(function () {

    loadList(true, 1);
    

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



    //$('#editPaciente .modal-body').load("paciente/paciente.jsp");

    $("#contenido").on("change", "#cantList", function () {
        loadList(true, 1);
    });
    $("#contenido").on("keyup", "#txt_filterPaciente", function () {
        loadList(true, 1);
    });
    $("#contenido").on("click", "#tablePaciente button[name='deletPaciente']", function () {
        var id = $(this).attr("data-id");
        $.getScript("paciente/js/paciente.js", function () {
            deletPaciente(id);
            loadList(true, 1);
        });
    });

});


$("#contenido").on("click", "#tablePaciente button[name='editPaciente']", function () {
    var id = $(this).attr("data-id");
    $("#contenido").load("paciente/paciente.jsp",function(){
        edit(id);
    });
});