// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// gets authenticity token which is expected to be embedded in the page layout
function getAuthToken() {
  return 'authenticity_token=' + encodeURIComponent(AUTH_TOKEN);
}

function remote_get_link_to(ajaxPath, linkId) {
  $(linkId).href = '#';
  Event.observe(linkId, 'click', function() {
    new Ajax.Request(ajaxPath,
      { asynchronous: true, evalScripts: true, method: 'get',
        parameters: getAuthToken()
      });
    return false;
  });
}
