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
                            <th rowspan="2" data-field="categoria">Categoria</th>
                            <th rowspan="2" data-field="estudio">Estudio de Imagenes</th>
                            <th colspan="2" data-field="accion">Accion</th>
                            <th rowspan="2" data-field="seleccion">Selec</th>
                        </tr>
                        <tr>
                            <th data-field="name">Item Name</th>
                            <th data-field="price">Item Price</th>
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
                <ul id="pagEstudiosImg" class="pagination"></ul>    
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
                <table id="tableEstudiosImgSelec" data-toggle="table" data-height="300">
                    <thead style="font-weight: bold;">
                        <tr>
                            <th data-field="state" data-checkbox="true"></th>
                            <th data-field="id">ID</th>
                            <th data-field="estudio">Estudio de imagenes</th>
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
    $.getScript("consulta/js/estudioImg.js", function () {
        TipoEstudiosImg_load($("#cboTipoEstudiosImg"));
        EstudiosImg_load($("#cboEstudiosImg"));
    });
    $("#cboTipoEstudiosImg").on("changed.bs.select", function () {
        $.getScript("consulta/js/estudioImg.js", function () {
            EstudiosImg_load($("#cboEstudiosImg"));
        });

    });
</script>