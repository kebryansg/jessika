<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="container-fluid">
    <div class="row">
        <div class="pull-right ">
            <div class="col-md-12">

                <div class="form-inline">
                    <input class="form-control" id="txt_filterEstudiosLab" placeholder="Buscar">
                    <select class="selectpicker" data-width="150px" id="cboCategoria">

                    </select>
                </div>
            </div>
        </div>
        <div class="pull-left">
            <div class="col-md-12">
                <div class="form-inline">
                    <label for="txt_filterPaciente" class="control-label">Mostrar</label>
                    <select class="selectpicker" data-width="80px" id="cantListEstudiosLab">
                        <option value="5">5</option>
                        <option value="10">10</option>
                        <option value="20">20</option>
                        <option value="30">30</option>
                    </select>
                </div>
            </div>

        </div>
    </div>    
    <br>
    <div class="row">
        <div class="col-md-12">
            <div class="table-responsive">
                <table data-toggle="table" data-height="300" id="tableEstudiosLab">
                    <thead style="font-weight: bold;">
                        <tr>
                            <th data-field="categoria">Categoria</th>
                            <th data-field="estudio">Estudio de laboratorio</th>
                            <th data-field="seleccion">Accion</th>
                        </tr>
                    </thead>
                    <tbody ></tbody>
                </table>
            </div>

        </div>       
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="pull-right">
                <ul id="pagEstudiosLab" class="pagination"></ul>    
            </div>

        </div>
    </div>
    <hr>
    <div class="row">
        <div class="col-md-12">
            <div class="pull-left">
                <button id="button" class="btn btn-default">Remover</button>    
            </div>    
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">

            <div class="table-responsive">
                <table id="tableEstudiosLabSelec" data-toggle="table" data-height="300">
                    <thead style="font-weight: bold;">
                        <tr>
                            <th data-field="state" data-checkbox="true"></th>
                            <th data-field="id">ID</th>
                            <th data-field="estudio">Estudio de laboratorio</th>
                        </tr>
                    </thead>
                    <tbody ></tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script src="resources/bootstrap/table/bootstrap-table.min.js" type="text/javascript"></script>
<script src="resources/js/configuracionInicial.js" type="text/javascript"></script>
<script type="text/javascript" >
    //$("#tableEstudiosLabSelec").bootstrapTable("hideColumn", "id");
    $('#button').click(function () {
        var ids = $.map($("#tableEstudiosLabSelec").bootstrapTable('getSelections'), function (row) {
            return row.id;
        });
        $("#tableEstudiosLabSelec").bootstrapTable('remove', {
            field: 'id',
            values: ids
        });
    });


    $.getScript("consulta/js/estudioLab.js", function () {
        cboCategoria_load($("#cboCategoria"));
        list_filter_estLab();
    });

    $("#cboCategoria").on("changed.bs.select", function () {
        list_filter_estLab();
    });

    $("#cantListEstudiosLab").on("changed.bs.select", function () {
        list_filter_estLab();
    });
    $("#txt_filterEstudiosLab").keyup(function () {
        list_filter_estLab();
    });
    $("#tableEstudiosLab").on("click", "button[name='estlab']", function () {
        cat = $("#cboCategoria").val();
        var rows = [];
        var tr = $(this).closest("tr");//.find("td:eq("+ ((cat === "0")? "1":"0") +")");
        rows.push({
            id: $(tr).attr("data-id"),
            estudio: $(tr).find("td:eq(" + ((cat === "0") ? "1" : "0") + ")").html()
        });
        bandera = true;
        $.each($("#tableEstudiosLabSelec tbody tr"), function (index, trs) {
            if ($(trs).find("td:eq(1)").html() === $(tr).attr("data-id")) {
                bandera = false;
                return;
            }
        });
        if (bandera) {
            $("#tableEstudiosLabSelec").bootstrapTable("append", rows);
        }
    });
    $("#tableEstudiosLabSelec").on("click", "button[name='estlab_del']", function () {
        $(this).closest("tr").remove();
    });

</script>


