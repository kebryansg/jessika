var xhrRequest=[];
var idHistoria=0;
var totalRegistros = 0;
var totalPaginas = 0;
var paginasVisibles = 5;
var paginaActual = 1;
var buscar = 0;
var pagina=1;
var ultimo=-1;
$("#tabIngresos #cboMostrar").val(5);
limpiar();
$("#tabIngresos #txtBuscar").keyup(function (event) {
    if ($("#txtBuscar").val().length < 1)
        buscar = 0;
    else
        buscar = 1;
    pagina=1;
    cargarPacientes(pagina,buscar);
});
function validarIngreso()
{
    $("#tabIngresos .help-block").remove();
    $.each($("#tabIngresos input[validate='date']"), function (index, value) {
        $(value).change(function(){    		               
                validarDateIngresos(value);
	});
        validarDateIngresos(value);
        
    });
    $('#tabIngresos #txtCodigoCie').blur(function(){    		               
        validarCodigo();
    });
    validarCodigo();
    validarDefinitivoEgreso();
    $('#tabIngresos #txtDefinitivoEgreso').blur(function(){    		               
        validarDefinitivoEgreso();
    });
    if(idHistoria==0)
    {
        $('#tabIngresos #txtCedula').closest("div").addClass("has-error");
        $('#tabIngresos #txtCedula').after('<span id="' + $('#tabIngresos #txtCedula').attr("id") + 'help" class="help-block">Cargar un paciente</span');
     
    }
    else
    {
        $('#tabIngresos #txtCedula').closest("div").removeClass("has-error");
        
    }
    return $("#tabIngresos .help-block").length === 0;
}
function validarCodigo()
{
    $("#tabIngresos #txtCodigoCiehelp").remove(); 
    if ($('#tabIngresos #txtCodigoCie').val() === null || $('#tabIngresos #txtCodigoCie').val()==="" )
        {
            $('#tabIngresos #txtCodigoCie').closest("div").addClass("has-error");
            $('#tabIngresos #txtCodigoCie').after('<span id="' + $('#tabIngresos #txtCodigoCie').attr("id") + 'help" class="help-block">Campo Vacio</span');
        }
        else
        {
            $('#tabIngresos #txtCodigoCie').closest("div").removeClass("has-error");
        }
}
function validarDefinitivoEgreso()
{
    $("#tabIngresos #txtDefinitivoEgresohelp").remove();  
    if ($('#tabIngresos #txtDefinitivoEgreso').val() === null || $('#tabIngresos #txtDefinitivoEgreso').val()==="" )
        {
            $('#tabIngresos #txtDefinitivoEgreso').closest("div").addClass("has-error");
            $('#tabIngresos #txtDefinitivoEgreso').after('<span id="' + $('#tabIngresos #txtDefinitivoEgreso').attr("id") + 'help" class="help-block">Campo Vacio</span');
        }
        else
        {
            $('#txtDefinitivoEgreso').closest("div").removeClass("has-error");
        }
}
function validarDateIngresos(value)
{
    if ($(value).val() === null || $(value).val() === "") {
            $(value).closest("div").addClass("has-error");
            $(value).parent("div").after('<span id="' + $(value).attr("id") + 'help" style="color:#a94442;" class="help-block">Sin Fecha</span');
        } else
        {
            $(value).closest("div").removeClass("has-error");
            $("#"+$(value).attr("id") + 'help').remove();
        }
}
$('#btnBuscar').click(function (event) {    
    cargarPacientes(pagina,buscar);
});
$('#tabIngresos #cboMostrar').on('change', function () {
    pagina=1;
    cargarPacientes(pagina,buscar);
});
function momentToDate(varMoment, formato)
{
    var dateObj = new Date(varMoment);
    var momentObj = moment(dateObj);
    return momentObj.format(formato);

}
function limpiar()
{
    $(':text').val('');
    $('textarea').val('');
    //$('#tabIngresos tr:not(:first-child)').remove();
}


$('#tabIngresos #btnCargar').click(function (event) {
    var cedula = $("#tabIngresos #txtCedula").val();
    $.ajax({
        type: 'Post',
        url: 'sIngresosHospital',
        data: {
            opcion: '1',
            cedula: cedula
        },

        async: false,
        success: function (data) {
            //shows the relevant data of your login result object in json format                
            var resultado = JSON && JSON.parse(data) || $.parseJSON(data);
            //alert(loginResult.id);
            if(resultado.id==0)
            {
                $("#tabIngresos #txtCedula").focus();
                alertify.success("Paciente no encontrado");
            }
            else
            {
            $("#tabIngresos #txtPaciente").val(resultado.paciente);
            idHistoria = resultado.id;
            $('#tabIngresos #txtCedula').closest("div").removeClass("has-error");
            }
            

        }
    });
    });
    
  
  
    function cargarPacientes(pagina,esBuscar)
    {
        $.each(xhrRequest,function(idx, jqXHR)
        {
            jqXHR.abort();
        });
        var totalRegistro=$("#tabIngresos #cboMostrar").val();
        var xhr=null;
        xhr=$.post('sIngresosHospital', {
            totalMostrar : totalRegistro,
            pagina: pagina,
            opcion: '4',
            bandera:esBuscar,
            buscar:$("#tabIngresos #txtBuscar").val()
        }, function(data) {  
            $('#tabIngresos #paginacionBuscarIngresos').find('li').remove();
           $('#tabIngresos #tablaPacientes tr').remove();
            var resultado = JSON && JSON.parse(data) || $.parseJSON(data); 
            var totalPaginas=resultado[0].registros/$("#tabIngresos #cboMostrar").val();
            totalPaginas=Math.ceil(totalPaginas);
            $("#tabIngresos #paginacionBuscarIngresos ul").append('<li id="atras"><a href="#">&laquo;</a></li>');
            var indice=0;
            for(i=0;i <totalPaginas; i++)                
            {
                indice=parseInt(i)+1;
                //<li><a href="#">1</a></li>                
                if(indice==pagina)
                    $("#tabIngresos #paginacionBuscarIngresos ul").append('<li id='+indice+' class="active"><a href="#">'+indice+'</a></li>');
                else 
                    $("#tabIngresos #paginacionBuscarIngresos ul ").append('<li id='+indice+' ><a href="#">'+indice+'</a></li>');
            }
            ultimo=indice;
            $("#tabIngresos #paginacionBuscarIngresos ul").append('<li id="adelante"><a href="#">&raquo;</a></li>');
            
            $('#tabIngresos #tablaPacientes thead').append("<tr>\n\
                                                <th style='display: none'></th>\n\
                                                <th class='col-lg-1'>No.</th>\n\
                                                <th class='col-lg-3'>Cédula</th>\n\
                                                <th class='col-lg-4'>Apellidos</th>\n\
                                                <th class='col-lg-4'>Nombres</th>\n\
                                                <th class='col-lg-4'>Opción</th>\n\
                                             </tr>");
            var resultado = JSON && JSON.parse(data) || $.parseJSON(data);  
            for(i=0;i <resultado.length; i++)
            {
                $('#tabIngresos #tablaPacientes ').append("<tr>\n\
                                                <td style='display: none'>"+resultado[i].idPaciente+"</td>\n\
                                                <td>"+resultado[i].id+"</td>\n\
                                                <td>"+resultado[i].cedula+"</td>\n\
                                                <td>"+resultado[i].apellido1+" "+resultado[i].apellido2+"</td>\n\
                                                <td>"+resultado[i].nombre1+" "+resultado[i].nombre2+"</td>\n\
                                                <td style='width: 20%' ><button id='btnSeleccionar' type=\"button\" class='btn btn-primary'><span>Seleccionar</span> </button></td>\n\
                                             </tr>");
            }
        });        
        xhrRequest.push(xhr);
        $("#myModal").modal('show');
    }
    
    $('#paginacionBuscarIngresos ul').click(function (e) {        
        var a = e.target.parentNode;        
        if(a.id!=="adelante" && a.id!=="atras")
        {
            pagina=a.id;
        }
        if(a.id==="adelante"  && pagina!==ultimo)    
            pagina=parseInt(pagina)+1
        if(a.id==="atras" && pagina!==1)    
            pagina=parseInt(pagina)-1;
        cargarPacientes(pagina,buscar)
    });
    $("#tabIngresos .table-responsive").on("click", "#btnSeleccionar", function(){ 
        var cont=0;
        var datos=[];
        $(this).parents("tr").find("td").each(function(){
            datos[cont]=$(this).html();                   
            cont++;
        });
        idHistoria=datos[1];
        $("#tabIngresos #txtCedula").val(datos[2]);
        $("#tabIngresos #txtPaciente").val(datos[3]+' '+datos[4]);
        $('#tabIngresos #txtCedula').closest("div").removeClass("has-error");
         $("#tabIngresos #txtCedulahelp").remove();  
        closeModal("myModal");
    });
    
    $('#tabIngresos #btnGuardar').click(function(event) {   
         if (validarIngreso()) {
        $.post('sIngresosHospital', {            
            idHistoria : idHistoria,
            fechaIngreso: $("#tabIngresos #dtpFechaIngreso").val(),
            idTipoIngreso: 2,
            idEspecialidadEgreso: $('#tabIngresos #cboEspecialidadEgreso').val(),
            fechaEgreso: $("#tabIngresos #dtpFechaEgreso").val(),
            horaIngreso: $("#tabIngresos #dtpHoraIngreso").val(),
            sos: 0,
            condicionEgreso: $("#tabIngresos #cboCondicionEgreso").val(),
            definitivoEgreso: $("#tabIngresos #txtDefinitivoEgreso").val(),
            secundarioEgreso: $("#tabIngresos #txtSecundarioEgreso").val(),
            secundarioEgreso2: $("#tabIngresos #txtSecundarioEgreso2").val(),
            causaExterna: $("#tabIngresos #txtCausaExterna").val(),
            codigoDiagnosticoDefinitivo:$("#tabIngresos #txtCodigoCie").val(),
            opcion:'2'                                
        }, function(responseText) {   
            console.log(responseText);        
            limpiar();
            alertify.success("Datos Registrados correctamente");
        });
    }
    });
