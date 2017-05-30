<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="container-fluid">
    <div class="row">
        <div class="pull-right ">
            <div class="col-md-12">
                
                <div class="form-inline">
                    <input class="form-control" id="txt_filterEstudiosImg" placeholder="Buscar">
                    <select class="selectpicker" data-width="150px" id="cboTipoEstudiosImg"></select>
                    <select class="selectpicker" data-width="150px" id="cboEstudiosImg"></select>
                </div>
            </div>
        </div>
        <div class="pull-left">
            <div class="col-md-12">
                <div class="form-inline">
                    <label for="txt_filterPaciente" class="control-label">Mostrar</label>
                    <select class="selectpicker" data-width="80px" id="cantListEstudiosImg">
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
                <table data-toggle="table" data-height="300" id="tableEstudiosImg">
                    <thead style="font-weight: bold;">
                        <tr>
                            <th data-field="tipoEstudio">Tipo Estudio</th>
                            <th data-field="estudio">Estudio de Imagenes</th>
                            <th data-field="accion">Accion</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>

        </div>       
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="pull-right">
                <ul id="pagEstudiosImg" class="pagination"></ul>    
            </div>

        </div>
    </div>
    <hr>
    <div class="row">
        <div class="col-md-12">
            <div class="pull-left">
                <button id="btnRemoverEstImg" class="btn btn-default">Remover</button>    
            </div>    
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">

            <div class="table-responsive">
                <table id="tableEstudiosImgSelec" data-toggle="table" data-height="300">
                    <thead style="font-weight: bold;">
                        <tr>
                            <th rowspan="2" data-valign="middle" data-field="state" data-checkbox="true"></th>
                            <th rowspan="2" data-valign="middle" data-field="id" data-align="center" >ID</th>
                            <th rowspan="2" data-valign="middle" data-field="tipoEstudio">Tipo estudio</th>
                            <th rowspan="2" data-valign="middle" data-field="estudio">Estudio de imagenes</th>
                            <th colspan="2" data-halign="center"  >Accion</th>
                        </tr>
                        <tr>
                            <th data-field="der" data-align="center">Der.</th>
                            <th data-field="izq" data-align="center">Izq.</th>
                        </tr>
                    </thead>
                    <tbody>

                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" >
    
    $("#tableEstudiosImg").bootstrapTable();
    $("#tableEstudiosImgSelec").bootstrapTable();
    $("#cantListEstudiosImg").selectpicker('refresh');
    
    
    $.getScript("consulta/js/estudioImg.js", function () {
        TipoEstudiosImg_load($("#cboTipoEstudiosImg"));
        EstudiosImg_load($("#cboEstudiosImg"));
        list_filter_estImg();
    });
    $("#cboTipoEstudiosImg").on("changed.bs.select", function () {
        $.getScript("consulta/js/estudioImg.js", function () {
            EstudiosImg_load($("#cboEstudiosImg"));
        });
    });

    $("#cboEstudiosImg").on("changed.bs.select", function () {
        $.getScript("consulta/js/estudioImg.js", function () {
            list_filter_estImg();
        });
    });
    $("#txt_filterEstudiosImg").keyup(function () {
        list_filter_estImg();
    });
    $("#cboTipoEstudiosImg").on("changed.bs.select", function () {
        list_filter_estImg();
    });

    $("#cantListEstudiosImg").on("changed.bs.select", function () {
        list_filter_estImg();
    });

    $("#tableEstudiosImg").on("click", "button[name='estimg']", function () {
        ext = $(this).attr("data-ext");
        var rows = [];
        var tr = $(this).closest("tr");//.find("td:eq("+ ((cat === "0")? "1":"0") +")");
        tr_push = {
            id: $(tr).attr("data-id"),
            tipoEstudio: $(tr).find("td:eq(0)").html(),
            estudio: $(tr).find("td:eq(1)").html()
        };
        if (ext === "1") {
            $.extend(true, tr_push, {
                der: '<input type="checkbox" name="ext_estI" data-dir="der" >', 
                izq: '<input type="checkbox" name="ext_estI" data-dir="izq">'
            });
        }
        rows.push(tr_push);
        bandera = true;
        $.each($("#tableEstudiosImgSelec tbody tr"), function (index, trs) {
            if ($(trs).find("td:eq(1)").html() === $(tr).attr("data-id")) {
                bandera = false;
                return;
            }
        });
        if (bandera) {
            $("#tableEstudiosImgSelec").bootstrapTable("append", rows);
        }
    });
    $('#btnRemoverEstImg').click(function () {
        var ids = $.map($("#tableEstudiosImgSelec").bootstrapTable('getSelections'), function (row) {
            return row.id;
        });
        $("#tableEstudiosImgSelec").bootstrapTable('remove', {
            field: 'id',
            values: ids
        });
    });

    //$("#tableEstudiosImgSelec").bootstrapTable('mergeCells', {index: 1, field: 'der', colspan: 2, rowspan: 0});

</script>