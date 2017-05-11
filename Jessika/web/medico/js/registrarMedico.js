/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var bandera=0;
    function validar() {
    /* Validacion de email */
    
    var email = $("#tabMedicoRegistro input[validate='email']");
    $(email).blur(function(){    		               
                validarText(email);
	});
   validarEmail(email);
    /* Validacion de email */

    $.each($("#tabMedicoRegistro input[validate='text']"), function (index, value) {  
       $(value).blur(function(){    		               
                validarText(value);
	});
        validarText(value);
    });
    
    $.each($("#tabMedicoRegistro select[validate='select']"), function (index, value) {
        $(value).on('change', function() { 
             validarSelect(value);
        });
        
       validarSelect(value); 
    });
    $.each($("#tabMedicoRegistro input[validate='date']"), function (index, value) {
        if ($(value).val() === null || $(value).val() === "") {
            $(value).closest("div").addClass("has-error");
            $(value).parent("div").after('<span id="' + $(value).attr("id") + 'help" style="color:#a94442;" class="help-block">Sin Fecha</span');
        } else
        {
            $(value).closest("div").removeClass("has-error");
        }
    });
 
    return $("#tabMedicoRegistro .help-block").length === 0;
}
function validarText(value)
{
    
     if($(value).attr("id")!=="txtCedula" || $(value).val() === "")
     {
          var valor= "#"+$(value).attr("id") + 'help';           
          $(valor).remove();
        if ($(value).val() === null || $(value).val() === "") {
            $(value).closest("div").addClass("has-error");
            $(value).after('<span id="' + $(value).attr("id") + 'help" class="help-block">Campo Vacio</span');
        } else
        {
            $(value).closest("div").removeClass("has-error");            
          
        }
    }
}
function validarEmail(email)  
{
    var validacion_email = /^[a-zA-Z0-9_\.\-]+@[a-zA-Z0-9\-]+\.[a-zA-Z0-9\-\.]+$/;
     var valor= "#"+$(email).attr("id") + 'help'; 
         $(valor).remove();
     if ($(email).val() === null || $(email).val() === "" || !validacion_email.test($(email).val())) {
        $(email).closest("div").addClass("has-error");
        $(email).after('<span id="' + $(email).attr("id") + 'help" class="help-block">Email no valido.</span');
    } else {
        $(email).closest("div").removeClass("has-error");
        
    }
}
function validarSelect(value)
{
    var valor= "#"+$(value).attr("id") + 'help'; 
         $(valor).remove();
   if ($(value).val() === "0" || $(value).val() === null ) {
            $(value).closest("div").addClass("has-error");
            $(value).after('<span id="' + $(value).attr("id") + 'help" class="help-block">Sin seleccionar</span');
        } else
        {
            $(value).closest("div").removeClass("has-error");
        } 
}
function validarCedula()
    {
       
         $.ajax({
            type: 'Post',
            url: 'sMedico',
            data: {
                cedula : $('#tabMedicoRegistro #txtCedula').val(),                
                opcion:'6'
            },
            async: false,
            success:function(response){
                $("#tabMedicoRegistro #txtCedulahelp").remove();  
                if(response>0)
                {   
                    
                    $("#tabMedicoRegistro #txtCedula").closest("div").addClass("has-error");                    
                    $("#tabMedicoRegistro #txtCedula").after('<span id="' + $("#txtCedula").attr("id") + 'help" class="help-block">Cédula ya registrada</span');
                    
                }
                else 
                {
                    
                    $("#tabMedicoRegistro #txtCedula").closest("div").removeClass("has-error");
                                       
                    
                }
            }
        }); 
    }
    function limpiar()
    {
        $('#tabMedicoRegistro :text').val('');
       // $(':email').val('');
        $('#tabMedicoRegistro textarea').val('');
        $("#tabMedicoRegistro #txtEmail").val('');
        $('#tabMedicoRegistro .selectpicker').selectpicker('deselectAll');
        $.each($("#tabMedicoEditar select[validate='select']"), function (index, value) {
            $(value).closest("div").removeClass("has-error");
     });
    $("#tabMedicoRegistro .help-block").remove();

    }
    limpiar();
    $('#tabMedicoRegistro #btnGuardar').click(function(event) {
        if (validar()) {
        $.ajax({
            type: 'Post',
            url: 'sMedico',
            data: {
                cedula : $('#tabMedicoRegistro #txtCedula').val(),
                primerNombre: $('#tabMedicoRegistro #txtPrimerNombre').val(),
                segundoNombre: $('#tabMedicoRegistro #txtSegundoNombre').val(),
                primerApellido: $('#tabMedicoRegistro #txtPrimerApellido').val(),
                segundoApellido: $('#tabMedicoRegistro #txtSegundoApellido').val(),
                domicilio: $('#tabMedicoRegistro #txtDomicilio').val(),
                ciudad: $('#tabMedicoRegistro #txtCiudad').val(),
                telefonoOficina: $('#tabMedicoRegistro #txtTelefonoOficina').val(),
                email: $('#tabMedicoRegistro #txtEmail').val(),
                telefonoDomicilio: $('#tabMedicoRegistro #txtTelefonoDomicilio').val(),
                telefonoMovil: $('#tabMedicoRegistro #txtTelefonoMovil').val(),
                idEspecialidad: $("#tabMedicoRegistro #cboEspecialidad").val(),
                visible:'1',
                opcion:'0'
            },
            async: false,
            success:function(response){ 
                alertify.success("Medico registrado correctamente");
                limpiar();
            }
        }); 
    }
    });



