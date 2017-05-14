<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
                <table class="table table-bordered table-hover table-striped" id="tableEstudiosLab">
                    <thead style="font-weight: bold;">
                        <tr>
                            <td style="width: 15%;" >Categoria</td>
                            <td>Estudio de laboratorio</td>
                            <td style="width: 15%;">Selecciòn</td>
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
        <div class="table-responsive">
            <table class="table table-bordered table-hover table-striped">
                <thead style="font-weight: bold;">
                    <tr>
                        <td>Estudio de laboratorio</td>
                        <td style="width: 10%;">Eliminar</td>
                    </tr>
                </thead>
                <tbody id="tableEstudiosLabSelec"></tbody>
            </table>
        </div>
    </div>
</div>

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
        html = "<tr data-id='" + $(tr).attr("data-id") + "'><td>" + $(tr).find("td:eq(" + ((cat === "0") ? "1" : "0") + ")").html() + "</td><td><button class='btn btn-danger' name='estlab_del'>Eliminar</button></td></tr>";
        if ($("#tableEstudiosLabSelec tr[data-id='" + $(tr).attr("data-id") + "']").length === 0) {
            $("#tableEstudiosLabSelec").append(html);
        }
    });
    $("#tableEstudiosLabSelec").on("click", "button[name='estlab_del']", function () {
        $(this).closest("tr").remove();
    });

</script>


