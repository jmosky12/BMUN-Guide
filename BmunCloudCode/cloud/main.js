
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
// after saving code, go to BmunCloudCode directory, then do "parse deploy; parse log -f"


var Mailgun = require('mailgun');
Mailgun.initialize('sandboxae90efa2a16346dd8c92a448942a4609.mailgun.org', 'key-70a1a312f441aeb0716c7f4f268c67ac');

Parse.Cloud.define("hello", function(request, response) {
  response.success("Hello world!");
});

Parse.Cloud.define("sendEmail", function(request, response) {
    var data = request.params;
    Mailgun.sendEmail({
        to: "feedback@bmun.org",
        from: data.email,
        subject: data.topic,
        text: data.body
    }, {
        success: function(httpResponse) {
        console.log(httpResponse);
        response.success("Email sent!");
    },
        error: function(httpResponse) {
        console.error(httpResponse);
        response.error("Uh oh, something went wrong");
    }
});
})
