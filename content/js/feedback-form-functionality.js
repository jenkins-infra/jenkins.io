// On loading up the window's content, this JavaScript code stores the value
// of the current page's URL in the variable "feedbackPageUrl" in the
// browser's local storage.

if (typeof feedbackForm === 'undefined') {
  console.log('No "feedbackForm" with "formKey" and "start" functions has been defined in the HTML file that imports this "feedback-form-functionality.js" file.');
  var feedbackForm = { start : function() {} };
}
else {
  feedbackForm.start = function(currentUrl) {
    var ref = document.getElementById('current-url');
    // console.log('Value of "start" function is:' + currentUrl);
    ref.value = currentUrl;
    localStorage.setItem("feedbackPageUrl",ref.value);
  };
}

// This JavaScript code requires the user to add 2 integers (i.e. first <= 10
// and the next <= 10) together in order to successfully submit the form. This
// is a type of client-side CAPTCHA.

var formID = 'ss-form';
var labelName = 'ssTestLabel';
var testField = 'ssTestValue';
var submitted = false;

$(document).ready(function() {
 var ssForm = $('#'+formID);

 var randomInt1 = Math.floor((Math.random()*10)+1);
 var randomInt2 = Math.floor((Math.random()*10)+1);
 var answer = randomInt1+randomInt2;
 $('#'+labelName).text('Type the answer to ' + randomInt1 + ' plus ' + randomInt2 + ' before clicking "Submit" below.');

 ssForm.submit(function(evt){
  if($('#'+testField).val() == answer){
   // console.log('Value of "feedbackForm.formKey" function is:' + feedbackForm.formKey);
   ssForm.attr({'action' : 'https://docs.google.com/forms/d/' + feedbackForm.formKey + '/formResponse'});
   return true;
  }else{
   alert('You need to enter the answer to ' + randomInt1 + ' plus ' + randomInt2 + '.');
    return false;
  }
 });
});
