paginacion_Especialidad = ("#pag_tbEspecialidad");
function loadPaginacionEspecialidad(total) {
    $(paginacion_Especialidad + " li a").not("[aria-label]").closest("li").remove();
    li = '';
    for (var c = 0; c < total; c++) {
        li += ('<li ' + ((c === 0) ? 'class="active"' : '') + ' ><a href="#">' + (c + 1) + '</a></li>');
    }
    $(paginacion_Especialidad + " li").first().after(li);
}
$("#tbEspecialidad").bootstrapTable({
    contextMenu: '#tbEspecialidad-context-menu',
    onContextMenuItem: function (row, $el) {
        switch ($el.data("item")) {
            case "edit":
                $("#modalEspecialidad .modal-title").html("Editar Especialidad")
                $("#recipient-name").val(row.descripcion);
                $("#modalEspecialidad").modal("toggle");
                break;
            case "delete":
                $.post('sEspecialidad', {
                    id: row.id,
                    opcion: "delete"
                }, function (responseText) {
                    cargarEspecialidades(1, true);
                    alertify.success("Especialidad eliminada");
                });
                break;
        }
    }
});
function cargarEspecialidades(pagina, bandera) {
    var totalRegistro = $("#cboMostrar_tbEspecialidad").val();
    $.ajax({
        type: 'POST',
        dataType: 'json',
        url: "sEspecialidad",
        data: {
            totalMostrar: totalRegistro,
            pagina: ((pagina - 1) * totalRegistro),
            opcion: '2',
            buscar: $("#txtBuscar").val()
        },
        success: function (data) {
            console.log(data);
            if (bandera)
                loadPaginacionEspecialidad(data.count);
            $("#tbEspecialidad").bootstrapTable("load", data.list);
        }
    });
}
cargarEspecialidades(1, true);
$(function () {
    cargarEspecialidades(1, true);
    
    $("#cboMostrar_tbEspecialidad").on("changed.bs.select", function () {
    cargarEspecialidades(1, true);
});

    $("#contenido").on("click", paginacion_Especialidad + " li a[aria-label]", function (e) {
        li_old = $(paginacion_Especialidad + " li[class='active']");
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
            cargarEspecialidades($(li).find("a").html(), false);
        }
    });
    $("#contenido").on("click", paginacion_Especialidad + " li:not([class='active']) a:not([aria-label])", function (e) {
        li = $(this).closest("li");
        $(paginacion_Especialidad + " li[class='active']").toggleClass("active");
        $(li).toggleClass("active");
        cargarEspecialidades($(this).html(), false);
    });
});


function validaciones() {
    $(".help-block").remove();
    validarText($("#recipient-name"));
    return $(".help-block").length === 0;
}


$("#tbEspecialidad #txtBuscar").keyup(function (event) {
    if ($("#txtBuscar").val().length < 1)
        buscar = 0;
    else
        buscar = 1;
    pagina = 0;

    cargarEspecialidades(pagina, buscar);
});

$('#tbEspecialidad #btnActualizar').click(function (event) {
    validaciones();

    if (bandera === true) {

        var descripcionEspecialidadVar = $('#recipient-name').val();
        var idEspecialidadVar = datos[0];
        $.post('sEspecialidad', {
            descripcionEspecialidad: descripcionEspecialidadVar,
            idEspecialidad: idEspecialidadVar,
            visible: '1',
            opcion: "3"
        }, function (data) {
            var resultado = JSON && JSON.parse(data) || $.parseJSON(data);
            if (resultado.estado === true)
            {
                if (idEspecialidadVar === 0)
                {
                    cargarEspecialidades(pagina, buscar);
                    alertify.success("Especialidad agregada correctamente");
                } else
                {
                    alertify.success("Especialidad Modificada");
                    $($('.table-responsive').find('tbody > tr')[indice]).children('td')[1].innerHTML = $('#recipient-name').val();
                }
                $("#modalEspecialidad").modal('toggle');
            } else
                alertify.success("Problemas al intentar guardar\n" + resultado.excepcion);
        });
    }
});