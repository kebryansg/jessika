paginacion_Consultas = ("#pag_tbConsultas");
function loadPaginacionConsultas(total) {
    //$(paginacion_Consultas + " li").not("a[aria-label]").remove();
    $.each($(paginacion_Consultas + " li"), function (i, li) {
        if ($(li).find("a[aria-label]").length === 0) {
            $(li).remove();
        }
    });
    li = '';
    for (var c = 0; c < total; c++) {
        li += ('<li ' + ((c === 0) ? 'class="active"' : '') + ' ><a href="#">' + (c + 1) + '</a></li>');
    }
    $(paginacion_Consultas + " li").first().after(li);
}

$(function () {
    $("#tbConsultas").bootstrapTable();
    $(".selectpicker").selectpicker('refresh');
    //2021 hc
    //0 sin hc
    adminGet(true, 1);
    //getConsultasTiempo(2017, 3, 0, "");


    $("#contenido").on("click", paginacion_Consultas + " li a[aria-label]", function (e) {
        li_old = $(paginacion_Consultas + " li[class='active']");
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
            adminGet(false, $(li).find("a").html());
        }
    });
    $("#contenido").on("click", paginacion_Consultas + " li:not([class='active']) a:not([aria-label])", function (e) {
        li = $(this).closest("li");
        $(paginacion_Consultas + " li[class='active']").toggleClass("active");
        $(li).toggleClass("active");
        adminGet(false, $(this).html());
    });

    $("#cantList").on("changed.bs.select", function () {
        //loadListEstudiosLab(true, 1);
        adminGet(true, 1);
    });


});

function adminGet(bandera, pag) {
    idHC = 0;
    tiempo = 3;
    switch (tiempo) {
        case 1:
            break;
        case 2:
            // Mes
            getConsultasTiempo(bandera, pag, 6, tiempo, idHC, "");
            break;
        case 3:
            // Año
            getConsultasTiempo(bandera, pag, 2017, tiempo, idHC, "");
            break;
    }
}

function getConsultasTiempo(bandera, pag, tiempo, opTiempo, idHC, filter) {
    cantList = $("#cantList").val();
    $.ajax({
        url: "sConsulta",
        type: 'POST',
        dataType: 'json',
        async: false,
        data: {
            op: 'adminConsultas',
            tiempo: tiempo,
            opTiempo: opTiempo,
            idHC: idHC,
            filter: filter,
            pag: ((pag - 1) * cantList),
            top: cantList
        },
        success: function (data) {
            if (bandera)
                loadPaginacionConsultas(data.count);
            $("#tbConsultas").bootstrapTable("load", data.list);
        }
    });
}

function getConsultas_Fechas(tiempo, idHC, op) {
    $.ajax({
        url: "sConsulta",
        type: 'POST',
        dataType: 'json',
        async: false,
        data: {
            op: 'adminConsultas'
        },
        success: function (data) {
            $("#tbConsultas").bootstrapTable("load", data.list);
        }
    });
}