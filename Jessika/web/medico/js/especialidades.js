/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


    var datos = [];
    var totalRegistros=0;
    var totalPaginas=0;
    var pagina=1;
    var buscar=0;    
    var indice=0;
    var xhrRequest=[];
    var ultimo=-1;
    var bandera;
    var filas=5;
    function validaciones()
    {
        try {
      
           
            $("#tbEspecialidad .help-block").remove();
            $.each($("#tbEspecialidad input[validate='text']"), function (index, value) {
            if ($(value).val() === null || $(value).val() === "") {
                $(value).closest("div").addClass("has-error");
                $(value).after('<span id="' + $(value).attr("id") + 'help" class="help-block">Campo Vacio</span');
            } else
            {
                $(value).closest("div").removeClass("has-error");
            }
           bandera=$("#tbEspecialidad .help-block").length === 0;
            return $("#tbEspecialidad .help-block").length === 0;
        });
    }
    catch(err)
    {
        alert(err.message);
    }
        
    }
    $("#tbEspecialidad #cboMostrar").val(5);   
    $('#tbEspecialidad #cboMostrar').on('change', function() {    
         pagina=1;
        cargarEspecialidades(pagina,buscar);   
        filas=$('#tbEspecialidad #cboMostrar').val();
    });    
    $("#tbEspecialidad #txtBuscar").keyup(function(event){		            
        if($("#txtBuscar").val().length < 1) 
            buscar=0;
        else
            buscar=1;
         pagina=1;
        
        cargarEspecialidades(pagina,buscar);   
    }); 
    cargarEspecialidades(pagina,buscar);
    
    $("#tbEspecialidad .table-responsive").on("click", "#botonEditar", function(){           
        var cont=0;            
        $(this).parents("tr").find("td").each(function(){
            datos[cont]=$(this).html();   
            cont++;
        });
        $('#tbEspecialidad .modal-title').text('Editar Especialidad');
        var id='modalEspecialidad';
        $("#"+id).modal('show');
        $.each($("#"+id+" input"), function (){
            $(this).val("");
        }); 
        
        $('#recipient-name').val(datos[1]);
    });
    
    $('#tbEspecialidad #btnAgregar').click(function(event) {
        datos[0]=0;
        $('#tbEspecialidad .modal-title').text('Agregar Especialidad');
        var id='modalEspecialidad';
        $("#"+id).modal('show');
        $.each($("#"+id+" input"), function (){
            $(this).val("");
        }); 
       // $('#recipient-name').val(datos[1]);
    });
    
    $("#tbEspecialidad .table-responsive").on("click", "tr", function(){  
        indice = $(this).index();        
      });
      
    $('#tbEspecialidad #btnActualizar').click(function(event) {
       validaciones();
      
        if (bandera===true) {
            
            var descripcionEspecialidadVar = $('#recipient-name').val();
            var idEspecialidadVar = datos[0];
            $.post('sEspecialidad', {
                descripcionEspecialidad : descripcionEspecialidadVar,
                idEspecialidad: idEspecialidadVar,
                visible: '1',
                opcion: "3"
            }, function(responseText) { 
                if(idEspecialidadVar===0)
                {
                    cargarEspecialidades(pagina,buscar);
                    alertify.success("Especialidad agregada correctamente");
                }
                else
                {
                    alertify.success("Especialidad Modificada");
                    $($('.table-responsive').find('tbody > tr')[indice]).children('td')[1].innerHTML = $('#recipient-name').val();
                }
                $("#modalEspecialidad").modal('toggle');
            });
    }
    });
    
    $('#tbEspecialidad .table-responsive').on("click", "#btnEliminar", function(event){ 
        var cont=0;
        $(this).parents("tr").find("td").each(function(){
            datos[cont]=$(this).html();   
            cont++;
        });
        $.post('sEspecialidad', {
            descripcionEspecialidad : datos[1],
            idEspecialidad: datos[0],
            visible: 0,
            opcion: "3"
        }, function(responseText) {
            filas--;
            if(filas===0)
            {
                if(pagina>0)
                    pagina--;
                filas=$('#tbEspecialidad #cboMostrar').val();
            }
            cargarEspecialidades(pagina,buscar);
            alertify.success("Especialidad eliminada");
        });
        event.preventDefault();
        $(this).closest('tr').remove();
    });
    
  
   
    function cargarEspecialidades(pagina,esBuscar)
    {
        var totalRegistro=$("#tbEspecialidad #cboMostrar").val();
        $.each(xhrRequest,function(idx, jqXHR)
        {
            jqXHR.abort();
        });
        var xhr=null;
        xhr=$.post('sEspecialidad', {
            totalMostrar : totalRegistro,
            pagina: pagina,
            opcion: '2',
            bandera:esBuscar,
            buscar:$("#txtBuscar").val()
        }, function(data) {   
            var resultado = JSON && JSON.parse(data) || $.parseJSON(data); 
            var totalPaginas=resultado[0].registros/$("#cboMostrar").val();
            totalPaginas=Math.ceil(totalPaginas);
            filas=resultado.length;
            $('#tbEspecialidad #paginacionEspecialidad').find('li').remove();
            $("#tbEspecialidad #paginacionEspecialidad ul").append('<li id="atras"><a href="#">&laquo;</a></li>');
            var indice=0;
            for(i=0;i <totalPaginas; i++)                
            {
                indice=parseInt(i)+1;
                //<li><a href="#">1</a></li>                
                if(indice==pagina)
                    $("#tbEspecialidad #paginacionEspecialidad ul").append('<li id='+indice+' class="active"><a href="#">'+indice+'</a></li>');
                else 
                    $("#tbEspecialidad #paginacionEspecialidad ul ").append('<li id='+indice+'><a href="#">'+indice+'</a></li>');
            }
            ultimo=indice;
            $("#tbEspecialidad #paginacionEspecialidad ul").append('<li id="adelante" ><a href="#">&raquo;</a></li>');
            $('#tbEspecialidad #especialidades tr').remove();
            $('#tbEspecialidad #especialidades thead').append("<tr>\n\
                                                <th class='col-lg-1'>No.</th>\n\
                                                <th class='col-lg-9'>Descripción</th>\n\
                                                <th class='col-lg-2'>Opción</th>\n\
                                              </tr>");
              
            for(i=0;i <resultado.length; i++)
            {
                $('#tbEspecialidad #especialidades').append("<tr>\n\
                                                <td>"+resultado[i].id+"</td>\n\
                                                <td>"+resultado[i].descripcion+"</td>\n\
                                                <td ><button id='botonEditar' class='btn btn-primary' onclick='openModal('myModal')'><span class='glyphicon glyphicon-pencil'></span> </button>\n\
                                              \n\
      <button id='btnEliminar' class='btn btn-danger'><span class='glyphicon glyphicon-trash'></span></a></button>\n\
                                                </td>\n\
                                            </tr>");
            }
        });        
        xhrRequest.push(xhr);
    }
    $('#tbEspecialidad #paginacionEspecialidad ul').click(function (e) {        
        var a = e.target.parentNode;        
        if(a.id!=="adelante" && a.id!=="atras")
        {
            pagina=a.id;
        }
        if(a.id==="adelante"  && pagina!==ultimo)    
            pagina=parseInt(pagina)+1
        if(a.id==="atras" && pagina!==1)    
            pagina=parseInt(pagina)-1;
        cargarEspecialidades(pagina,buscar);
    });


