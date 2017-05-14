<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<style> 
    /*tbody {
        display: block;
        height: 40vh;
        min-height: 200px;
        overflow-y: scroll;
    }
    tr {
        display: block;
        overflow: hidden;
    }
    thead td{
        width: 100%;
    }*/

    tbody tr {
        display: inline-table;
        table-layout: fixed;
    }

    table{
        height:300px;              
        display: -moz-groupbox; 
    }
    tbody{
        overflow-y: scroll;      
        height: 40vh;
        min-height: 200px;
        position: absolute;
    }



</style>

<div class="container-fluid">
    <div class="row">
        <div class="pull-right">
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
                <table class="table table-hover table-striped" id="tableEstudiosLab">
                    <thead style="font-weight: bold;">
                        <tr>
                            <td class="col-md-2" >Categoria</td>
                            <td class="col-md-7">Estudio de laboratorio</td>
                            <td class="col-md-2">Selecciòn</td>
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
            <div class="table-responsive">
                <table class="table table-hover table-striped">
                    <thead style="font-weight: bold;">
                        <tr>
                            <td class="col-md-8">Estudio de laboratorio</td>
                            <td class="col-md-1">Eliminar</td>
                        </tr>
                    </thead>
                    <tbody id="tableEstudiosLabSelec"></tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script src="resources/js/configuracionInicial.js" type="text/javascript"></script>                        
<script type="text/javascript" >
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
        var tr = $(this).closest("tr");//.find("td:eq("+ ((cat === "0")? "1":"0") +")");
        html = "<tr data-id='" + $(tr).attr("data-id") + "'><td class='col-md-8'>" + $(tr).find("td:eq(" + ((cat === "0") ? "1" : "0") + ")").html() + "</td><td class='col-md-1'><button class='btn btn-danger' name='estlab_del'>Eliminar</button></td></tr>";
        if ($("#tableEstudiosLabSelec tr[data-id='" + $(tr).attr("data-id") + "']").length === 0) {
            $("#tableEstudiosLabSelec").append(html);
        }
    });
    $("#tableEstudiosLabSelec").on("click", "button[name='estlab_del']", function () {
        $(this).closest("tr").remove();
    });

</script>


