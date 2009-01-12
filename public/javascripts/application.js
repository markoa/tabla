// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function authToken() {
  return 'authenticity_token=' + encodeURIComponent(AUTH_TOKEN);
}

function remote_get_link_to(ajaxPath, linkId) {
  Event.observe(linkId, 'click', function() {
    var link = new Element(linkId);
    new Ajax.Request(ajaxPath,
      { asynchronous: true, evalScripts: true, method: 'get',
        parameters: authToken()
      });
    return false;
  });
}
