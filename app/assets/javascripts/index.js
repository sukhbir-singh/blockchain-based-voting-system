function sign_up(){
  var inputs = document.querySelectorAll('.input_form_sign');
  document.querySelectorAll('.ul_tabs > li')[0].className=""; 
  document.querySelectorAll('.ul_tabs > li')[1].className="active"; 

  document.querySelector('.btn_sign').innerHTML = "SIGN UP";    
  document.forms[0].action="/signup";

  for(var i=0; i<inputs.length; i++){
    if(i == 2){
    }else{  
      document.querySelectorAll('.input_form_sign')[i].className = "input_form_sign d_block";
    }
  } 

  setTimeout( function(){
    for(var d = 0; d < inputs.length ; d++  ) {
      document.querySelectorAll('.input_form_sign')[d].className = "input_form_sign d_block active_inp";  
    }
  },0 );
  
  document.querySelector('.link_forgot_pass').style.opacity = "0";
  document.querySelector('.link_forgot_pass').style.top = "-5px";
  
  setTimeout(function(){
    document.querySelector('.terms_and_cons').style.opacity = "1";
    document.querySelector('.terms_and_cons').style.top = "5px";
  },0);

  setTimeout(function(){
    document.querySelector('.link_forgot_pass').className = "link_forgot_pass d_none";
    document.querySelector('.terms_and_cons').className = "terms_and_cons d_block";
  },0);
}


function sign_in(){
  var inputs = document.querySelectorAll('.input_form_sign');
  document.querySelectorAll('.ul_tabs > li')[0].className = "active"; 
  document.querySelectorAll('.ul_tabs > li')[1].className = ""; 

  document.forms[0].action="/login";
  
  for(var i = 0; i < inputs.length ; i++  ) {
    switch(i) {
      case 1:
        console.log(inputs[i].name);
        break;
      case 2:
        console.log(inputs[i].name);
    default: 
        document.querySelectorAll('.input_form_sign')[i].className = "input_form_sign d_block";
    }
  } 

  setTimeout( function(){
  for(var d = 0; d < inputs.length ; d++  ) {
    switch(d) {
      case 1:
        console.log(inputs[d].name);
        break;
      case 2:
        console.log(inputs[d].name);
      default:
        document.querySelectorAll('.input_form_sign')[d].className = "input_form_sign d_block";  
        document.querySelectorAll('.input_form_sign')[2].className = "input_form_sign d_block active_inp";  
     }
    }
  },0);

  document.querySelector('.terms_and_cons').style.opacity = "0";
  document.querySelector('.terms_and_cons').style.top = "-5px";

  setTimeout(function(){
    document.querySelector('.terms_and_cons').className = "terms_and_cons d_none"; 
    document.querySelector('.link_forgot_pass').className = "link_forgot_pass d_block";
  },0);

  setTimeout(function(){
   document.querySelector('.link_forgot_pass').style.opacity = "1";
   document.querySelector('.link_forgot_pass').style.top = "5px"; 

    for(var d=0; d<inputs.length; d++) {
    switch(d) {
        case 1:
          console.log(inputs[d].name);
          break;
        case 2:
          console.log(inputs[d].name);
          break;
        default:
          document.querySelectorAll('.input_form_sign')[d].className = "input_form_sign";  
      }
    }
   },0);
   document.querySelector('.btn_sign').innerHTML = "SIGN IN";    
}

function submit(e){
  console.log(e.target.innerHTML);
}

window.onload =function(){
  document.querySelector('.cont_centrar').className = "cont_centrar cent_active";
}

function formValidation(){
  var button_string = document.querySelector('.btn_sign').innerHTML;

  var full_name = document.forms[0].full_name.value;
  var adhaar= document.forms[0].adhaar.value;
  var contact= document.forms[0].contact.value;
  var email= document.forms[0].email.value;
  var area= document.forms[0].area.value;
  var dob= document.forms[0].dob.value;
  var password= document.forms[0].password.value;
  var confirm_password= document.forms[0].confirm_password.value;

  if(button_string=="SIGN UP"){
    console.log(full_name+" "+adhaar+" "+contact+" "+email+" "+area+" "+dob+" "+password+" "+confirm_password);
    if(full_name.trim().length>0 && adhaar.trim().length>0 && area.trim().length>0 && contact.trim().length>0 && email.trim().length>0 && password.trim().length>=6 && confirm_password.trim().length>=6 && confirm_password===password)
      return true;
  }else{
    if(email.trim().length>0 && password.trim().length>=6)
      return true;
  }
  
  return false;
}
