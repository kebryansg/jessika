/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$('#btnLogin').click(function (e) {
    if(validar())
    {
        $.ajax({
                url: 'sUsuario',
                type: 'POST',
                async: false,
                data: {
                    op: 'login',
                    usuario: $("#txtUsuario").val(),
                    clave: $("#txtClave").val()
                    
                },
                success: function (data) {
                     var resultado = JSON && JSON.parse(data) || $.parseJSON(data);
                     console.log(resultado);
                    if(resultado.login===true)
                        location.href="home.jsp";
                    else
                    {
                         alertify.success("Usuario o Clave Incorecta");
                         $(":input:first").focus();
                     }
                }
            });
    
    }    
        
});
$('#aSalida').click(function (e) {
    location.href="sUsuario?op=close";
});

$("#txtClave").keyup(function (event) {
     var teclaPulsada = event.keyCode;
       if (teclaPulsada == 13)
       {
           $('#btnLogin').click();
       }
});

function validar() {
    $.each($("input[validate='text']"), function (index, value) {     
        $(value).blur(function(){
            validarLogin(value);
        });
        validarLogin(value);
    });
    console.log($(".help-block").length === 0);
    return $(".has-error").length === 0;
}

