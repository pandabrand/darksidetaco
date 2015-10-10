  $(function() {
  
    // Setup form validation on the #register-form element
    $("#location-form").validate({
    
        // Specify the validation rules
        rules: {
            first: "required",
            last: "required",
            add_one: "required",
            zip: "required",
            phone: {
                required: true,
                minlength: 12
            },
            email: {
                required: true,
                email: true
            },
        },
        
        // Specify the validation error messages
        messages: {
            firstname: "Please enter your first name",
            lastname: "Please enter your last name",
            phone: {
                required: "Please provide a phone number",
                minlength: "Your phone must be have area code and number"
            },
            email: "Please enter a valid email address",
            zip: "Please enter a zipcode",
            add_one: "Please enter an address",
        },
        
        submitHandler: function(form) {
            form.submit();
        }
    });

  });
 
